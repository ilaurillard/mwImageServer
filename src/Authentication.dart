import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'Config.dart';
import 'Storage.dart';

class Authentication {
  final Config config;
  final Storage storage;

  Authentication({
    required this.config,
    required this.storage,
  });

  Middleware privateAccess() {
    return (Handler innerHandler) {
      return (
        Request request,
      ) {
        String resource = request.params['resource'] ?? '';

        print(request.headers);
        // TODO check access to (ressource) for (authorization header) in database

        // return Response.notFound(
        //   'Not found',
        // );

        return innerHandler(request);
      };
    };
  }

  Middleware apiAccess() {
    return (
      Handler innerHandler,
    ) {
      return (
        Request request,
      ) {
        String auth = request.headers['authorization'] ?? '';
        if (auth == config.apiKey) {
          return innerHandler(request);
        }

        return Response.unauthorized(
          'Unauthorized',
        );
      };
    };
  }
}
