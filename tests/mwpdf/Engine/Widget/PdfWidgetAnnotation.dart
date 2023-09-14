import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetAnnotation {
  static pw.Header header(
    Dict json,
  ) {
    return pw.Header(
      title: json['title'] as String?,
      text: json['text'] as String?,
      child: PdfWidget.child(json),
      level: json['level'] as int? ?? 0,
      decoration:
          PdfWidgetUtil.boxDecoration((json['decoration'] as Dict?) ?? {}),
      outlineColor: PdfWidgetUtil.color(
        json['outlineColor'] as String?,
      ),
      outlineStyle: PdfWidgetAnnotation.pdfOutlineStyle(
            json['outlineStyle'] as String?,
          ) ??
          PdfOutlineStyle.normal,
      margin: PdfWidgetUtil.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: PdfWidgetUtil.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      textStyle: PdfWidgetUtil.textStyle(
        (json['textStyle'] as Dict?) ?? {},
      ),
    );
  }

  static PdfOutlineStyle? pdfOutlineStyle(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'normal':
          return PdfOutlineStyle.normal;
        case 'italic':
          return PdfOutlineStyle.italic;
        case 'italicBold':
          return PdfOutlineStyle.italicBold;
        case 'bold':
          return PdfOutlineStyle.bold;
      }
    }
    return null;
  }
}