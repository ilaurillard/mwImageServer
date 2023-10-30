import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';
import 'Widget.dart';

class Container {
  static pw.Widget container(
    Dict json,
      State state,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.Container(
      constraints: Etc.boxConstraints(
        json['constraints'] as Dict?,
      ),
      alignment: Etc.alignment(
        json['alignment'] as String?,
      ),
      padding: Etc.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: Etc.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      color: Etc.color(
        json['color'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      decoration: Etc.boxDecoration((json['decoration'] as Dict?) ?? {}),
      foregroundDecoration:
          Etc.boxDecoration((json['foregroundDecoration'] as Dict?) ?? {}),
      child: Widget.child(json, state, ),
      transform: Etc.transform(json['transform'] as Dict? ?? {}),
    );
  }

  static pw.DecoratedBox decoratedBox(
    Dict json,
      State state,
  ) {
    return pw.DecoratedBox(
      decoration: Etc.boxDecoration((json['decoration'] as Dict?) ?? {}) ??
          pw.BoxDecoration(),
      position: Etc.decorationPosition(json['decorationPosition'] as String?),
      child: Widget.child(json, state,),
    );
  }

  static pw.Padding padding(
    Dict json,
      State state,
  ) {
    return pw.Padding(
      padding: Etc.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero,
      child: Widget.child(json, state,),
    );
  }
}
