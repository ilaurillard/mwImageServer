import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Hyphenation.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math_64.dart';

import 'Internal.dart';
import 'Util.dart';
import 'Widget.dart';

class Content {
  static pw.Watermark watermark(
    Dict json,
    State state,
  ) {
    return pw.Watermark(
      fit: Util.boxFit(json['fit'] as String?) ?? pw.BoxFit.contain,
      angle: radians(double.tryParse(json['angle'].toString()) ?? 0),
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static HyphenatedParagraph paragraph(
    Dict json,
    State state,
  ) {
    String text = Util.replaceParameters(
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
    String hyphLang = json['hyphenationLanguage'] as String? ?? '';
    return HyphenatedParagraph(
      text: text,
      textAlign: Util.textAlign(
            json['textAlign'] as String?,
          ) ??
          pw.TextAlign.justify,
      padding: Util.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: Util.edgeInsets(
            json['margin'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.only(bottom: 5.0 * PdfPageFormat.mm),
      style: Util.textStyle(
        json['style'] as Dict? ?? {},
        state,
      ),
      hyphenation:
          hyphLang.isNotEmpty ? state.hyphenator(language: hyphLang) : null,
    );
  }

  static pw.Header header(
    Dict json,
    State state,
  ) {
    return pw.Header(
      title: json['title'] as String?,
      text: json['text'] as String?,
      child: json['child'] != null
          ? Widget.child(
              json,
              state,
            )
          : null,
      level: json['level'] as int? ?? 0,
      decoration: Util.boxDecoration(
        (json['decoration'] as Dict?) ?? {},
        state,
      ),
      outlineColor: Util.color(
        json['outlineColor'] as String?,
      ),
      outlineStyle: Internal.pdfOutlineStyle(
            json['outlineStyle'] as String?,
          ) ??
          PdfOutlineStyle.normal,
      margin: Util.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: Util.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      textStyle: Util.textStyle(
        (json['textStyle'] as Dict?) ?? {},
        state,
      ),
    );
  }

  static pw.Footer footer(
    Dict json,
    State state,
  ) {
    return pw.Footer(
      leading: json['leading'] != null
          ? Widget.parse(
              json['leading'] as Dict? ?? {},
              state,
            )
          : null,
      title: json['title'] != null
          ? Widget.parse(
              json['title'] as Dict? ?? {},
              state,
            )
          : null,
      trailing: json['trailing'] != null
          ? Widget.parse(
              json['trailing'] as Dict? ?? {},
              state,
            )
          : null,
      margin: Util.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: Util.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      decoration: Util.boxDecoration(
        (json['decoration'] as Dict?) ?? {},
        state,
      ),
    );
  }

  static pw.TableOfContent tableOfContent(
      Dict json,
      State state,
      ) {
    return pw.TableOfContent();
  }

  static pw.Bullet bullet(
    Dict json,
    State state,
  ) {
    double? bulletSize = double.tryParse(
      json['bulletSize'].toString(),
    );

    return pw.Bullet(
        text: Util.replaceParameters(
          json['text'] as String? ?? '',
          state,
        ),
        textAlign: Util.textAlign(
              json['textAlign'] as String?,
            ) ??
            pw.TextAlign.left,
        padding: Util.edgeInsets(
          json['padding'] as List<dynamic>?,
        ),
        margin: Util.edgeInsets(
              json['margin'] as List<dynamic>?,
            ) ??
            const pw.EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
        style: Util.textStyle(
          json['style'] as Dict? ?? {},
          state,
        ),
        bulletMargin: Util.edgeInsets(
              json['bulletMargin'] as List<dynamic>?,
            ) ??
            const pw.EdgeInsets.only(
              top: 1.5 * PdfPageFormat.mm,
              left: 5.0 * PdfPageFormat.mm,
              right: 2.0 * PdfPageFormat.mm,
            ),
        bulletSize: bulletSize != null
            ? bulletSize * PdfPageFormat.mm
            : 2.0 * PdfPageFormat.mm,
        bulletShape:
            Util.boxShape(json['bulletShape'] as String?) ?? pw.BoxShape.circle,
        bulletColor:
            Util.color(json['bulletColor'] as String?) ?? PdfColors.black);
  }
}
