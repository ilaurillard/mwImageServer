import 'dart:io';

import 'Config.dart';

class Imagick {
  final Config cfg;

  Imagick({
    required this.cfg,
  });

  Future<String> version() async {
    print('>>> imagemagick:');
    ProcessResult result = await Process.run(
      'convert',
      ['-version'],
    );
    if (exitCode == 1) {
      print(result.stderr);
      throw 'Imagick error';
    }
    return result.stdout;
  }
}
