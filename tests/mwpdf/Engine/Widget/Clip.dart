import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Clip {
  static pw.ClipRect clipRect(
    Dict json,
  ) {
    return pw.ClipRect(
      child: Widget.child(json),
    );
  }

  static pw.ClipRRect clipRRect(
    Dict json,
  ) {
    double? horizontalRadius =
        double.tryParse(json['horizontalRadius'].toString());

    double? verticalRadius = double.tryParse(json['verticalRadius'].toString());

    return pw.ClipRRect(
      child: Widget.child(json),
      horizontalRadius:
          horizontalRadius != null ? horizontalRadius * PdfPageFormat.mm : 0,
      verticalRadius:
          verticalRadius != null ? verticalRadius * PdfPageFormat.mm : 0,
    );
  }

  static pw.ClipOval clipOval(
    Dict json,
  ) {
    return pw.ClipOval(
      child: Widget.child(json),
    );
  }
}
