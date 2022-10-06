import 'dart:isolate';

import 'package:mwcdn/Args.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/FileStorage.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:mwcdn/Server.dart';
import 'package:mwcdn/Service/DataStorage.dart';

void main(
  List<String> arguments,
) async {

  print('[service]');
  print(' mwcdn 0.1');
  print('');

  Config.init(
    args: Args(
      arguments,
    ),
  );

  FileStorage fileStorage = FileStorage();
  await fileStorage.init();

  DataStorage dataStorage = DataStorage();
  await dataStorage.init();

  Imagick imagick = Imagick();
  print(await imagick.version());

  //------------ server

  print('[run]');
  print(' with ' + Config.isolates.toString() + ' isolates:');
  for (int i = 1; i < Config.isolates; i++) {
    Isolate.spawn(
      Server(
        dataStorage: dataStorage,
        fileStorage: fileStorage,
        imagick: imagick,
      ).start,
      [],
    );
  }

  Server(
    dataStorage: dataStorage,
    fileStorage: fileStorage,
    imagick: imagick,
  ).start(
    [],
  );
}
