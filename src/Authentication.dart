import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Config.dart';
import 'DataStore.dart';
import 'Model/Resource.dart';
import 'Model/Token.dart';

class Authentication {
  final Config cfg;
  final DataStore dataStore;

  Authentication({
    required this.cfg,
    required this.dataStore,
  });

  Middleware privateAccess() {
    return (Handler handler) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';
        if (auth.isNotEmpty) {
          if (auth == cfg.rootKey) {
            // static root key has full access
            return handler(request);
          }

          Token token = await dataStore.token(auth);
          if (token.empty()) {
            return Response.unauthorized(
              'Token not found',
            );
          }

          if (token.root) {
            // special root token -> full access
            return handler(request);
          }

          int bucket = int.parse(request.params['bucket'] ?? '0');

          Resource resource = await dataStore.resource(
            bucket,
            request.params['resource'] ?? '',
          );
          if (resource.empty()) {
            return Response.notFound(
              'Resource not found',
            );
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

  Middleware apiAccess() {
    return (
      Handler handler,
    ) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';
        if (auth.isNotEmpty) {
          if (auth == cfg.rootKey) {
            // static root key has full access
            return handler(request);
          }

          Token token = await dataStore.token(auth);
          if (token.empty()) {
            // no token found
            return Response.unauthorized(
              'Token not found',
              headers: cfg.jsonHeaders,
            );
          }

          if (token.root) {
            // special root token -> full access
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
            headers: cfg.jsonHeaders,
          );
        }
        return Response.unauthorized(
          'Unauthorized',
          headers: cfg.jsonHeaders,
        );
      };
    };
  }
}
