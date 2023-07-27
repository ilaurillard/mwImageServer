import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/Resource.dart';
import 'package:mwcdn/Model/Token.dart';
import 'package:mwcdn/Service/SqliteStorage.dart';
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
          if (auth == rootKey) {
            // static root key has full access
            return handler(request);
          }

          Token token = await sqliteStorage.loadToken(auth);
          if (!token.valid()) {
            return Response.unauthorized(
              'Empty token',
            );
          }
          if (!token.keepLive(sqliteStorage)) {
            return Response.unauthorized(
              'Token expired',
              headers: Config.jsonHeaders,
            );
          }
          if (token.root) {
            // root token -> full access
            return handler(request);
          }

          int bucketId = int.parse(request.params['bucket'] ?? '0');
          if (!Util.validBucket(bucketId)) {
            return Util.invalidBucket();
          }

          Resource resource = await sqliteStorage.loadResource(
            bucketId,
            request.params['resource'] ?? '',
          );

          if (!resource.valid()) {
            return Response.notFound('Resource not found');
          }

          if (!token.accessResource(resource)) {
            return Response.forbidden(
              'Forbidden',
            );
          }

          return handler(request);
        }

        return Response.notFound(
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
          Token token = await sqliteStorage.loadToken(auth);
          if (!token.valid()) {
            // no token found
            return Response.unauthorized(
              'Token not found',
              headers: Config.jsonHeaders,
            );
          }
          if (!token.keepLive(sqliteStorage)) {
            return Response.unauthorized(
              'Token expired',
              headers: Config.jsonHeaders,
            );
          }

          if (token.root) {
            // root token -> full access
            return handler(request);
          }

          int bucket = 0;
          String path = request.params['path'] ?? '';
          List<String> tmp = path.split('/');
          if (tmp.length > 0 && tmp[0] == 'bucket') {
            bucket = tmp.length > 1 ? int.parse(tmp[1]) : 0;
          }

          if (bucket > 0 && token.accessBucket(bucket)) {
            return handler(request);
          }

          return Response.forbidden(
            'Forbidden',
            headers: Config.jsonHeaders,
          );
        }
        return Response.unauthorized(
          'Unauthorized',
          headers: Config.jsonHeaders,
        );
      };
    };
  }
}
