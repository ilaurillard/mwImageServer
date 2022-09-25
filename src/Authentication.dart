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
    return (Handler innerHandler) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';
        if (auth.isNotEmpty) {
          if (auth == cfg.rootKey) {
            return innerHandler(request);
          }

          Token token = await dataStore.token(auth);
          if (token.empty()) {
            return Response.unauthorized(
              'token not found',
            );
          }

          Resource resource =
              dataStore.resource(request.params['resource'] ?? '');
          if (resource.empty()) {
            return Response.notFound(
              'resource not found',
            );
          }

          // print(token.toString());
          // print(resource.toString());

          if (!token.accessResource(resource)) {
            return Response.forbidden(
              'forbidden',
            );
          }

          return innerHandler(request);
        }
        return Response.notFound(
          'Not found',
        );
      };
    };
  }

  Middleware apiAccess() {
    return (
      Handler innerHandler,
    ) {
      return (
        Request request,
      ) async {
        String auth = request.headers['authorization'] ?? '';
        if (auth.isNotEmpty) {
          if (auth == cfg.rootKey) { // static root key has full access
            return innerHandler(request);
          }

          Token token = await dataStore.token(auth);
          if (token.empty()) { // no token found
            return Response.unauthorized(
              'Token not found',
            );
          }

          if (token.root) { // special root token -> full access
            return innerHandler(request);
          }

          int bucket = 0;
          String path = request.params['path'] ?? '';
          List<String> tmp = path.split('/');
          if (tmp.length > 0 && tmp[0] == 'bucket') {
            bucket = tmp.length > 1 ? int.parse(tmp[1]) : 0;
          }

          // print(bucket);
          // print(token);

          if (bucket > 0 && token.accessBucket(bucket)) {
            return innerHandler(request);
          }



        }
        return Response.unauthorized(
          'Unauthorized',
        );
      };
    };
  }
}
