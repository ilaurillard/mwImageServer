import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwCdn/Model/Bucket.dart';
import 'package:mwcdn/MwCdn/Model/Resource.dart';
import 'package:mwcdn/MwCdn/Model/Token.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class Authorization {
  final SqliteStorage sqliteStorage;
  final String rootKey;

  Authorization({
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

          // -------------------
          Token token = await tokenForAuth(auth);
          if (!token.valid()) {
            return Util.rUnauthorized(
              message: 'Token not found',
            );
          }
          if (!token.keepLive(sqliteStorage)) {
            return Util.rUnauthorized(
              message: 'Token expired',
            );
          }
          if (token.root) {
            return handler(request);
          }
          // -------------------

          int bucketId = int.parse(request.params['bucket'] ?? '0');
          if (!Bucket.validId(bucketId)) {
            return Util.rBucketError();
          }

          Resource resource = await sqliteStorage.resources.load(
            bucketId,
            request.params['resource'] ?? '',
          );
          if (!resource.valid()) {
            return Util.rNotFound(message: 'Resource not found');
          }
          if (!token.accessResource(resource)) {
            return Util.rForbidden();
          }

          return handler(request);
        }

        return Util.rNotFound();
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
          // -------------------
          Token token = await tokenForAuth(auth);
          if (!token.valid()) {
            return Util.rUnauthorized(
              message: 'Token not found',
            );
          }
          if (!token.keepLive(sqliteStorage)) {
            return Util.rUnauthorized(
              message: 'Token expired',
            );
          }
          if (token.root) {
            return handler(request);
          }
          // -------------------

          int bucket = 0;
          String path = request.params['path'] ?? '';
          List<String> tmp = path.split('/');
          if (tmp.isNotEmpty && tmp[0] == 'bucket') {
            bucket = tmp.length > 1 ? int.parse(tmp[1]) : 0;
          }

          if (bucket > 0 && token.accessBucket(bucket)) {
            return handler(request);
          }

          return Util.rForbidden();
        }
        return Util.rUnauthorized();
      };
    };
  }

  // ----

  Future<Token> tokenForAuth(
    String auth,
  ) async {
    if (auth.isNotEmpty) {
      if (auth == rootKey) {
        return Token.root();
      } else {
        return await sqliteStorage.tokens.load(auth);
      }
    }
    return Token.empty();
  }
}
