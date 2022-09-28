import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Api/ApiBucket.dart';
import 'Api/ApiResource.dart';
import 'Api/ApiToken.dart';
import 'Authentication.dart';
import 'Config.dart';
import 'DataStore.dart';

class Api {
  final DataStore dataStore;

  Api({
    required this.dataStore,
  });

  Handler create() {
    ApiBucket apiBucket = ApiBucket(dataStore: dataStore);
    ApiResource apiResource = ApiResource(dataStore: dataStore);
    ApiToken apiToken = ApiToken(dataStore: dataStore);

    return Pipeline()
        .addMiddleware(
          Authentication(
            dataStore: dataStore,
          ).apiAccess(),
        )
        .addHandler(
          Router()
            ..post(
              // add new (POST)
              '/bucket', // /api/bucket
              apiBucket.create,
            )
            ..get(
              // info (GET)
              '/bucket' + Config.paramBucket, // /api/bucket/77
              apiBucket.show,
            )
            ..post(
              // /api/bucket/77/resource
              '/bucket' + Config.paramBucket + '/resource',
              apiResource.create,
            )
            ..get(
              '/bucket' + Config.paramBucket + '/resource' + Config.paramRes,
              apiResource.show,
            )
            ..post(
              '/bucket' + Config.paramBucket + '/token', // /api/bucket/77/token
              apiToken.create,
            )
            ..get(
              '/bucket' + Config.paramBucket + '/token' + Config.paramToken,
              apiToken.show,
            )
            ..post(
              '/token', // /api/token
              apiToken.create,
            )
            ..get(
              '/token' + Config.paramToken,
              apiToken.show,
            ),
        );
  }
}
