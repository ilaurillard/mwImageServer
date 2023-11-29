import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Markdown/Markdown.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';

class Text {
  static pw.Widget richText(
    Dict json,
    State state,
  ) {
    String md = json['text'] as String? ?? '';

    String bulletIcon = json['bulletIcon'].toString();
    int? bulletIconCode = int.tryParse(bulletIcon, radix: 16);
    bulletIconCode ??=
        int.parse(State.materialCodes[bulletIcon] ?? 'EF4A', radix: 16);

    return Markdown(
      md,
      bulletIcon: bulletIconCode,
      colorCode: Etc.color(json['colorCode'] as String?) ?? PdfColors.grey200,
      fontCode: Etc.font(
        json['fontCode'] as String?,
        state,
      ),
      margin1: (double.tryParse(json['margin1'].toString()) ?? 8) * PdfPageFormat.mm,
      margin2: (double.tryParse(json['margin2'].toString()) ?? 3) * PdfPageFormat.mm,
      margin3: (double.tryParse(json['margin3'].toString()) ?? 1.5) * PdfPageFormat.mm,
      fontSize1: (double.tryParse(json['fontSize1'].toString()) ?? 12) * PdfPageFormat.mm,
      fontSize2: (double.tryParse(json['fontSize2'].toString()) ?? 10) * PdfPageFormat.mm,
      fontSize3: (double.tryParse(json['fontSize3'].toString()) ?? 8) * PdfPageFormat.mm,
      fontSize4: (double.tryParse(json['fontSize4'].toString()) ?? 6) * PdfPageFormat.mm,
      fontSize5: (double.tryParse(json['fontSize5'].toString()) ?? 4) * PdfPageFormat.mm,

      colorQuote: Etc.color(json['colorQuote'] as String?) ?? PdfColors.grey200,
    ).toRichText();
  }

  static pw.Text text(
    Dict json,
    State state,
  ) {
    String text = Etc.replaceParameters(
      json['text'] as String? ?? '',
      state,
    );
    if (text.isEmpty) {
      text = state
          .source(
            json['source'] as String?,
          )
          .text;
    }
    return pw.Text(
      text,
      style: Etc.textStyle(
        (json['style'] as Dict?) ?? {},
        state,
      ),
      textAlign: Etc.textAlign(
        json['textAlign'] as String?,
      ),
      textDirection: Etc.textDirection(
        json['textDirection'] as String?,
      ),
      softWrap: json['softWrap'] as bool?,
      tightBounds: Types.boolFromDict(json, 'tightBounds'),
      textScaleFactor:
          double.tryParse(json['textScaleFactor'].toString()) ?? 1.0,
      maxLines: int.tryParse(json['maxLines'].toString()),
      overflow: Etc.textOverflow(json['overflow'] as String?),
    );
  }
}
