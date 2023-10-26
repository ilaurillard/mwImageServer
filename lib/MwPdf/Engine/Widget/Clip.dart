import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Clip {
  static pw.ClipRect clipRect(
    Dict json,
    Resources resources,
  ) {
    return pw.ClipRect(
      child: Widget.child(
        json,
        resources,
      ),
    );
  }

  static pw.ClipRRect clipRRect(
    Dict json,
    Resources resources,
  ) {
    double? horizontalRadius =
        double.tryParse(json['horizontalRadius'].toString());

    double? verticalRadius = double.tryParse(json['verticalRadius'].toString());

    return pw.ClipRRect(
      child: Widget.child(
        json,
        resources,
      ),
      horizontalRadius:
          horizontalRadius != null ? horizontalRadius * PdfPageFormat.mm : 0,
      verticalRadius:
          verticalRadius != null ? verticalRadius * PdfPageFormat.mm : 0,
    );
  }

  static pw.ClipOval clipOval(
    Dict json,
    Resources resources,
  ) {
    return pw.ClipOval(
      child: Widget.child(
        json,
        resources,
      ),
    );
  }
}
