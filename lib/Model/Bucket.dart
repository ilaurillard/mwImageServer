import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

class Bucket extends JsonSerializable {
  final int id;

  Bucket(
    this.id,
  );

  Dict toJson() {
    return {
      'id': id,
    };
  }
}
