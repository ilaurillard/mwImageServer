import 'dart:io';
import 'dart:isolate';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwXls/Config.dart';
import 'package:mwcdn/MwXls/Service/Api/Api.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
// ignore: depend_on_referenced_packages
import 'package:shelf_static/shelf_static.dart';

class Server {
  final FileStorage fileStorage;
  final String rootKey;

  Server({
    required this.fileStorage,
    required this.rootKey,
  });

  Future<void> start(
    List<dynamic> args,
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

    Console.notice(
        '.. listening at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}');
  }

  Router app() {
    return Router()

      // API ----------------------
      ..mount(
          '/api',
          Api(
            fileStorage: fileStorage,
            rootKey: rootKey,
          ).create())
      // Public static files ---------
      ..get(
        '/<any|.*>',
        createStaticHandler(
          '${fileStorage.resDir}/MwXls/web',
        ),
      );
  }
}
