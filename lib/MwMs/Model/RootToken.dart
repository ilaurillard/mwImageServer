import 'package:mwcdn/MwMs/Model/ResourceInterface.dart';
import 'package:mwcdn/MwMs/Model/TokenInterface.dart';

class RootToken implements TokenInterface {
  @override
  bool accessResource(
    ResourceInterface resource,
  ) {
    return true;
  }
}
