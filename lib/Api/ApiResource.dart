import 'dart:async';
import 'dart:convert';
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
        'Remove files failed (' + resource.path() + ')',
      );
    }

    return Response(200);
  }

  // ---------------------

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
    } else if (request.method == 'DELETE') {

      bool successFiles = await fileStorage.deleteResourceFiles(resource);
      bool successRecord = await sqliteStorage.deleteEntity(resource);

      if (!successFiles || !successRecord) {
        return Util.rError(
          'Remove resource failed',
        );
      }

      return Response(204);
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
    if (mPartMeta == null || mPartFile == null) {
      return Util.rBadRequest('Missing parts');
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

    // ------------------- create record

    String partData = await mPartMeta.readString();
    Dict data = json.decode(partData) as Dict;
    Resource resource = await sqliteStorage.resources.create(
      bucketId,
      filename: filename,
      users: Util.intListData(data, 'users'),
      groups: Util.intListData(data, 'groups'),
    );

    String path = resource.path();

    if (await fileStorage.dirExists(path)) {
      return Util.rError(
        'Resource collision',
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
      return Util.rBadRequest(
        'Invalid file size',
      );
    }

    printNotice(resource.toString());

    return Util.rJsonOk(
      resource,
    );
  }
}
