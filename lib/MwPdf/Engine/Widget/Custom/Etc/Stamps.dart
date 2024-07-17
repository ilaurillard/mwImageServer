import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Widget.dart';

class Stamps {
  static pw.Widget bates(
    Dict json,
    State state,
  ) {
    String prefix = json['prefix'] as String? ?? '';
    int start = int.tryParse(json['start'].toString()) ?? 1;
    int digits = int.tryParse(json['digits'].toString()) ?? 0;
    int number = start + (state.pageNumber - 1);
    String numberAsString = number.toString();
    if (digits > 1) {
      numberAsString = numberAsString.padLeft(digits, '0');
    }
    state.variables['batesNumber'] = prefix + numberAsString;
    return Widget.child(
      json,
      state,
    );
  }
}
