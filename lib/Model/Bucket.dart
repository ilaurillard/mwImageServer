import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';
import 'package:mwcdn/Model/Method.dart';

class Bucket implements JsonSerializable {
  final int id;

  final List<Method> methods;

  Bucket(
    this.id, {
    this.methods = const [],
  });

  Dict toJson() {
    return {
      'id': id,
    };
  }

  Dict toDatabase() {
    return {
      'id': id,
    };
  }

  factory Bucket.fromDatabase(
    Dict row,
  ) {
    return Bucket(
      row['id'],
      methods: [],
    );
  }

  factory Bucket.empty(
      int id,
      ) {
    return Bucket(
      id,
      methods: [],
    );
  }
}
