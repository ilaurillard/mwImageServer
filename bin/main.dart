import 'dart:isolate';

import 'package:mwcdn/Args.dart';
import 'package:mwcdn/Config.dart';
import 'package:mwcdn/Service/Imagick.dart';
import 'package:mwcdn/Server.dart';
import 'package:mwcdn/Service/DataStore.dart';

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

  print('[starting server]');
  print('with ' + Config.isolates.toString() + ' isolates:');
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
