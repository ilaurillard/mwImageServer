import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class GridView {
  static pw.GridView gridView(
    Dict json,
    State state,
  ) {
    double? mainAxisSpacing =
        double.tryParse(json['mainAxisSpacing'].toString());
    double? crossAxisSpacing =
        double.tryParse(json['crossAxisSpacing'].toString());
    return pw.GridView(
      direction: Etc.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      crossAxisCount: int.tryParse(json['crossAxisCount'].toString()) ?? 3,
      children: Widget.children(
        json,
        state,
      ),
      padding: Etc.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero,
      mainAxisSpacing:
          mainAxisSpacing != null ? mainAxisSpacing * PdfPageFormat.mm : 0.0,
      crossAxisSpacing:
          crossAxisSpacing != null ? crossAxisSpacing * PdfPageFormat.mm : 0.0,
      childAspectRatio: double.tryParse(json['childAspectRatio'].toString()) ??
          double.infinity,
    );
  }
}
