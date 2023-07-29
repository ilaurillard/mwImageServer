import 'package:mwcdn/Api/ApiBucket.dart';
import 'package:mwcdn/Api/ApiResource.dart';
import 'package:mwcdn/Api/ApiToken.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Service/Authentication.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
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
    ApiBucket apiBucket = ApiBucket(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
    );
    ApiResource apiResource = ApiResource(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
    );
    ApiToken apiToken = ApiToken(
      sqliteStorage: sqliteStorage,
    );

    return Pipeline()
        // --------- auth/security middleware
        .addMiddleware(
          Authentication(
            sqliteStorage: sqliteStorage,
            rootKey: rootKey,
          ).apiAccess(),
        )
        .addHandler(
          Router()
            // ---------------------------- bucket
            ..post(
              // add new bucket (POST)
              '/bucket', // /api/bucket
              apiBucket.create,
            )
            ..get(
              // info on bucket (GET)
              '/bucket' + Config.matchBucket, // /api/bucket/77
              apiBucket.show,
            )
            ..get(
              '/bucket' + Config.matchBucket + '/stats',
              apiBucket.stats,
            )
            ..post(
              '/bucket' + Config.matchBucket + '/method',
              apiBucket.addMethod,
            )
            ..delete(
              '/bucket' + Config.matchBucket + '/method' + Config.matchMethod,
              apiBucket.deleteMethod,
            )
            // ---------------------------- resource
            ..post(
              // /api/bucket/77/resource
              '/bucket' + Config.matchBucket + '/resource',
              apiResource.create,
            )
            ..post(
              '/bucket' +
                  Config.matchBucket +
                  '/resource' +
                  Config.matchResource +
                  '/flush',
              apiResource.flush,
            )
            ..all(
              '/bucket' +
                  Config.matchBucket +
                  '/resource' +
                  Config.matchResource,
              apiResource.crud,
            )
            // ---------------------------- token (customer/bucket)
            ..post(
              '/bucket' + Config.matchBucket + '/token', // /api/bucket/77/token
              apiToken.create,
            )
            ..get( // show token meta
              '/bucket' + Config.matchBucket + '/token' + Config.matchToken,
              apiToken.show,
            )
            // ---------------------------- token (root only)
            ..post(
              '/token', // /api/token
              apiToken.create,
            )
            ..get( // show token meta
              '/token' + Config.matchToken,
              apiToken.show,
            ),
        );
  }
}
