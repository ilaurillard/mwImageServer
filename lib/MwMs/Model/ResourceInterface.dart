import 'package:mwcdn/MwMs/Etc/Types.dart';

abstract class ResourceInterface {

  String get filename => '';

  int get bucket => 0;
  Ids get groups => [];
  Ids get users => [];

  String path({
    bool absolute = true,
  });
}
