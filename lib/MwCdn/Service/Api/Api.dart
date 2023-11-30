import 'package:mwcdn/MwCdn/Api/ApiBucket.dart';
import 'package:mwcdn/MwCdn/Api/ApiResource.dart';
import 'package:mwcdn/MwCdn/Api/ApiStats.dart';
import 'package:mwcdn/MwCdn/Api/ApiToken.dart';
import 'package:mwcdn/MwCdn/Config.dart';
import 'package:mwcdn/MwCdn/Service/Api/Authorization.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;
  final String rootKey;

  Api({
    required this.sqliteStorage,
    required this.fileStorage,
    required this.rootKey,
  });

  Handler create() {
    Authorization authorization = Authorization(
      sqliteStorage: sqliteStorage,
      rootKey: rootKey,
    );
    ApiBucket apiBucket = ApiBucket(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
    );
    ApiResource apiResource = ApiResource(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
      authorization: authorization,
    );
    ApiToken apiToken = ApiToken(
      sqliteStorage: sqliteStorage,
    );
    ApiStats apiStats = ApiStats(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
    );

    return Pipeline()
        // --------- auth/security middleware
        .addMiddleware(
          authorization.apiAccess(),
        )
        .addHandler(
          Router()
            // ----------------------------
            // ---------------------------- bucket
            // ----------------------------
            ..post(
              // add new bucket or update (POST)
              '/bucket', // /api/bucket
              apiBucket.store,
            )
            ..get(
              // info on bucket (GET)
              '/bucket${Config.matchBucket}', // /api/bucket/77
              apiBucket.show,
            )
            ..get(
              // more info on bucket (GET)
              '/bucket${Config.matchBucket}/stats', // /api/bucket/77/stats
              apiStats.bucket,
            )
            ..post(
              // create a method
              '/bucket${Config.matchBucket}/method',
              apiBucket.addMethod,
            )
            ..delete(
              // remove a method
              '/bucket${Config.matchBucket}/method${Config.matchMethod}',
              apiBucket.deleteMethod,
            )
            // ----------------------------
            // ---------------------------- resource
            // ----------------------------
            ..post(
              // create a resource
              // /api/bucket/77/resource
              '/bucket${Config.matchBucket}/resource',
              apiResource.create,
            )
            ..all(
              '/bucket${Config.matchBucket}/resource${Config.matchResource}',
              apiResource.crud,
            )
            ..post(
              // /api/bucket/77/resource/[resource]/flush
              '/bucket${Config.matchBucket}/resource${Config.matchResource}/flush',
              apiResource.flush,
            )
            ..post(
              '/bucket${Config.matchBucket}/resource${Config.matchResource}/pdf',
              apiResource.pdf,
            )
            // ----------------------------
            // ---------------------------- token (customer/bucket)
            // ----------------------------
            ..post(
              // /api/bucket/77/token
              '/bucket${Config.matchBucket}/token',
              apiToken.create,
            )
            ..get(
              // show token meta
              // /api/bucket/77/token/[token]
              '/bucket${Config.matchBucket}/token${Config.matchToken}',
              apiToken.show,
            )
            // ----------------------------
            // ---------------------------- root tokens (root only)
            // ----------------------------
            ..post(
              '/token', // /api/token
              apiToken.create,
            )
            ..get(
              // show token meta
              '/token${Config.matchToken}',
              apiToken.show,
            )
            ..get(
              '/stats',
              apiStats.all,
            ),
        );
  }
}
