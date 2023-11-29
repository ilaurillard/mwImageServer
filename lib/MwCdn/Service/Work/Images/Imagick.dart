import 'dart:io';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwCdn/Model/Method.dart';

class Imagick {
  final String dataDir;

  Imagick({
    required this.dataDir,
  });

  Future<void> init() async {
    Console.info('[imagemagick]');
    ProcessResult result = await Process.run(
      'convert',
      ['-version'],
    );
    if (exitCode == 1) {
      Console.error(result.stderr.toString());
      throw 'Imagick error';
    }
    Console.notice(result.stdout.toString());
  }

  // ---------------------

  Future<void> convert(
    String sourcePath,
    String targetPath,
    Method method,
  ) async {
    sourcePath = dataDir + sourcePath;
    targetPath = dataDir + targetPath;

    Console.notice(
      'Magic from $sourcePath to $targetPath method ${method.name}',
    );

    ProcessResult result = await Process.run(
      method.tool,
      Util.replaceParameters(
        method.parameters,
        {
          'source': sourcePath,
          'target': targetPath,
        },
      ),
    );

    if (exitCode == 1) {
      Console.error(result.stderr.toString());
    } else {
      Console.notice(result.stdout.toString());
    }
  }
}
