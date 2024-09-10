import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Markdown/Markdown.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Hyphenation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';

// Note, paragraph is in "Content"
class Text {
  static pw.Widget richText(
    Dict json,
    State state,
  ) {
    String md = state.replaceParameters(json['text'] as String? ?? '');

    String bulletIcon = json['bulletIcon'].toString();
    int? bulletIconCode = int.tryParse(bulletIcon, radix: 16);
    bulletIconCode ??=
        int.parse(State.materialCodes[bulletIcon] ?? 'EF4A', radix: 16);

    if (md.trim().isEmpty) {
      return pw.Container();
    }

    return Markdown(
      md,
      bulletIcon: bulletIconCode,
      colorCode: Util.color(json['colorCode'] as String?) ?? PdfColors.grey200,
      fontCode: Util.font(
        json['fontCode'] as String?,
        state,
      ),
      margin1:
          (double.tryParse(json['margin1'].toString()) ?? 5) * PdfPageFormat.mm,
      margin2:
          (double.tryParse(json['margin2'].toString()) ?? 3) * PdfPageFormat.mm,
      margin3: (double.tryParse(json['margin3'].toString()) ?? 1.5) *
          PdfPageFormat.mm,
      fontSize1: (double.tryParse(json['fontSize1'].toString()) ?? 12) *
          PdfPageFormat.mm,
      fontSize2: (double.tryParse(json['fontSize2'].toString()) ?? 10) *
          PdfPageFormat.mm,
      fontSize3: (double.tryParse(json['fontSize3'].toString()) ?? 8) *
          PdfPageFormat.mm,
      fontSize4: (double.tryParse(json['fontSize4'].toString()) ?? 6) *
          PdfPageFormat.mm,
      fontSize5: (double.tryParse(json['fontSize5'].toString()) ?? 4) *
          PdfPageFormat.mm,
      colorQuote:
          Util.color(json['colorQuote'] as String?) ?? PdfColors.grey200,
      style: Util.textStyle(
        json['style'] as Dict? ?? {},
        state,
      ),
    ).toRichText();
  }

  static HyphenatedText text(
    Dict json,
    State state,
  ) {
    String text = json['text'] as String? ?? '';
    String source = json['source'] as String? ?? '';
    if (source.isNotEmpty) {
      text = state
          .source(
            json['source'] as String?,
          )
          .text;
    }

    // if (text.isEmpty) {
    //   text = '%value%';
    // }

    text = state.replaceParameters(text);

    String hyphLang = json['hyphenationLanguage'] as String? ?? '';

    return HyphenatedText(
      text,
      style: Util.textStyle(
        (json['style'] as Dict?) ?? {},
        state,
      ),
      textAlign: Util.textAlign(
        json['textAlign'] as String?,
      ),
      textDirection: Util.textDirection(
        json['textDirection'] as String?,
      ),
      softWrap: json['softWrap'] as bool?,
      tightBounds: Types.boolFromDict(json, 'tightBounds'),
      textScaleFactor:
          double.tryParse(json['textScaleFactor'].toString()) ?? 1.0,
      maxLines: int.tryParse(json['maxLines'].toString()),
      overflow: Util.textOverflow(json['overflow'] as String?),
      hyphenation:
          hyphLang.isNotEmpty ? state.hyphenator(language: hyphLang) : null,
    );
  }
}
