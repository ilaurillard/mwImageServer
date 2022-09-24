import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'Api.dart';
import 'Authentication.dart';
import 'Config.dart';
import 'Imagick.dart';
import 'Storage.dart';

class Server {
  final Config config;
  final Storage storage;
  final Imagick imagick;

  Server({
    required this.config,
    required this.storage,
    required this.imagick,
  });

  Future<Null> start(
    List args,
  ) async {
    final HttpServer server = await HttpServer.bind(
      config.ip,
      config.port,
      shared: true, // for isolates
    );

    serveRequests(
      server,
      app(),
      poweredByHeader: 'mw',
    );

    print(
      'listening at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}',
    );
  }

  Router app() {
    return Router()
      // PUBLIC ----------------------
      ..get(
        '/public/<i|[a-f0-9]{2}>/<[a-f0-9]{2}>/<resource|[a-f0-9]{32}>/<ignored|.*>',
        createStaticHandler(
          config.dataDir,
        ),
      )
      // PRIVATE ----------------------
      ..get(
        '/private/<i|[a-f0-9]{2}>/<[a-f0-9]{2}>/<resource|[a-f0-9]{32}>/<ignored|.*>',
        Pipeline()
            .addMiddleware(
              Authentication(
                config: config,
                storage: storage,
              ).privateAccess(),
            )
            .addHandler(
              createStaticHandler(
                config.dataDir,
              ),
            ),
      )
      // API ----------------------
      ..get(
        '/api/<ignored|.*>',
        Pipeline()
            .addMiddleware(
              Authentication(
                config: config,
                storage: storage,
              ).apiAccess(),
            )
            .addHandler(
              Api().create(),
            ),
      );
  }
}
