import 'dart:io';
import 'dart:isolate';

import 'package:args/args.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(
  List<String> args,
) async {
  var parser = new ArgParser()
    ..addOption('dataDir', abbr: 'd', defaultsTo: '/data');
  var arguments = parser.parse(args);

  String dataDir = arguments['dataDir'];
  print('dataDir: ' + dataDir);

  // var result = await Process.run('ls', ['-la']);
  // stdout.write(result.stdout);
  // stderr.write(result.stderr);

  // -----------

  sqfliteFfiInit();
  Database db = await databaseFactoryFfi.openDatabase(
    dataDir + '/database/system.db',
  );
  print('SQLITE: ' + db.toString());

  //------------

  final _staticHandler = shelf_static.createStaticHandler(
    dataDir + '/public',
    // defaultDocument: 'index.html',
  );

  final _exampleHandler = (shelf.Request request) =>
      shelf.Response.ok("Hello World - (isolate ${Isolate.current.hashCode})");

  _startShelfServer(
    List args,
  ) async {
    final cascade = shelf.Cascade()
        .add(
          _staticHandler,
        )
        .add(
          _exampleHandler,
        );
    HttpServer server = await HttpServer.bind(
      InternetAddress.anyIPv4,
      8080,
      shared: true,
    );
    shelf_io.serveRequests(
      server,
      cascade.handler,
    );
    print(
      'Serving at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}',
    );
  }

  int isolates = 1;
  for (int i = 1; i < isolates; i++) {
    Isolate.spawn(_startShelfServer, [dataDir]);
  }
  _startShelfServer([dataDir]);
}
