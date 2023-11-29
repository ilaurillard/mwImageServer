import 'package:mwcdn/MwMs/Model/ResourceInterface.dart';

abstract class ResourcesInterface {
  Future<ResourceInterface> load(
    int bucket,
    String id,
  );
}
