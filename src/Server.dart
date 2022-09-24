import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart' as shelf_router;
import 'package:shelf_static/shelf_static.dart' as shelf_static;

import 'Config.dart';

class Server {
  final Config config;

  Server({
    required this.config,
  });

  Future<Null> start(
    List args,
  ) async {
    final HttpServer server = await HttpServer.bind(
      InternetAddress.anyIPv4, // 0.0.0.0
      8080,
      shared: true, // for isolates
    );

    final shelf_router.Router app = shelf_router.Router()
      // PUBLIC ----------------------
      ..get(
        '/public/<i|[a-f0-9]{2}>/<[a-f0-9]{2}>/<resource|[a-f0-9]{32}>/<ignored|.*>',
        shelf_static.createStaticHandler(
          config.dataDir,
        ),
      )
      // PRIVATE ----------------------
      ..get(
        '/private/<i|[a-f0-9]{2}>/<[a-f0-9]{2}>/<resource|[a-f0-9]{32}>/<ignored|.*>',
        shelf.Pipeline().addMiddleware(
          (shelf.Handler innerHandler) {
            return (
              shelf.Request request,
            ) {
              String resource = request.params['resource'] ?? '';

              print(request.headers);
              // TODO check access to (ressource) for (authorization header) in database

              // return shelf.Response.notFound(
              //   'Not found',
              // );

              return innerHandler(request);
            };
          },
        ).addHandler(
          shelf_static.createStaticHandler(
            config.dataDir,
          ),
        ),
      )
      // API ----------------------
      ..get(
        '/api/<ignored|.*>',
        shelf.Pipeline().addMiddleware(
          (shelf.Handler innerHandler) {
            return (
              shelf.Request request,
            ) {
              print(request.headers);
              // TODO check static api key (authorization header)

              return innerHandler(request);
            };
          },
        ).addHandler((shelf.Request request) {
          return shelf.Response.ok(
              "Dynamic answer - (isolate ${Isolate.current.hashCode})");
        }),
      );

    shelf_io.serveRequests(
      server,
      app,
      poweredByHeader: 'mw',
    );

    print(
      'listening at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}',
    );
  }
}
