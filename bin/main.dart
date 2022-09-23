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

  final ArgParser _parser = new ArgParser()
    ..addOption('dataDir', abbr: 'd', defaultsTo: '/data');
  final ArgResults _arguments = _parser.parse(args);

  final String dataDir = _arguments['dataDir'];
  print('data: ' + dataDir);

  // ----------- imagemagick

  var result = await Process.run('convert', ['-version']);
  stdout.write(result.stdout);
  stderr.write(result.stderr);

  // ----------- sqlite

  sqfliteFfiInit();
  final Database db = await databaseFactoryFfi.openDatabase(
    dataDir + '/database/system.db',
  );
  print('database: ' + db.toString());

  //------------ server

  final int isolates = 3;
  for (int i = 1; i < isolates; i++) {
    Isolate.spawn(_startServer, [dataDir]);
  }
  _startServer([dataDir]);
}

Future<Null> _startServer(
    List args,
    ) async {

  final String dataDir = args[0];

  final HttpServer server = await HttpServer.bind(
    InternetAddress.anyIPv4, // 0.0.0.0
    8080,
    shared: true, // for isolates
  );

  shelf_io.serveRequests(
    server,
    shelf.Cascade()
        .add(
      shelf_static.createStaticHandler(
        dataDir + '/public',
        defaultDocument: 'index.html',
      ),
    )
        .add(
          (shelf.Request request) => shelf.Response.ok(
          "Dynamic answer - (isolate ${Isolate.current.hashCode})"),
    )
        .handler,
  );

  print(
    'server at http://${server.address.host}:${server.port} - isolate: ${Isolate.current.hashCode}',
  );
}