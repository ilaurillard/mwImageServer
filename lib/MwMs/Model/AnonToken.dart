import 'package:mwcdn/MwMs/Model/ResourceInterface.dart';
import 'package:mwcdn/MwMs/Model/TokenInterface.dart';

class AnonToken implements TokenInterface {
  @override
  bool accessResource(
    ResourceInterface resource,
  ) {
    return false;
  }
}
