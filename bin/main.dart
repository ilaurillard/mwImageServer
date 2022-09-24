import 'dart:isolate';

import '../src/Args.dart';
import '../src/Config.dart';
import '../src/Imagick.dart';
import '../src/Server.dart';
import '../src/Storage.dart';

void main(
  List<String> arguments,
) async {
  Config config = Config(
    args: Args(
      arguments,
    ),
  );

  Storage storage = Storage(
    config: config,
  );
  await storage.init();

  Imagick imagick = Imagick(
    config: config,
  );
  print(await imagick.version());

  //------------ server

  print('>>> starting server with ' + config.isolates.toString() + ' isolates:');
  for (int i = 1; i < config.isolates; i++) {
    Isolate.spawn(
      Server(config: config).start,
      [],
    );
  }

  Server(config: config).start(
    [],
  );
}
