import 'dart:isolate';

import 'package:mwcdn/Etc/Args.dart';
import 'package:mwcdn/Etc/Config.dart';
import 'package:mwcdn/Server.dart';
import 'package:mwcdn/Service/DataStorage.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';

void main(
  List<String> arguments,
) async {
  print('[service] mwcdn 0.1');

  Args args = Args(
    arguments,
  );

  FileStorage fileStorage = FileStorage(
    dataDir: args.dataDir,
  );

  DataStorage dataStorage = DataStorage(
    dataDir: args.dataDir,
  );
  // await dataStorage.init();

  Imagick imagick = Imagick(
    dataDir: args.dataDir,
  );
  await imagick.init();

  //------------ server

  print('[run] with ' + Config.isolates.toString() + ' isolates:');
  for (int i = 1; i < Config.isolates; i++) {
    Isolate.spawn(
      Server(
        dataStorage: dataStorage,
        fileStorage: fileStorage,
        imagick: imagick,
        rootKey: args.rootKey,
      ).start,
      [],
    );
  }

  Server(
    dataStorage: dataStorage,
    fileStorage: fileStorage,
    imagick: imagick,
    rootKey: args.rootKey,
  ).start(
    [],
  );
}
