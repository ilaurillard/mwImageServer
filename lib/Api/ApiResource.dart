import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Service/SqliteStorage.dart';
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

    print('[ApiResource.flush]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.invalidBucket();
    }

    Resource resource = await sqliteStorage.loadResource(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Response.notFound('Resource not found');
    }

    bool successFiles = await fileStorage.flushResourceFiles(resource);
    if (!successFiles) {
      return Response.internalServerError(
        body: 'Remove files failed (' + resource.path() + ')',
      );
    }

    return Response(200);
  }

  // ---------------------

  FutureOr<Response> crud(
    Request request,
  ) async {

    print('[ApiResource.crud]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.invalidBucket();
    }

    Resource resource = await sqliteStorage.loadResource(
      bucketId,
      request.params['resource'] ?? '',
    );
    if (!resource.valid()) {
      return Response.notFound('Resource not found');
    }

    if (request.method == 'GET') {
      return Util.jsonResponse(
        resource,
      );
    } else if (request.method == 'DELETE') {

      bool successFiles = await fileStorage.deleteResourceFiles(resource);
      bool successRecord = await sqliteStorage.deleteEntity(resource);

      if (!successFiles || !successRecord) {
        return Response.internalServerError(
          body: 'Remove resource failed',
        );
      }

      return Response(204);
    }

    return Response.badRequest(
      body: 'Method not available',
    );
  }

  // ---------------------

  FutureOr<Response> create(
    Request request,
  ) async {

    print('[ApiResource.create]');

    int bucketId = int.parse(request.params['bucket'] ?? '0');
    if (!Util.validBucket(bucketId)) {
      return Util.invalidBucket();
    }

    if (!request.isMultipart) {
      return Response.badRequest(body: 'Must be multipart post');
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
        return Response.badRequest(body: 'Too many parts');
      }
    }
    if (mPartMeta == null || mPartFile == null) {
      return Response.badRequest(body: 'Missing parts');
    }

    // -------------- check mimetype, filename, ...

    KeyValue headersMeta = mPartMeta.headers;
    if (headersMeta['content-type'] != 'application/json') {
      return Response.badRequest(body: 'First part must be json');
    }

    KeyValue headersFile = mPartFile.headers;
    String mimeType = headersFile['content-type'] ?? '';
    if (!Config.acceptedTypes.contains(mimeType)) {
      return Response.badRequest(body: 'Mime type not accepted');
    }
    KeyValue disp = Util.parseContentDisposition(
      headersFile['content-disposition'] ?? '',
    );
    String filename = disp['filename'] ?? '';
    if (filename.isEmpty) {
      return Response.badRequest(body: 'No filename');
    }
    if (!Util.validFilename(filename)) {
      return Response.badRequest(body: 'Invalid filename');
    }
    if (!Util.validMimetype(filename, mimeType)) {
      return Response.badRequest(body: 'Mime type vs suffix error');
    }

    // ------------------- create record

    String partData = await mPartMeta.readString();
    Dict data = json.decode(partData) as Dict;
    Resource resource = await sqliteStorage.createResource(
      bucketId,
      filename: filename,
      users: Util.intListData(data, 'users'),
      groups: Util.intListData(data, 'groups'),
    );

    String path = resource.path();

    if (await fileStorage.dirExists(path)) {
      return Response.internalServerError(
        body: 'Resource collision',
      );
    }

    // ------------------- Store file

    Uint8List partBytes = await mPartFile.readBytes();
    if (partBytes.length > 0 && partBytes.length < Config.maxFileSize) {
      fileStorage.createFile(
        path + '/' + resource.filename,
        partBytes,
      );
    } else {
      return Response.badRequest(
        body: 'Invalid file size',
      );
    }

    return Util.jsonResponse(
      resource,
    );
  }
}
