import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidgetUtil.dart';

class PdfWidgetImage {
  static pw.Image image(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.Image(
      pw.MemoryImage(Uint8List(0)),
    );
  }

  static pw.SvgImage svgImage(
    Dict json,
  ) {
    print(json);
    // TODO
    return pw.SvgImage(
      svg: '',
    );
  }

  static pw.Icon icon(
    Dict json,
  ) {
    double? size = double.tryParse(json['size'].toString());
    return pw.Icon(
      pw.IconData(
        int.parse(json['icon'].toString(), radix: 16),
      ),
      size: size != null ? size * PdfPageFormat.mm : null,
      color: PdfWidgetUtil.color(
        json['color'] as String?,
      ),
      // color: PdfColors.black
    );
  }
}
