import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';
import 'Widget.dart';

class Wrap {
  static pw.Wrap wrap(
    Dict json,
    State state,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    double? runSpacing = double.tryParse(json['runSpacing'].toString());
    return pw.Wrap(
      direction: Util.axis(
            json['direction'] as String?,
          ) ??
          pw.Axis.horizontal,
      alignment: Util.wrapAlignment(
        json['alignment'] as String?,
      ),
      spacing: spacing != null ? spacing * PdfPageFormat.mm : 0.0,
      runAlignment: Util.wrapAlignment(
        json['runAlignment'] as String?,
      ),
      runSpacing: runSpacing != null ? runSpacing * PdfPageFormat.mm : 0.0,
      crossAxisAlignment: Util.wrapCrossAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      verticalDirection: Util.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(
        json,
        state,
      ),
    );
  }
}
