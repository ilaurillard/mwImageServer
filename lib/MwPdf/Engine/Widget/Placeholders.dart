import 'dart:math' as math;

import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Content.dart';
import 'Etc.dart';
import 'Text.dart';

class Placeholders {
  static pw.Placeholder placeholder(
    Dict json,
  ) {
    double? strokeWidth = double.tryParse(json['strokeWidth'].toString());
    double? fallbackWidth = double.tryParse(json['fallbackWidth'].toString());
    double? fallbackHeight = double.tryParse(json['fallbackHeight'].toString());
    return pw.Placeholder(
      strokeWidth: strokeWidth != null ? strokeWidth * PdfPageFormat.mm : 2.0,
      fallbackWidth:
          fallbackWidth != null ? fallbackWidth * PdfPageFormat.mm : 400.0,
      fallbackHeight:
          fallbackHeight != null ? fallbackHeight * PdfPageFormat.mm : 400.0,
      color: Etc.color(
            json['color'] as String?,
          ) ??
          PdfColor.fromInt(0xFF455A64),
    );
  }

  static pw.Text loremText(
    Dict json,
      Resources resources,
  ) {
    json['text'] = _loremText(json);
    return Text.text(
      json,
      resources,
    );
  }

  static pw.Paragraph loremParagraph(
    Dict json,
    Resources resources,
  ) {
    json['text'] = _loremText(json);
    return Content.paragraph(
      json,
      resources,
    );
  }

  static String _loremText(
    Dict json,
  ) {
    int? sentence = int.tryParse(json['sentence'].toString());
    if (sentence != null && sentence > 0) {
      return pw.LoremText(
              random:
                  math.Random(int.tryParse(json['random'].toString()) ?? 987))
          .sentence(sentence);
    }
    int? paragraph = int.tryParse(json['paragraph'].toString());
    if (paragraph != null && paragraph > 0) {
      return pw.LoremText(
              random:
                  math.Random(int.tryParse(json['random'].toString()) ?? 987))
          .paragraph(paragraph);
    }
    return '¿';
  }

  static pw.PdfLogo pdfLogo(
    Dict json,
  ) {
    return pw.PdfLogo(
      color: Etc.color(
            json['color'] as String?,
          ) ??
          PdfColors.red,
      fit: Etc.boxFit(
            json['fit'] as String?,
          ) ??
          pw.BoxFit.contain,
    );
  }
}
