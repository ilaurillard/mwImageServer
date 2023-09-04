import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetEnums.dart';

class PdfWidgetBasic {
  static pw.Text parseText(
    Dict json,
  ) {
    // TODO
    return pw.Text(
      json['text'] as String? ?? '¿',
    );
  }

  static pw.Paragraph parseParagraph(
    Dict json,
  ) {
    // TODO
    return pw.Paragraph(
      text: json['text'] as String? ?? '¿',
      textAlign: PdfWidgetEnums.parseTextAlign(
        json['textAlign'] as String?,
      ),
      padding: PdfWidgetEnums.parseEdgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: PdfWidgetEnums.parseEdgeInsets(
            json['margin'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.only(bottom: 5.0 * PdfPageFormat.mm),
    );
  }

  static pw.Spacer parseSpacer(
    Dict json,
  ) {
    return pw.Spacer(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
    );
  }

  static pw.Placeholder parsePlaceholder(
    Dict json,
  ) {
    // TODO
    return pw.Placeholder(
      fallbackWidth: 20 * PdfPageFormat.mm,
      fallbackHeight: 20 * PdfPageFormat.mm,
      color: PdfWidgetEnums.parseColor(
            json['color'] as String?,
          ) ??
          PdfColor.fromInt(0xFF455A64),
    );
  }

  static pw.Opacity parseOpacity(Dict json) {
    return pw.Opacity(
      opacity: double.tryParse(json['opacity'].toString()) ?? 1.0,
      child: PdfWidget.parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  static pw.Divider parseDivider(
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
      color: PdfWidgetEnums.parseColor(
        json['color'] as String?,
      ),
      borderStyle: PdfWidgetEnums.parseBorderStyle(
        json['borderStyle'] as String?,
      ),
    );
  }
}
