import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class Partition {
  static pw.Partitions partitions(
    Dict json,
    Resources resources,
  ) {
    return pw.Partitions(
      mainAxisSize: Etc.mainAxisSize(json['mainAxisSize'] as String?),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => partition(
                e as Dict,
                resources,
              ))
          .toList(),
    );
  }

  static pw.Partition partition(
    Dict json,
    Resources resources,
  ) {
    Dict data = json['Partition'] as Dict? ?? {};
    double? width = double.tryParse(data['width'].toString());
    return pw.Partition(
      child: Partition.childSpanning(
        data['child'] as Dict? ?? {},
        resources,
      ),
      flex: data['flex'] as int? ?? 1,
      width: width != null ? width * PdfPageFormat.mm : null,
    );
  }

  static pw.SpanningWidget childSpanning(
    Dict json,
    Resources resources,
  ) {
    pw.Widget widget = Widget.parse(
      json,
      resources,
    );
    if (widget is pw.SpanningWidget) {
      return widget;
    }
    return pw.Text('Must be a spanning widget (${widget.runtimeType})!');
  }
}
