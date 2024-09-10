import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Text.dart';
import '../Widget.dart';
import 'package:intl/intl.dart';

class Helpers {
  static pw.Widget date(
    Dict json,
    State state,
  ) {
    String value = json['value'] as String? ?? '';
    if (value.isEmpty) {
      value = '%value%';
    }
    value = state.replaceParameters(value);

    DateTime? dt;
    try {
      dt = DateTime.parse(value);
    }
    catch (e) {
      dt = DateTime.now();
    }

    DateFormat formatter = DateFormat(
        json['format'] as String? ?? 'yyyy-MM-dd'
    );
    value = formatter.format(dt);

    if (json['child'] == null) {
      json['text'] = value;
      return Text.text(json, state);
    }

    state.value = value;
    return Widget.child(
      json,
      state,
    );
  }

  static pw.Widget numberFormat(
    Dict json,
    State state,
  ) {
    String value = json['value'] as String? ?? '';
    if (value.isEmpty) {
      value = '%value%';
    }
    value = state.replaceParameters(value);

    String locale = json['locale'] as String? ?? 'de_DE';
    String format = json['format'] as String? ?? '#';
    NumberFormat nf = NumberFormat(format, locale);

    value = nf.format(double.tryParse(value) ?? 0);

    if (json['child'] == null) {
      json['text'] = value;
      return Text.text(json, state);
    }

    state.value = value;
    return Widget.child(
      json,
      state,
    );
  }
}
