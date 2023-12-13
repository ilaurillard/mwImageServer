import 'package:mwcdn/MwMs/Etc/Types.dart';

import 'State.dart';

class Datasource {
  final String key;

  final List<List<dynamic>> values;

  Datasource(
    this.key, {
    this.values = const [],
  });

  static Datasource fromJson(
    String key,
    Dict json,
    State state,
  ) {
    return Datasource(
      key,
      values: (json['values'] as List<dynamic>? ?? [])
          .map(
            (dynamic row) => row as List<dynamic>,
          )
          .toList(),
    );
  }

  @override
  String toString() {
    return 'Resource{key: $key}';
  }
}
