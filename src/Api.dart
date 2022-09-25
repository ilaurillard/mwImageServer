import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Authentication.dart';
import 'Config.dart';
import 'DataStore.dart';
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
            ..post(
              // /api/bucket/77/token
              '/bucket' + cfg.paramBucket + '/token',
              addToken,
            )
            ..post(
              // /api/token
              '/token',
              addToken,
            ),
        );
  }

  FutureOr<Response> addToken(
    Request request,
  ) async {
    // fix bucket
    int bucket = int.parse(request.params['bucket'] ?? '0');

    String tmp = await request.readAsString();
    Map<String, dynamic> data = json.decode(tmp);

    List<int> buckets = List<int>.from(data['buckets'] ?? []);

    if (bucket > 0) {
      data['root'] = false;
      if (buckets.isNotEmpty) {
        buckets = [bucket];
      }
    }

    Token token = await dataStore.createToken(
      bucket,
      users: List<int>.from(data['users'] ?? []),
      groups: List<int>.from(data['groups'] ?? []),
      buckets: buckets,
      root: data['root'] as bool? ?? false,
    );

    return Response.ok(
        json.encode(
          token.toJson(),
        ),
        headers: {'content-type': 'application/json'});
  }

  FutureOr<Response> addResource(
    Request request,
  ) {
    // create record in db

    int bucket = int.parse(request.params['bucket'] ?? '0');

    return Response.ok(
      'OK (addResource)',
    );
  }

  FutureOr<Response> addBucket(
    Request request,
  ) {
    // create folder

    return Response.ok(
      'OK (addBucket)',
    );
  }

  FutureOr<Response> bucket(
    Request request,
  ) {
    return Response.ok(
      "API - (isolate ${Isolate.current.hashCode}) " + request.method,
    );
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
