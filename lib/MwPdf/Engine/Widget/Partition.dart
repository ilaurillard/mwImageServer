import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';
import 'Widget.dart';

class Partition {
  static pw.Partitions partitions(
    Dict json,
    State state,
  ) {
    List<pw.Partition> children = [];
    for (dynamic child in json['children'] as List<dynamic>? ?? []) {
      pw.Partition? p = partition(
        child as Dict,
        state,
      );
      if (p != null) {
        children.add(p);
      }
    }
    return pw.Partitions(
      mainAxisSize: Util.mainAxisSize(json['mainAxisSize'] as String?),
      children: children,
    );
  }

  static pw.Partition? partition(
    Dict json,
    State state,
  ) {
    Dict showIf = json['ShowIfValue'] as Dict? ?? {};
    if (showIf.isNotEmpty) {
      String condition = state.replaceParameters(
        showIf['condition'] as String? ?? '',
      );
      if (condition.isEmpty) {
        return null;
      }
      json = showIf['child'] as Dict? ?? {};
    }
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
