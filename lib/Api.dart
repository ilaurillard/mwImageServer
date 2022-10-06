import 'package:mwcdn/Api/ApiBucket.dart';
import 'package:mwcdn/Api/ApiResource.dart';
import 'package:mwcdn/Api/ApiToken.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/Authentication.dart';
import 'package:mwcdn/Service/DataStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Api {
  final DataStorage dataStorage;
  final FileStorage fileStorage;

  Api({
    required this.dataStorage,
    required this.fileStorage,
  });

  Handler create() {
    ApiBucket apiBucket = ApiBucket(
      dataStorage: dataStorage,
      fileStorage: fileStorage,
    );
    ApiResource apiResource = ApiResource(
      dataStorage: dataStorage,
      fileStorage: fileStorage,
    );
    ApiToken apiToken = ApiToken(
      dataStorage: dataStorage,
    );

    return Pipeline()
        // --------- auth/security middleware
        .addMiddleware(
          Authentication(
            dataStorage: dataStorage,
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
              '/bucket' + Config.paramBucket, // /api/bucket/77
              apiBucket.show,
            )
            // ---------------------------- resource
            ..post(
              // /api/bucket/77/resource
              '/bucket' + Config.paramBucket + '/resource',
              apiResource.create,
            )
            ..post(
              '/bucket' +
                  Config.paramBucket +
                  '/resource' +
                  Config.paramResource +
                  '/flush',
              apiResource.flush,
            )
            ..all(
              '/bucket' +
                  Config.paramBucket +
                  '/resource' +
                  Config.paramResource,
              apiResource.crud,
            )
            // ---------------------------- token (customer/bucket)
            ..post(
              '/bucket' + Config.paramBucket + '/token', // /api/bucket/77/token
              apiToken.create,
            )
            ..get( // show bucket meta
              '/bucket' + Config.paramBucket + '/token' + Config.paramToken,
              apiToken.show,
            )
            // ---------------------------- token (root)
            ..post(
              '/token', // /api/token
              apiToken.create,
            )
            ..get( // show bucket meta
              '/token' + Config.paramToken,
              apiToken.show,
            ),
        );
  }

// return Response.ok(
//   // "API - (isolate ${Isolate.current.hashCode}) " + request.method,
//   json.encode({'id': bucket}),
//   headers: cfg.jsonHeaders,
// );
}
