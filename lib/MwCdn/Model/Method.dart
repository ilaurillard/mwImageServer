import 'package:mwcdn/MwCdn/Config.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Model/JsonSerializable.dart';

class Method implements JsonSerializable {
  final String name;
  final bool exists;
  final String tool;
  final List<String> parameters;

  Method(
    this.name, {
    this.tool = '',
    this.parameters = const [],
    this.exists = true,
  });

  bool valid() {
    return exists;
  }

  @override
  Dict toJson() {
    return {
      'name': name,
      'tool': tool,
      'parameters': parameters,
    };
  }

  factory Method.fromDatabase(
    Dict row,
  ) {
    return Method(
      row['name'] as String? ?? '',
      tool: row['tool'] as String? ?? '',
      parameters: Types.stringListFromDict(
        row,
        'parameters',
      ),
    );
  }

  factory Method.notFound(
    String name,
  ) {
    return Method(
      name,
      exists: false,
    );
  }

  static bool validName(String name)
  {
    return Config.validMethodName.hasMatch(name);
  }
}
