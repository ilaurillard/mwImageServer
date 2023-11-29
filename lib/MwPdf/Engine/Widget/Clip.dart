import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Clip {
  static pw.ClipRect clipRect(
    Dict json,
    State state,
  ) {
    return pw.ClipRect(
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static pw.ClipRRect clipRRect(
    Dict json,
    State state,
  ) {
    double? horizontalRadius =
        double.tryParse(json['horizontalRadius'].toString());

    double? verticalRadius = double.tryParse(json['verticalRadius'].toString());

    return pw.ClipRRect(
      child: Widget.child(
        json,
        state,
      ),
      horizontalRadius:
          horizontalRadius != null ? horizontalRadius * PdfPageFormat.mm : 0,
      verticalRadius:
          verticalRadius != null ? verticalRadius * PdfPageFormat.mm : 0,
    );
  }

  static pw.ClipOval clipOval(
    Dict json,
    State state,
  ) {
    return pw.ClipOval(
      child: Widget.child(
        json,
        state,
      ),
    );
  }
}
