import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Etc/Files.dart';
import 'package:mwcdn/Etc/ResponseException.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Api/Authorization.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/Service/Work/Pdf/Pdf.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiResource {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;
  final Authorization authorization;

  ApiResource({
    required this.sqliteStorage,
    required this.fileStorage,
    required this.authorization,
  });

  // ---------------------

  FutureOr<Response> pdf(
    Request request,
  ) async {
    Console.info('[ApiResource.pdf]');

    Resource resource = await _resourceFromRequest(request);
    if (!resource.valid()) {
      return Api.rNotFound(message: 'Resource not found');
    }

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Bucket.validId(bucketId)) {
      bucketId = 0;
    }

    String auth = request.headers['authorization'] ?? '';
    Token token = await authorization.tokenForAuth(auth);

    Dict data = await Api.incomingJson(request);

    // try {
    //   Uint8List binary = await (Pdf(
    //     sqliteStorage: sqliteStorage,
    //     fileStorage: fileStorage,
    //   )).build(
    //     data,
    //     resource,
    //   );
    //   return Response.ok(
    //     binary,
    //     headers: Config.pdfHeaders,
    //   );
    // } on ResponseException catch (e) {
    //   return e.response;
    // } on Exception catch (e) {
    //   return Api.rError(
    //     message: e.toString(),
    //   );
    // }

    try {
      Resource pdfResource = await (Pdf(
        sqliteStorage: sqliteStorage,
        fileStorage: fileStorage,
        bucketId: bucketId,
        token: token,
      )).buildResource(
        data,
        resource,
      );

      return Api.rJsonOk(pdfResource);
    } on ResponseException catch (e) {
      return e.response;
    } on Exception catch (e) {
      return Api.rError(
        message: e.toString(),
      );
    }
  }

  // ---------------------

  // delete all files for resource, except original
  FutureOr<Response> flush(
    Request request,
  ) async {
    Console.info('[ApiResource.flush]');

    Resource resource = await _resourceFromRequest(request);
    if (!resource.valid()) {
      return Api.rNotFound(message: 'Resource not found');
    }

    bool successFiles = await fileStorage.flushResourceFiles(resource);
    if (!successFiles) {
      return Api.rError(
        message: 'Remove files failed (${resource.path()})',
      );
    }

    return Response(200);
  }

  // ---------------------

  // Show, update, delete
  FutureOr<Response> crud(
    Request request,
  ) async {
    Console.info('[ApiResource.crud]');

    Resource resource = await _resourceFromRequest(request);
    if (!resource.valid()) {
      return Api.rNotFound(message: 'Resource not found');
    }

    if (request.method == 'GET') {
      return Api.rJsonOk(
        resource,
      );
    } else if (request.method == 'DELETE') {
      bool successFiles = await fileStorage.deleteResourceFiles(resource);
      bool successRecord = await sqliteStorage.deleteEntity(resource);
      if (!successFiles || !successRecord) {
        return Api.rError(
          message: 'Remove resource failed ($successRecord/$successFiles)',
        );
      }
      return Response(204);
    } else if (request.method == 'POST') {
      bool wasPublic = resource.public();

      Dict data = await Api.incomingJson(request);
      resource.users = Types.idListFromDict(data, 'users');
      resource.groups = Types.idListFromDict(data, 'groups');

      if (resource.public() != wasPublic) {
        return Api.rError(
          message: 'Cannot change a resource from pub to priv and vice versa',
        );
      }
      await sqliteStorage.resources.update(resource);
      return Api.rJsonOk(resource);
    }

    return Api.rBadRequest(
      message: 'Method not available',
    );
  }

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
    Console.info('[ApiResource.create]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Bucket.validId(bucketId)) {
      return Api.rBucketError();
    }

    if (!request.isMultipart) {
      return Api.rBadRequest(message: 'Must be multipart post');
    }

    // ------------------- payload

    Multipart? mPartMeta;
    Multipart? mPartFile;
    await for (Multipart mPart in request.parts) {
      if (mPartMeta == null) {
        mPartMeta = mPart;
      } else if (mPartFile == null) {
        mPartFile = mPart;
      } else {
        return Api.rBadRequest(message: 'Too many parts');
      }
    }
    if (mPartMeta == null) {
      return Api.rBadRequest(message: 'Missing meta part');
    }
    if (mPartFile == null) {
      return Api.rBadRequest(message: 'Missing file part');
    }

    // -------------- check mimetype, filename, ...

    KeyValue headersMeta = mPartMeta.headers;
    if (headersMeta['content-type'] != 'application/json') {
      return Api.rBadRequest(message: 'First part must be json');
    }

    KeyValue headersFile = mPartFile.headers;
    String mimeType = headersFile['content-type'] ?? '';
    if (!Config.acceptedTypes.contains(mimeType)) {
      return Api.rBadRequest(message: 'Mime type not accepted');
    }
    KeyValue disp = Files.parseContentDisposition(
      headersFile['content-disposition'] ?? '',
    );
    String filename = disp['filename'] ?? '';
    if (filename.isEmpty) {
      return Api.rBadRequest(message: 'No filename');
    }
    if (!Files.validFilename(filename)) {
      return Api.rBadRequest(message: 'Invalid filename');
    }
    if (!Files.validMimetype(filename, mimeType)) {
      return Api.rBadRequest(message: 'Mime type vs suffix error');
    }

    Uint8List partBytes = await mPartFile.readBytes();
    if (partBytes.isEmpty || partBytes.length > Config.maxFileSize) {
      return Api.rBadRequest(
        message: 'Invalid file size',
      );
    }

    // ------------------- Create record (need sequence/id for path)

    String partData = await mPartMeta.readString();
    Dict data = json.decode(partData) as Dict;
    Resource resource = await sqliteStorage.resources.create(
      bucketId,
      filename: filename,
      mimeType: mimeType,
      size: partBytes.length,
      users: Types.idListFromDict(data, 'users'),
      groups: Types.idListFromDict(data, 'groups'),
    );
    Console.notice(resource.toString());

    if (await fileStorage.dirExists(resource.path())) {
      return Api.rError(
        message: 'Fatal, resource collision',
      );
    }

    // ------------------- Store file (async!)
    try {
      fileStorage.storeResource(
        resource,
        partBytes,
      );
    } catch (e) {
      Api.rError(message: 'File error: $e');
      // TODO append this error to database record
    }

    // -------------------------
    return Api.rJsonOk(
      resource,
    );
  }

  Future<Resource> _resourceFromRequest(
    Request request,
  ) async {
    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Bucket.validId(bucketId)) {
      bucketId = 0;
    }
    return await sqliteStorage.resources.load(
      bucketId,
      request.params['resource'] ?? '',
    );
  }
}
