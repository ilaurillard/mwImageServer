import '../Types.dart';
import 'JsonSerializable.dart';

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
