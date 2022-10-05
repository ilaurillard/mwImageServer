import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

class Method implements JsonSerializable {
  final String name;
  final bool exists;

  Method(
    this.name, {
    this.exists = true,
  });

  bool valid() {
    return exists;
  }

  @override
  Dict toJson() {
    return {
      'name': name,
    };
  }

  factory Method.fromDatabase(
    Dict row,
  ) {
    return Method(
      row['name'],
    );
  }
}
