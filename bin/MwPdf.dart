import 'dart:isolate';

import 'package:mwcdn/MwCdn/Etc/Args.dart';
import 'package:mwcdn/MwCdn/Config.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Service/Server.dart';
import 'dart:io';
import 'package:path/path.dart' show dirname;

void main(
  List<String> arguments,
) async {
  Console.info('[service] mwpdf 0.1');

  Args args = Args(
    arguments,
  );

  String resDir = '${dirname(
    Platform.script.path,
  )}/res';

  FileStorage fileStorage = FileStorage(
    dataDir: args.dataDir,
    resDir: resDir,
  );

  //------------ server

  Console.info('[run] with ${Config.isolates} instances');

  for (int i = 1; i < Config.isolates; i++) {
    Console.notice('.. spawn extra isolate $i');
    await Isolate.spawn(
      Server(
        fileStorage: fileStorage,
        rootKey: args.rootKey,
      ).start,
      <int>[],
    );
  }

  // main process
  Console.notice('.. spawn main process');
  await Server(
    fileStorage: fileStorage,
    rootKey: args.rootKey,
  ).start(
    [],
  );
}

