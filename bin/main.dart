import 'dart:isolate';

import 'package:mwcdn/Args.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/FileStore.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:mwcdn/Server.dart';
import 'package:mwcdn/Service/DataStore.dart';

void main(
  List<String> arguments,
) async {

  print('[service]');
  print('mwcdn 0.1');
  print('');

  Config.init(
    args: Args(
      arguments,
    ),
  );

  FileStore fileStore = FileStore();
  await fileStore.init();

  DataStore dataStore = DataStore();
  await dataStore.init();

  Imagick imagick = Imagick();
  print(await imagick.version());

  //------------ server

  print('[run]');
  print('with ' + Config.isolates.toString() + ' isolates:');
  for (int i = 1; i < Config.isolates; i++) {
    Isolate.spawn(
      Server(
        dataStore: dataStore,
        fileStore: fileStore,
        imagick: imagick,
      ).start,
      [],
    );
  }

  Server(
    dataStore: dataStore,
    fileStore: fileStore,
    imagick: imagick,
  ).start(
    [],
  );
}
