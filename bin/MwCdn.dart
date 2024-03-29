import 'dart:isolate';

import 'package:mwcdn/MwMs/Etc/Args.dart';
import 'package:mwcdn/MwCdn/Config.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwCdn/Server.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwCdn/Service/Work/Images/Imagick.dart';

void main(
  List<String> arguments,
) async {
  Console.info('[service] mwcdn 0.1');

  Args args = Args(
    arguments,
  );

  FileStorage fileStorage = FileStorage(
    dataDir: args.dataDir,
    resDir: '',
  );

  // start a database for schema upgrades
  await SqliteStorage(
    dataDir: args.dataDir,
  ).init();

  SqliteStorage sqliteStorage = SqliteStorage(
    dataDir: args.dataDir,
  );

  Imagick imagick = Imagick(
    dataDir: args.dataDir,
  );
  await imagick.init();

  //------------ server

  Console.info('[run] with ${Config.isolates} instances');

  for (int i = 1; i < Config.isolates; i++) {
    Console.notice('.. spawn extra isolate $i');
    await Isolate.spawn(
      Server(
        sqliteStorage: sqliteStorage,
        fileStorage: fileStorage,
        imagick: imagick,
        rootKey: args.rootKey,
      ).start,
      <int>[],
    );
  }

  // main process
  Console.notice('.. spawn main process');
  await Server(
    sqliteStorage: sqliteStorage,
    fileStorage: fileStorage,
    imagick: imagick,
    rootKey: args.rootKey,
  ).start(
    [],
  );
}

