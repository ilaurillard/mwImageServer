import 'Args.dart';

class Config {
  late final String dataDir;
  late final String apiKey;

  final int isolates = 2; // cpu cores ...

  Config({
    required Args args,
  }) {
    dataDir = args.dataDir;
    apiKey = args.apiKey;
  }
}
