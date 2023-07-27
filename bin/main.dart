import 'dart:isolate';

import 'package:mwcdn/Etc/Args.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Server.dart';
import 'package:mwcdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';

void main(
  List<String> arguments,
) async {
  printInfo('[service] mwcdn 0.1');

  Args args = Args(
    arguments,
  );

  FileStorage fileStorage = FileStorage(
    dataDir: args.dataDir,
  );

  SqliteStorage sqliteStorage = SqliteStorage(
    dataDir: args.dataDir,
  );
  // await sqliteStorage.init();

  Imagick imagick = Imagick(
    dataDir: args.dataDir,
  );
  await imagick.init();

  //------------ server

  printInfo('[run] with ' + Config.isolates.toString() + ' instances');

  for (int i = 1; i < Config.isolates; i++) {
    printNotice('.. spawn extra isolate ' + i.toString());
    await Isolate.spawn(
      Server(
        sqliteStorage: sqliteStorage,
        fileStorage: fileStorage,
        imagick: imagick,
        rootKey: args.rootKey,
      ).start,
      [],
    );
  }

  // main process
  printNotice('.. spawn main process');
  await Server(
    sqliteStorage: sqliteStorage,
    fileStorage: fileStorage,
    imagick: imagick,
    rootKey: args.rootKey,
  ).start(
    [],
  );
}

