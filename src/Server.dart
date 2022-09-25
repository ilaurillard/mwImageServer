import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'Api.dart';
import 'Authentication.dart';
import 'Config.dart';
import 'Converter.dart';
import 'DataStore.dart';
import 'Imagick.dart';

class Server {
  final Config cfg;
  final DataStore dataStore;
  final Imagick imagick;

  Server({
    required this.cfg,
    required this.dataStore,
    required this.imagick,
  });

  Future<Null> start(
    List args,
  ) async {
    final HttpServer server = await HttpServer.bind(
      cfg.ip,
      cfg.port,
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
    Converter converter = Converter(
      cfg: cfg,
      dataStore: dataStore,
      imagick: imagick,
    );

    return Router()
      // PUBLIC ----------------------
      ..get(
        // /public/77/ff/ff/ffffaaaaffffaaaa1111222233334444/[file]
        '/public' +
            cfg.paramBucket +
            cfg.paramSeg1 +
            cfg.paramSeg2 +
            cfg.paramRes +
            cfg.paramFile,
        Cascade()
            .add(
              createStaticHandler(
                cfg.dataDir,
              ),
            )
            .add(
              converter.onTheFly,
            )
            .handler,
      )
      // PRIVATE ----------------------
      ..get(
        '/private' +
            cfg.paramBucket +
            cfg.paramSeg1 +
            cfg.paramSeg2 +
            cfg.paramRes +
            cfg.paramFile,
        Pipeline()
            .addMiddleware(
              Authentication(
                cfg: cfg,
                dataStore: dataStore,
              ).privateAccess(),
            )
            .addHandler(
              Cascade()
                  .add(
                    createStaticHandler(
                      cfg.dataDir,
                    ),
                  )
                  .add(
                    converter.onTheFly,
                  )
                  .handler,
            ),
      )
      // API ----------------------
      ..mount(
          '/api',
          Api(
            cfg: cfg,
            dataStore: dataStore,
          ).create());
  }
}
