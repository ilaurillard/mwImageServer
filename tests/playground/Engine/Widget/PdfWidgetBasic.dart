import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetBasic {
  static pw.Text text(
    Dict json,
  ) {
    // TODO
    return pw.Text(
      PdfWidgetUtil.parameters(json['text'] as String? ?? '¿'),
      textAlign: PdfWidgetUtil.textAlign(
        json['textAlign'] as String?,
      ),
      textDirection: PdfWidgetUtil.textDirection(
        json['textDirection'] as String?,
      ),
    );
  }

  static pw.Paragraph paragraph(
    Dict json,
  ) {
    // TODO
    return pw.Paragraph(
      text: PdfWidgetUtil.parameters(json['text'] as String? ?? '¿'),
      textAlign: PdfWidgetUtil.textAlign(
            json['textAlign'] as String?,
          ) ??
          pw.TextAlign.justify,
      padding: PdfWidgetUtil.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: PdfWidgetUtil.edgeInsets(
            json['margin'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.only(bottom: 5.0 * PdfPageFormat.mm),
    );
  }

  static pw.Spacer spacer(
    Dict json,
  ) {
    return pw.Spacer(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
    );
  }

  static pw.Placeholder placeholder(
    Dict json,
  ) {
    // TODO
    return pw.Placeholder(
      fallbackWidth: 20 * PdfPageFormat.mm,
      fallbackHeight: 20 * PdfPageFormat.mm,
      color: PdfWidgetUtil.color(
            json['color'] as String?,
          ) ??
          PdfColor.fromInt(0xFF455A64),
    );
  }

  static pw.Opacity opacity(Dict json) {
    return pw.Opacity(
      opacity: double.tryParse(json['opacity'].toString()) ?? 1.0,
      child: PdfWidget.parse(json['child'] as Dict? ?? {}),
    );
  }

  static pw.Divider divider(
    Dict json,
  ) {
    double? height = double.tryParse(json['height'].toString());
    double? thickness = double.tryParse(json['thickness'].toString());
    double? indent = double.tryParse(json['indent'].toString());
    double? endIndent = double.tryParse(json['endIndent'].toString());
    return pw.Divider(
      height: height != null ? height * PdfPageFormat.mm : null,
      thickness: thickness != null ? thickness * PdfPageFormat.mm : null,
      indent: indent != null ? indent * PdfPageFormat.mm : null,
      endIndent: endIndent != null ? endIndent * PdfPageFormat.mm : null,
      color: PdfWidgetUtil.color(
        json['color'] as String?,
      ),
      borderStyle: PdfWidgetUtil.borderStyle(
        json['borderStyle'] as String?,
      ),
    );
  }

  static pw.Text loremText(
    Dict json,
  ) {
    json['text'] = _loremText(json);
    return text(json);
  }

  static pw.Paragraph loremParagraph(
    Dict json,
  ) {
    json['text'] = _loremText(json);
    return paragraph(json);
  }

  static String _loremText(
    Dict json,
  ) {
    int? sentence = int.tryParse(json['sentence'].toString());
    if (sentence != null && sentence > 0) {
      return pw.LoremText().sentence(sentence);
    }
    int? paragraph = int.tryParse(json['paragraph'].toString());
    if (paragraph != null && paragraph > 0) {
      return pw.LoremText().paragraph(paragraph);
    }
    return '¿';
  }
}
