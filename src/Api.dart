import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Authentication.dart';
import 'Config.dart';
import 'DataStore.dart';
import 'Model/Resource.dart';
import 'Model/Token.dart';

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
              // /api/bucket
              '/bucket',
              addBucket,
            )
            ..all(
              // info (GET), remove (DELETE), update?
              // /api/bucket/77
              '/bucket' + cfg.paramBucket,
              bucket,
            )
            ..post(
              // /api/bucket/77/resource
              '/bucket' + cfg.paramBucket + '/resource',
              addResource,
            )
            ..all(
              '/bucket' + cfg.paramBucket + '/resource' + cfg.paramRes,
              resource,
            )
            ..post(
              // /api/bucket/77/token
              '/bucket' + cfg.paramBucket + '/token',
              addToken,
            )
            ..all(
              '/bucket' + cfg.paramBucket + '/token' + cfg.paramToken,
              token,
            )
            ..post(
              // /api/token
              '/token',
              addToken,
            )
            ..all(
              '/token' + cfg.paramToken,
              token,
            ),
        );
  }

  // -----------------

  FutureOr<Response> addToken(
    Request request,
  ) async {
    // fix bucket
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Map<String, dynamic> data = await jsonObject(request);

    bool root = data['root'] as bool? ?? false;

    List<int> buckets = List<int>.from(data['buckets'] ?? []);

    // if (bucket == 0 && !root) {
    //   print('XXX');
    // }

    if (bucket > 0) { // only !root tokens in bucket
      root = false;
      if (buckets.isNotEmpty) { // no access to other buckets
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

    return Response.ok(
      json.encode(
        token.toJson(),
      ),
      headers: cfg.jsonHeaders,
    );
  }

  // -----------------

  FutureOr<Response> addResource(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Map<String, dynamic> data = await jsonObject(request);

    Resource resource = await dataStore.createResource(
      bucket,
      users: List<int>.from(data['users'] ?? []),
      groups: List<int>.from(data['groups'] ?? []),
    );

    return Response.ok(
      json.encode(
        resource.toJson(),
      ),
      headers: cfg.jsonHeaders,
    );
  }

  // -----------------

  FutureOr<Response> addBucket(
    Request request,
  ) async {
    // create folder

    Map<String, dynamic> data = await jsonObject(request);

    // cfg.dataDir

    // await Future.delayed(Duration(milliseconds: 100));

    return Response.ok(
      'OK (addBucket)',
      headers: cfg.jsonHeaders,
    );
  }

  // -----------------

  FutureOr<Response> bucket(
    Request request,
  ) {
    int bucket = int.parse(request.params['bucket'] ?? '0');



    return Response.ok(
      // "API - (isolate ${Isolate.current.hashCode}) " + request.method,
      json.encode({
        'id': bucket
      }),
      headers: cfg.jsonHeaders,
    );
  }

  // -----------------

  FutureOr<Response> resource(
    Request request,
  ) async {
    int bucket = int.parse(request.params['bucket'] ?? '0');

    Resource resource = await dataStore.resource(
      bucket,
      request.params['resource'] ?? '',
    );
    if (resource.empty()) {
      return Response.notFound(
        'Resource not found (3)',
      );
    }

    return Response.ok(
      json.encode(resource.toJson()),
      headers: cfg.jsonHeaders,
    );
  }

  // -----------------

  FutureOr<Response> token(
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

    return Response.ok(
      json.encode(token.toJson()),
      headers: cfg.jsonHeaders,
    );
  }

  // --------------

  Future<Map<String, dynamic>> jsonObject(
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
