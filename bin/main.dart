import 'dart:isolate';

import '../src/Args.dart';
import '../src/Config.dart';
import '../src/Imagick.dart';
import '../src/Server.dart';
import '../src/DataStore.dart';

void main(
  List<String> arguments,
) async {
  Config.init(
    args: Args(
      arguments,
    ),
  );

  DataStore dataStore = DataStore();
  await dataStore.init();

  Imagick imagick = Imagick();
  print(await imagick.version());

  //------------ server

  print(
      '>>> starting server with ' + Config.isolates.toString() + ' isolates:');
  for (int i = 1; i < Config.isolates; i++) {
    Isolate.spawn(
      Server(
        dataStore: dataStore,
        imagick: imagick,
      ).start,
      [],
    );
  }

  Server(
    dataStore: dataStore,
    imagick: imagick,
  ).start(
    [],
  );
}
