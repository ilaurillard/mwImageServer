import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class GridPaper {
  static const lineColor = PdfColor.fromInt(0xffc3e8f3);

  static pw.GridPaper gridPaper(
    Dict json,
    State state,
  ) {
    double? interval = double.tryParse(json['interval'].toString());

    return pw.GridPaper(
      color: Etc.color(
            json['color'] as String?,
          ) ??
          lineColor,
      interval: interval != null ? interval * PdfPageFormat.mm : 100.0,
      divisions: int.tryParse(json['divisions'].toString()) ?? 5,
      subdivisions: int.tryParse(json['subdivisions'].toString()) ?? 2,
      child: Widget.child(
        json,
        state,
      ),
    );
  }
}
