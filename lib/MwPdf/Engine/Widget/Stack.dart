import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';
import 'Widget.dart';

class Stack {
  static pw.Stack stack(
    Dict json,
    State state,
  ) {
    return pw.Stack(
      alignment: Util.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.topLeft,
      children: Widget.children(
        json,
        state,
      ),
      overflow: Util.overflow(json['overflow'] as String?) ?? pw.Overflow.clip,
      fit: Util.stackFit(json['fit'] as String?) ?? pw.StackFit.loose,
    );
  }

  static pw.Positioned positioned(
    Dict json,
    State state,
  ) {
    double? left = double.tryParse(json['left'].toString());
    double? top = double.tryParse(json['top'].toString());
    double? right = double.tryParse(json['right'].toString());
    double? bottom = double.tryParse(json['bottom'].toString());
    return pw.Positioned(
      child: Widget.child(
        json,
        state,
      ),
      left: left != null ? left * PdfPageFormat.mm : null,
      top: top != null ? top * PdfPageFormat.mm : null,
      right: right != null ? right * PdfPageFormat.mm : null,
      bottom: bottom != null ? bottom * PdfPageFormat.mm : null,
    );
  }
}
