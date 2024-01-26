import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/RowStyle.dart';

import '../ex/Model/CellStyle.dart';
import 'Datasource.dart';

class State {
  final String resDir;

  Map<String, Datasource> sources = {};
  Map<String, RowStyle> rowStyles = {};
  Map<String, CellStyle> cellStyles = {};

  State({
    required this.resDir,
  });

  static State fromJson(
    Dict json, {
    Dict rowStyles = const {},
    Dict cellStyles = const {},
    required String resDir,
  }) {
    State state = State(
      resDir: resDir,
    );

    state.sources = json.map(
      (key, value) {
        return MapEntry(
          key,
          Datasource.fromJson(
            key,
            value as Dict,
            state,
          ),
        );
      },
    );

    state.rowStyles = rowStyles.map(
      (key, value) {
        return MapEntry(
          key,
          RowStyle.fromJson(
            value as Dict,
            state: state,
          ),
        );
      },
    );

    state.cellStyles = cellStyles.map(
      (key, value) {
        return MapEntry(
          key,
          CellStyle.fromJson(
            value as Dict,
            state: state,
          ),
        );
      },
    );

    // print(state.rowStyles);
    // print(state.cellStyles);

    return state;
  }

  Datasource source(
      String? key,
      ) {
    if (key != null && key.isNotEmpty && sources[key] == null) {
      Console.notice('No resource available for "$key"');
    }
    return sources[key ?? ''] ?? Datasource(key ?? '');
  }
}
