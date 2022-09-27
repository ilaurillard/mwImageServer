import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:shelf/shelf.dart';
import 'package:shelf_multipart/multipart.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Authentication.dart';
import 'Config.dart';
import 'DataStore.dart';
import 'Model/Bucket.dart';
import 'Model/JsonSerializable.dart';
import 'Model/Resource.dart';
import 'Model/Token.dart';
import 'Types.dart';
import 'Util.dart';

class Api {
  final Config cfg;
  final DataStore dataStore;

  Api({
    required this.cfg,
    required this.dataStore,
  });

  Handler create() {
    return Pipeline()
        .addMiddleware(
          Authentication(
            cfg: cfg,
            dataStore: dataStore,
          ).apiAccess(),
        )
        .addHandler(
          Router()
            ..post(
              // add new (POST)
              '/bucket', // /api/bucket
              createBucket,
            )
            ..get(
              // info (GET)
              '/bucket' + cfg.paramBucket, // /api/bucket/77
              showBucket,
            )
            ..post(
              // /api/bucket/77/resource
              '/bucket' + cfg.paramBucket + '/resource',
              createResource,
            )
            ..get(
              '/bucket' + cfg.paramBucket + '/resource' + cfg.paramRes,
              showResource,
            )
            ..post(
              '/bucket' + cfg.paramBucket + '/token', // /api/bucket/77/token
              createToken,
            )
            ..get(
              '/bucket' + cfg.paramBucket + '/token' + cfg.paramToken,
              showToken,
            )
            ..post(
              '/token', // /api/token
              createToken,
            )
            ..get(
              '/token' + cfg.paramToken,
              showToken,
            ),
        );
  }

  // -----------------

  FutureOr<Response> createToken(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Dict data = await jsonObject(request);

    bool root = data['root'] as bool? ?? false;

    List<int> buckets = List<int>.from(data['buckets'] ?? []);

    if (bucket > 0) {
      // only !root tokens in bucket
      root = false;
      if (buckets.isNotEmpty) {
        // no access to other buckets
        buckets = [bucket];
      }
    }

    Token token = await dataStore.createToken(
      bucket,
      users: List<int>.from(data['users'] ?? []),
      groups: List<int>.from(data['groups'] ?? []),
      buckets: buckets,
      root: root,
    );

    return jsonResponse(
      token,
    );
  }

  // -----------------

  FutureOr<Response> createResource(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');
    if (bucket < 1) {
      return Response.badRequest();
    }
    if (!request.isMultipart) {
      return Response.badRequest();
    }

    Multipart? mPartMeta;
    Multipart? mPartFile;
    await for (Multipart mPart in request.parts) {
      if (mPartMeta == null) {
        mPartMeta = mPart;
      } else if (mPartFile == null) {
        mPartFile = mPart;
      }
    }
    if (mPartMeta == null || mPartFile == null) {
      return Response.badRequest();
    }

    KeyValue headersMeta = mPartMeta.headers;
    if (headersMeta['content-type'] != 'application/json') {
      return Response.badRequest();
    }

    KeyValue headersFile = mPartFile.headers;
    String mimeType = headersFile['content-type'] ?? '';
    if (!cfg.acceptedTypes.contains(mimeType)) {
      return Response.badRequest();
    }

    KeyValue disp = Util.parseContentDisposition(
      headersFile['content-disposition'] ?? '',
    );
    String filename = disp['filename'] ?? '';
    if (filename.isEmpty) {
      return Response.badRequest();
    }

    // TODO sanitize/check filename suffix fits mimetype
    // print(mimeType);
    // print(filename);

    String partData = await mPartMeta.readString();
    Dict data = json.decode(partData);
    Resource resource = await dataStore.createResource(
      bucket,
      filename: filename,
      users: List<int>.from(data['users'] ?? []),
      groups: List<int>.from(data['groups'] ?? []),
    );

    String path = cfg.dataDir + '/' + resource.path();

    // check if folder exists (collisions)
    if (await Directory(path).exists()) {
      return Response(409);
    }

    Uint8List partBytes = await mPartFile.readBytes();
    if (partBytes.length > 0) {
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
      return Response.badRequest();
    }

    return jsonResponse(
      resource,
    );
  }

  // -----------------

  FutureOr<Response> createBucket(
    Request request,
  ) async {
    // create folder

    Dict data = await jsonObject(request);

    int bucket = data['id'] as int? ?? 0;
    if (bucket < 1) {
      return Response.badRequest();
    }

    // TODO create folders
    // cfg.dataDir

    // await Future.delayed(Duration(milliseconds: 100));

    return jsonResponse(
      Bucket(
        bucket,
      ),
    );
  }

  // -----------------

  FutureOr<Response> showBucket(
    Request request,
  ) {
    int bucket = int.parse(request.params['bucket'] ?? '0');
    if (bucket < 1) {
      return Response.badRequest();
    }

    // TODO check existance of folders

    String p = cfg.dataDir + '/public/' + bucket.toString();
    print(p);

    return jsonResponse(
      Bucket(
        bucket,
      ),
    );

    // return Response.ok(
    //   // "API - (isolate ${Isolate.current.hashCode}) " + request.method,
    //   json.encode({'id': bucket}),
    //   headers: cfg.jsonHeaders,
    // );
  }

  // -----------------

  FutureOr<Response> showResource(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');
    if (bucket < 1) {
      return Response.badRequest();
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

    return jsonResponse(
      resource,
    );
  }

  // -----------------

  FutureOr<Response> showToken(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Token token = await dataStore.token(
      request.params['token'] ?? '',
    );
    if (token.empty()) {
      return Response.notFound(
        'Token not found',
      );
    }

    if (bucket > 0 && token.bucket != bucket) {
      return Response.forbidden(
        'Forbidden',
      );
    }

    return jsonResponse(
      token,
    );
  }

  // --------------

  Response jsonResponse(
    JsonSerializable subject,
  ) {
    return Response.ok(
      json.encode(subject.toJson()),
      headers: cfg.jsonHeaders,
    );
  }

  Future<Dict> jsonObject(
    Request request,
  ) async {
    String tmp = await request.readAsString();
    return json.decode(tmp);
  }
}

/*

 /api/bucket
 /api/bucket/77
 /api/bucket/77/token
 /api/bucket/77/token/aaaabbbbccccddddaaaabbbbccccdddd
 /api/bucket/77/converter
 /api/bucket/77/converter/thumb1
 /api/bucket/77/resource
 /api/bucket/77/resource/aaaabbbbccccddddaaaabbbbccccdddd
 /api/bucket/77/resource/aaaabbbbccccddddaaaabbbbccccdddd/access

 /api/token
 /api/token/aaaabbbbccccddddaaaabbbbccccdddd

 */
