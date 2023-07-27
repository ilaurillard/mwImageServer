import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:mwcdn/Model/JsonSerializable.dart';

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
    // print(row['parameters']);
    return Method(
      row['name'] as String? ?? '',
      tool: row['tool'] as String? ?? '',
      parameters: Util.stringListData(
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
}
