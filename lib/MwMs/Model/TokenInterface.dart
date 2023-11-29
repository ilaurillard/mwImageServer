import 'package:mwcdn/MwMs/Model/ResourceInterface.dart';

abstract class TokenInterface {
  bool accessResource(
    ResourceInterface resource,
  );
}
