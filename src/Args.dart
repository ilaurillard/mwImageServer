import 'package:args/args.dart';

class Args {
  late final String dataDir;
  late final String apiKey;

  Args(
    List<String> args,
  ) {
    final ArgParser _parser = ArgParser()
      ..addOption('dataDir', abbr: 'd', defaultsTo: '/data')
      ..addOption('apiKey', abbr: 'k', defaultsTo: 'xxx');
    final ArgResults _arguments = _parser.parse(args);

    dataDir = _arguments['dataDir'];
    print('>>> data: ' + dataDir);

    apiKey = _arguments['apiKey'];
    print('>>> apiKey: ' + apiKey);

    print('');
  }
}
