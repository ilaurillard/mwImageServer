import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Config.dart';
import '../DataStore.dart';
import '../Model/Resource.dart';
import '../Types.dart';
import '../Util.dart';

class ApiResource {
  final DataStore dataStore;

  ApiResource({
    required this.dataStore,
  });

  FutureOr<Response> show(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');
    if (bucket < 1 || bucket > 999999999) {
      return Response.badRequest(body: 'Invalid bucket');
    }

    Resource resource = await dataStore.resource(
      bucket,
      request.params['resource'] ?? '',
    );
    if (resource.empty()) {
      return Response.notFound(
        'Resource not found',
      );
    }

    return Util.jsonResponse(
      resource,
    );
  }

  FutureOr<Response> create(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');
    if (bucket < 1 || bucket > 999999999) {
      return Response.badRequest(body: 'Invalid bucket');
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
    if (!Util.checkFilename(filename)) {
      return Response.badRequest(body: 'Invalid filename');
    }
    if (!Util.mimetypeVsSuffix(filename, mimeType)) {
      return Response.badRequest(body: 'Mime type vs suffix error');
    }

    // -------------------

    String partData = await mPartMeta.readString();
    Dict data = json.decode(partData);
    Resource resource = await dataStore.createResource(
      bucket,
      filename: filename,
      users: Util.intListData(data, 'users'),
      groups: Util.intListData(data, 'groups'),
    );

    String path = Config.dataDir + '/' + resource.path();

    if (await Directory(path).exists()) {
      return Response.internalServerError(body: 'Resource collision');
    }

    // -------------------

    Uint8List partBytes = await mPartFile.readBytes();
    if (partBytes.length > 0 && partBytes.length < Config.maxFileSize) {
      print(
        'Store ' +
            partBytes.length.toString() +
            ' bytes to ' +
            path +
            '/' +
            resource.filename,
      );

      File f = await File(path + '/' + resource.filename).create(
        recursive: true,
      );
      f.writeAsBytes(partBytes);

    } else {
      return Response.badRequest(body: 'Invalid file size');
    }

    return Util.jsonResponse(
      resource,
    );
  }
}
