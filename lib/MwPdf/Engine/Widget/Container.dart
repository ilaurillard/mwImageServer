import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';
import 'Widget.dart';

class Container {
  static pw.Widget container(
    Dict json,
    State state,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.Container(
      constraints: Util.boxConstraints(
        json['constraints'] as Dict?,
      ),
      alignment: Util.alignment(
        json['alignment'] as String?,
      ),
      padding: Util.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: Util.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      color: Util.color(
        json['color'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      decoration: Util.boxDecoration(
        (json['decoration'] as Dict?) ?? {},
        state,
      ),
      foregroundDecoration: Util.boxDecoration(
        (json['foregroundDecoration'] as Dict?) ?? {},
        state,
      ),
      child: Widget.child(
        json,
        state,
      ),
      transform: Util.transform(json['transform'] as Dict? ?? {}),
    );
  }

  static pw.DecoratedBox decoratedBox(
    Dict json,
    State state,
  ) {
    return pw.DecoratedBox(
      decoration: Util.boxDecoration(
            (json['decoration'] as Dict?) ?? {},
            state,
          ) ??
          pw.BoxDecoration(),
      position: Util.decorationPosition(json['decorationPosition'] as String?),
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static pw.Padding padding(
    Dict json,
    State state,
  ) {
    return pw.Padding(
      padding: Util.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero,
      child: Widget.child(
        json,
        state,
      ),
    );
  }
}
