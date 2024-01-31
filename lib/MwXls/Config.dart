import 'dart:io';

class Config {
  static final String dataDir = '/home/ilja/PhpstormProjects/mwcdn/data';

  static const int isolates = 4; // cpu cores ...

  static final InternetAddress ip = InternetAddress.anyIPv4;
  static const int port = 8235;
}
