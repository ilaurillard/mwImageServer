import 'dart:convert';
import 'dart:math';

import 'package:args/args.dart';
import 'package:mwcdn/Etc/Util.dart';

class Args {
  late final String dataDir;
  late final String rootKey;

  Args(
    List<String> args,
  ) {
    final ArgParser _parser = ArgParser()
      ..addOption('dataDir', abbr: 'd', defaultsTo: '/data')
      ..addOption('rootKey', abbr: 'k', defaultsTo: '');
    final ArgResults _arguments = _parser.parse(args);

    dataDir = _arguments['dataDir'] as String? ?? '';

    String rk = _arguments['rootKey'] as String? ?? '';
    if (rk.isEmpty) {
      rk = randString(24);
    }
    rootKey = rk;

    printInfo('[rootKey] ' + rootKey);
  }

  String randString(int len) {
    Random random = Random.secure();
    List<int> values = List<int>.generate(len, (i) =>  random.nextInt(255));
    return base64UrlEncode(values).replaceAll('=', '');
  }
}
