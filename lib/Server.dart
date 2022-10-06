import 'dart:io';
import 'dart:isolate';

import 'package:mwcdn/Api.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Service/Authentication.dart';
import 'package:mwcdn/Service/Converter.dart';
import 'package:mwcdn/Service/DataStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class Server {
  final DataStorage dataStorage;
  final FileStorage fileStorage;
  final Imagick imagick;
  final String rootKey;

  Server({
    required this.dataStorage,
    required this.fileStorage,
    required this.imagick,
    required this.rootKey,
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
      '  listening at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}',
    );
    print('');

  }

  Router app() {
    Converter converter = Converter(
      dataStorage: dataStorage,
      fileStorage: fileStorage,
      imagick: imagick,
    );

    return Router()
      // PUBLIC ----------------------
      ..get(
        // /public/77/ff/ff/ffffaaaaffffaaaa1111222233334444/[file]
        '/public' +
            Config.matchBucket +
            Config.matchSeg1 +
            Config.matchSeg2 +
            Config.matchResource +
            Config.matchFile,
        Cascade()
            .add(
              createStaticHandler(
                fileStorage.dataDir,
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
            Config.matchBucket +
            Config.matchSeg1 +
            Config.matchSeg2 +
            Config.matchResource +
            Config.matchFile,
        Pipeline()
            .addMiddleware(
              Authentication(
                dataStorage: dataStorage,
                rootKey: rootKey,
              ).privateAccess(),
            )
            .addHandler(
              Cascade()
                  .add(
                    createStaticHandler(
                      fileStorage.dataDir,
                    ),
                  )
                  .add(
                    converter.onTheFly,
                  )
                  .handler,
            ),
      )
      // Public static files ---------
      ..get(
        '/static/<any|.*>',
        createStaticHandler(
          fileStorage.dataDir,
        ),
      )
      // API ----------------------
      ..mount(
          '/api',
          Api(
            dataStorage: dataStorage,
            fileStorage: fileStorage,
            rootKey: rootKey,
          ).create());
  }
}
