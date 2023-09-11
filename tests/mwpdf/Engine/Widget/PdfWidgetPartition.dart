import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetPartition {
  static pw.Partitions partitions(
    Dict json,
  ) {
    return pw.Partitions(
      mainAxisSize: PdfWidgetUtil.mainAxisSize(json['mainAxisSize'] as String?),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => partition(e as Dict))
          .toList(),
    );
  }

  static pw.Partition partition(
    Dict json,
  ) {
    Dict data = json['Partition'] as Dict? ?? {};
    double? width = double.tryParse(data['width'].toString());
    return pw.Partition(
      child: PdfWidgetPartition.childSpanning(data['child'] as Dict? ?? {}),
      flex: data['flex'] as int? ?? 1,
      width: width != null ? width * PdfPageFormat.mm : null,
    );
  }

  static pw.SpanningWidget childSpanning(
    Dict json,
  ) {
    pw.Widget widget = PdfWidget.parse(json);
    if (widget is pw.SpanningWidget) {
      return widget;
    }
    return pw.Text('Must be a spanning widget (${widget.runtimeType})!');
  }
}
