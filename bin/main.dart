import 'dart:io';
import 'dart:isolate';

import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_static/shelf_static.dart' as shelf_static;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main(
  List<String> args,
) async {
  // var parser = new ArgParser()
  //   ..addOption('address', abbr: 'a', defaultsTo: '0.0.0.0')
  //   ..addOption('port', abbr: 'p', defaultsTo: '9393')
  //   ..addOption('isolates', abbr: 'i', defaultsTo: '3');
  // var arguments = parser.parse(args);

  String dataDir = args.isEmpty ? '/data' : args.first;
  print('dataDir: ' + dataDir);

  // var result = await Process.run('ls', ['-la']);
  // stdout.write(result.stdout);
  // stderr.write(result.stderr);

  // ------------------

  sqfliteFfiInit();
  Database db = await databaseFactoryFfi.openDatabase(
    dataDir + '/database/test.db',
  );
  print('SQLITE: ' + db.toString());

  //------------

  // final ip = InternetAddress.anyIPv4;
  //
  // final handler = Pipeline()
  //     // .addMiddleware(
  //     //   logRequests(),
  //     // )
  //     .addHandler(
  //       _router,
  //     );
  //
  // final port = int.parse(Platform.environment['PORT'] ?? '8080');
  // final server = await shelf_io.serve(
  //   handler,
  //   ip,
  //   port,
  // );
  // print(
  //   'Server listening on port ${server.port}',
  // );

  // -------------

  // final _staticHandler = shelf_static.createStaticHandler(
  //   dataDir + '/public',
  //   defaultDocument: 'index.html',
  // );

  //
  // final port = int.parse(Platform.environment['PORT'] ?? '8080');
  //
  // final cascade = Cascade().add(_staticHandler).add(_router);
  //
  // final server = await shelf_io.serve(
  //   logRequests().addHandler(cascade.handler),
  //   InternetAddress.anyIPv4,
  //   port,
  // );
  //
  // print(
  //   'Server listening on port ${server.port}',
  // );

  // -------------------

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

  // int isolates = 3;
  // for (int i = 1; i < isolates; i++) {
  //   Isolate.spawn(_startShelfServer, [dataDir]);
  // }
  _startShelfServer([dataDir]);
}
