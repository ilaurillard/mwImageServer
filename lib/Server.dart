import 'dart:io';
import 'dart:isolate';

import 'package:mwcdn/Service/DataStore.dart';
import 'package:mwcdn/Service/FileStore.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

import 'package:mwcdn/Routing.dart';
import 'package:mwcdn/Service/Authentication.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/Converter.dart';
import 'package:mwcdn/Service/Imagick.dart';

class Server {
  final DataStore dataStore;
  final FileStore fileStore;
  final Imagick imagick;

  Server({
    required this.dataStore,
    required this.fileStore,
    required this.imagick,
  });

  Future<Null> start(
    List args,
  ) async {
    final HttpServer server = await HttpServer.bind(
      Config.ip,
      Config.port,
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
    print('');
  }

  Router app() {
    Converter converter = Converter(
      dataStore: dataStore,
      fileStore: fileStore,
      imagick: imagick,
    );

    return Router()
      // PUBLIC ----------------------
      ..get(
        // /public/77/ff/ff/ffffaaaaffffaaaa1111222233334444/[file]
        '/public' +
            Config.paramBucket +
            Config.paramSeg1 +
            Config.paramSeg2 +
            Config.paramResource +
            Config.paramFile,
        Cascade()
            .add(
              createStaticHandler(
                Config.dataDir,
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
            Config.paramBucket +
            Config.paramSeg1 +
            Config.paramSeg2 +
            Config.paramResource +
            Config.paramFile,
        Pipeline()
            .addMiddleware(
              Authentication(
                dataStore: dataStore,
              ).privateAccess(),
            )
            .addHandler(
              Cascade()
                  .add(
                    createStaticHandler(
                      Config.dataDir,
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
          Routing(
            dataStore: dataStore,
            fileStore: fileStore,
          ).create());
  }
}
