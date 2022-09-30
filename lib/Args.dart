import 'package:args/args.dart';

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

    dataDir = _arguments['dataDir'];
    rootKey = _arguments['rootKey'];

    print('[rootKey]');
    print (rootKey);
    print('');
  }
}
