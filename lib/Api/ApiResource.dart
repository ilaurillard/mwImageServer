import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

class ApiResource {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;

  ApiResource({
    required this.sqliteStorage,
    required this.fileStorage,
  });

  // ---------------------

  FutureOr<Response> flush(
    Request request,
  ) async {
    printInfo('[ApiResource.flush]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.rBucketError();
    }

    Resource resource = await sqliteStorage.resources.load(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Util.rNotFound('Resource not found');
    }

    bool successFiles = await fileStorage.flushResourceFiles(resource);
    if (!successFiles) {
      return Util.rError(
        'Remove files failed (${resource.path()})',
      );
    }

    return Response(200);
  }

  // ---------------------

  // Show, update, delete
  FutureOr<Response> crud(
    Request request,
  ) async {
    printInfo('[ApiResource.crud]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.rBucketError();
    }

    Resource resource = await sqliteStorage.resources.load(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Util.rNotFound('Resource not found');
    }

    if (request.method == 'GET') {
      return Util.rJsonOk(
        resource,
      );
    }
    if (request.method == 'DELETE') {
      bool successFiles = await fileStorage.deleteResourceFiles(resource);
      bool successRecord = await sqliteStorage.deleteEntity(resource);
      if (!successFiles || !successRecord) {
        return Util.rError(
          'Remove resource failed ($successRecord/$successFiles)',
        );
      }
      return Response(204);
    }
    if (request.method == 'POST') {
      bool wasPublic = resource.public();

      Dict data = await Util.jsonObject(request);
      resource.users = Util.intListData(data, 'users');
      resource.groups = Util.intListData(data, 'groups');

      if (resource.public() != wasPublic) {
        return Util.rError(
          'Cannot change a resource from pub to priv and vice versa',
        );
      }

      await sqliteStorage.resources.update(resource);

      return Util.rJsonOk(resource);
    }

    return Util.rBadRequest(
      'Method not available',
    );
  }

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {
    printInfo('[ApiResource.create]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.rBucketError();
    }

    if (!request.isMultipart) {
      return Util.rBadRequest('Must be multipart post');
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
        return Util.rBadRequest('Too many parts');
      }
    }
    if (mPartMeta == null) {
      return Util.rBadRequest('Missing meta part');
    }
    if (mPartFile == null) {
      return Util.rBadRequest('Missing file part');
    }

    // -------------- check mimetype, filename, ...

    KeyValue headersMeta = mPartMeta.headers;
    if (headersMeta['content-type'] != 'application/json') {
      return Util.rBadRequest('First part must be json');
    }

    KeyValue headersFile = mPartFile.headers;
    String mimeType = headersFile['content-type'] ?? '';
    if (!Config.acceptedTypes.contains(mimeType)) {
      return Util.rBadRequest('Mime type not accepted');
    }
    KeyValue disp = Util.parseContentDisposition(
      headersFile['content-disposition'] ?? '',
    );
    String filename = disp['filename'] ?? '';
    if (filename.isEmpty) {
      return Util.rBadRequest('No filename');
    }
    if (!Util.validFilename(filename)) {
      return Util.rBadRequest('Invalid filename');
    }
    if (!Util.validMimetype(filename, mimeType)) {
      return Util.rBadRequest('Mime type vs suffix error');
    }

    Uint8List partBytes = await mPartFile.readBytes();
    if (partBytes.isEmpty || partBytes.length > Config.maxFileSize) {
      return Util.rBadRequest(
        'Invalid file size',
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
      users: Util.intListData(data, 'users'),
      groups: Util.intListData(data, 'groups'),
    );

    if (await fileStorage.dirExists(resource.path())) {
      return Util.rError(
        'Fatal, resource collision',
      );
    }

    printNotice(resource.toString());

    // ------------------- Store file (async!)

    _storeFile(
      resource,
      partBytes,
    );

    // -------------------------

    return Util.rJsonOk(
      resource,
    );
  }

  void _storeFile(
    Resource resource,
    Uint8List bytes,
  ) async {
    try {
      File file = await fileStorage.createFile(
        '${resource.path()}/${resource.filename}',
        bytes,
      );
      int realSize = file.lengthSync();
      if (realSize != bytes.length) {
        throw 'length check failed ($realSize vs ${bytes.length})';
      }
    } catch (e) {
      Util.rError('File error: $e');
      // TODO append this error to database record
    }
  }
}
