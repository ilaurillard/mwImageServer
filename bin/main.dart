import 'dart:isolate';

import '../src/Args.dart';
import '../src/Config.dart';
import '../src/Imagick.dart';
import '../src/Server.dart';
import '../src/DataStore.dart';

void main(
  List<String> arguments,
) async {
  Config cfg = Config(
    args: Args(
      arguments,
    ),
  );

  DataStore dataStore = DataStore(
    cfg: cfg,
  );
  await dataStore.init();

  Imagick imagick = Imagick(
    cfg: cfg,
  );
  print(await imagick.version());

  //------------ server

  print(
      '>>> starting server with ' + cfg.isolates.toString() + ' isolates:');
  for (int i = 1; i < cfg.isolates; i++) {
    Isolate.spawn(
      Server(
        cfg: cfg,
        dataStore: dataStore,
        imagick: imagick,
      ).start,
      [],
    );
  }

  Server(
    cfg: cfg,
    dataStore: dataStore,
    imagick: imagick,
  ).start(
    [],
  );
}
