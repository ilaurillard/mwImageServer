import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetGrid {
  static const lineColor = PdfColor.fromInt(0xffc3e8f3);

  static pw.GridPaper gridPaper(
    Dict json,
  ) {
    double? interval = double.tryParse(json['interval'].toString());

    return pw.GridPaper(
      color: PdfWidgetUtil.color(
            json['color'] as String?,
          ) ??
          lineColor,
      interval: interval != null ? interval * PdfPageFormat.mm : 100.0,
      divisions: int.tryParse(json['divisions'].toString()) ?? 5,
      subdivisions: int.tryParse(json['subdivisions'].toString()) ?? 2,
      child: PdfWidget.child(json),
    );
  }


}
