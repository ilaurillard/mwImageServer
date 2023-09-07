import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../engine.dart';
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
    // TODO
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    return pw.SvgImage(
      svg: exampleSvg,
      fit: PdfWidgetUtil.boxFit(
        json['fit'] as String?,
      ) ?? pw.BoxFit.contain,
      alignment: PdfWidgetUtil.alignment(
        json['alignment'] as String?,
      ) ?? pw.Alignment.center,
      clip: json['clip'] as bool? ?? true,
      colorFilter: PdfWidgetUtil.color(
        json['colorFilter'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
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
