import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class Stack {
  static pw.Stack stack(
    Dict json,
    Resources resources,
  ) {
    return pw.Stack(
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.topLeft,
      children: Widget.children(
        json,
        resources,
      ),
      overflow: Etc.overflow(json['overflow'] as String?) ?? pw.Overflow.clip,
      fit: Etc.stackFit(json['fit'] as String?) ?? pw.StackFit.loose,
    );
  }

  static pw.Positioned positioned(
    Dict json,
    Resources resources,
  ) {
    double? left = double.tryParse(json['left'].toString());
    double? top = double.tryParse(json['top'].toString());
    double? right = double.tryParse(json['right'].toString());
    double? bottom = double.tryParse(json['bottom'].toString());
    return pw.Positioned(
      child: Widget.child(
        json,
        resources,
      ),
      left: left != null ? left * PdfPageFormat.mm : null,
      top: top != null ? top * PdfPageFormat.mm : null,
      right: right != null ? right * PdfPageFormat.mm : null,
      bottom: bottom != null ? bottom * PdfPageFormat.mm : null,
    );
  }
}
