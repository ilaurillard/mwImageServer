import 'package:mwcdn/Etc/Console.dart';
import 'package:mwcdn/Model/Bucket.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/Api/Api.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Authentication {
  final SqliteStorage sqliteStorage;
  final String rootKey;

  Authentication({
    required this.sqliteStorage,
    required this.rootKey,
  });

  // ---------------------

  // Access to private resources
  Middleware privateAccess() {
    return (Handler handler) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';
        if (auth.isNotEmpty) {

          Console.info('[Auth]');

          if (auth == rootKey) {
            // static root key has full access
            return handler(request);
          }

          Token token = await sqliteStorage.tokens.load(auth);
          if (!token.valid()) {
            return Api.rUnauthorized(
              'Empty token',
            );
          }
          if (!token.keepLive(sqliteStorage)) {
            return Api.rUnauthorized(
              'Token expired',
            );
          }
          if (token.root) {
            // root token -> always full access
            return handler(request);
          }

          int bucketId = int.parse(request.params['bucket'] ?? '0');
          if (!Bucket.validId(bucketId)) {
            return Api.rBucketError();
          }

          Resource resource = await sqliteStorage.resources.load(
            bucketId,
            request.params['resource'] ?? '',
          );

          if (!resource.valid()) {
            return Api.rNotFound('Resource not found');
          }

          if (!token.accessResource(resource)) {
            return Api.rForbidden(
              'Forbidden',
            );
          }

          return handler(request);
        }

        return Api.rNotFound(
          'Not found',
        );
      };
    };
  }

  // ---------------------

  // General api access
  Middleware apiAccess() {
    return (
      Handler handler,
    ) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';

        if (auth.isNotEmpty) {
          if (auth == rootKey) {
            // static root key has full access
            return handler(request);
          }

          // loadToken
          Token token = await sqliteStorage.tokens.load(auth);
          if (!token.valid()) {
            // no token found
            return Api.rUnauthorized(
              'Token not found',
            );
          }
          if (!token.keepLive(sqliteStorage)) {
            return Api.rUnauthorized(
              'Token expired',
            );
          }

          if (token.root) {
            // root token -> always full access
            return handler(request);
          }

          int bucket = 0;
          String path = request.params['path'] ?? '';
          List<String> tmp = path.split('/');
          if (tmp.isNotEmpty && tmp[0] == 'bucket') {
            bucket = tmp.length > 1 ? int.parse(tmp[1]) : 0;
          }

          if (bucket > 0 && token.accessBucket(bucket)) {
            return handler(request);
          }

          return Api.rForbidden(
            'Forbidden',
          );
        }
        return Api.rUnauthorized(
          'Unauthorized',
        );
      };
    };
  }
}
