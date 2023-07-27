import 'dart:io';
import 'dart:isolate';

import 'package:mwcdn/Api.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Service/Authentication.dart';
import 'package:mwcdn/Service/Converter.dart';
import 'package:mwcdn/Service/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

class Server {
  final SqliteStorage sqliteStorage;
  final FileStorage fileStorage;
  final Imagick imagick;
  final String rootKey;

  Server({
    required this.sqliteStorage,
    required this.fileStorage,
    required this.imagick,
    required this.rootKey,
  });

  Future<Null> start(
    List<dynamic> args,
  ) async {
    await sqliteStorage.init();

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
      ''' .. listening at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}
      
'''
    );
  }

  Router app() {
    Converter converter = Converter(
      sqliteStorage: sqliteStorage,
      fileStorage: fileStorage,
      imagick: imagick,
    );

    return Router()
      // PUBLIC files ----------------------
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
              converter.enPassant,
            )
            .handler,
      )
      // PRIVATE files (with firewall) ----------------------
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
                sqliteStorage: sqliteStorage,
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
                    converter.enPassant,
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
            sqliteStorage: sqliteStorage,
            fileStorage: fileStorage,
            rootKey: rootKey,
          ).create());
  }
}
