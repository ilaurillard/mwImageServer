import 'package:mwcdn/Api/ApiBucket.dart';
import 'package:mwcdn/Api/ApiResource.dart';
import 'package:mwcdn/Api/ApiToken.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/Authentication.dart';
import 'package:mwcdn/Service/DataStore.dart';
import 'package:mwcdn/Service/FileStore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Routing {
  final DataStore dataStore;
  final FileStore fileStore;

  Routing({
    required this.dataStore,
    required this.fileStore,
  });

  Handler create() {
    ApiBucket apiBucket = ApiBucket(
      dataStore: dataStore,
      fileStore: fileStore,
    );
    ApiResource apiResource = ApiResource(
      dataStore: dataStore,
      fileStore: fileStore,
    );
    ApiToken apiToken = ApiToken(
      dataStore: dataStore,
    );

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
            ..all(
              '/bucket' + Config.paramBucket + '/resource' + Config.paramRes,
              apiResource.crud,
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
