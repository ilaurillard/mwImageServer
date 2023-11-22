import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class Partition {
  static pw.Partitions partitions(
    Dict json,
    State state,
  ) {
    return pw.Partitions(
      mainAxisSize: Etc.mainAxisSize(json['mainAxisSize'] as String?),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => partition(
                e as Dict,
                state,
              ))
          .toList(),
    );
  }

  static pw.Partition partition(
    Dict json,
    State state,
  ) {
    Dict data = json['Partition'] as Dict? ?? {};
    double? width = double.tryParse(data['width'].toString());
    return pw.Partition(
      child: Partition.childSpanning(
        data['child'] as Dict? ?? {},
        state,
      ),
      flex: data['flex'] as int? ?? 1,
      width: width != null ? width * PdfPageFormat.mm : null,
    );
  }

  static pw.SpanningWidget childSpanning(
    Dict json,
    State state,
  ) {
    pw.Widget widget = Widget.parse(
      json,
      state,
    );
    if (widget is pw.SpanningWidget) {
      return widget;
    }
    return pw.Text('Must be a spanning widget (${widget.runtimeType})!');
  }
}