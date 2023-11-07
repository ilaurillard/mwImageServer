import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math_64.dart';

import 'Etc.dart';
import 'Internal.dart';
import 'Widget.dart';

class Content {
  static pw.Watermark watermark(
    Dict json,
    State state,
  ) {
    return pw.Watermark(
      fit: Etc.boxFit(json['fit'] as String?) ?? pw.BoxFit.contain,
      angle: radians(double.tryParse(json['angle'].toString()) ?? 0),
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static pw.Paragraph paragraph(
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
    return pw.Paragraph(
      text: text,
      textAlign: Etc.textAlign(
            json['textAlign'] as String?,
          ) ??
          pw.TextAlign.justify,
      padding: Etc.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: Etc.edgeInsets(
            json['margin'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.only(bottom: 5.0 * PdfPageFormat.mm),
      style: Etc.textStyle(
        json['style'] as Dict? ?? {},
        state,
      ),
    );
  }

  static pw.Header header(
    Dict json,
    State state,
  ) {
    return pw.Header(
      title: json['title'] as String?,
      text: json['text'] as String?,
      child: Widget.child(
        json,
        state,
      ),
      level: json['level'] as int? ?? 0,
      decoration: Etc.boxDecoration((json['decoration'] as Dict?) ?? {}),
      outlineColor: Etc.color(
        json['outlineColor'] as String?,
      ),
      outlineStyle: Internal.pdfOutlineStyle(
            json['outlineStyle'] as String?,
          ) ??
          PdfOutlineStyle.normal,
      margin: Etc.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: Etc.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      textStyle: Etc.textStyle(
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
      margin: Etc.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: Etc.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      decoration: Etc.boxDecoration((json['decoration'] as Dict?) ?? {}),
    );
  }

  static pw.Bullet bullet(
    Dict json,
    State state,
  ) {
    double? bulletSize = double.tryParse(json['bulletSize'].toString());

    return pw.Bullet(
        text: Etc.replaceParameters(
          json['text'] as String? ?? '',
          state,
        ),
        textAlign: Etc.textAlign(
              json['textAlign'] as String?,
            ) ??
            pw.TextAlign.left,
        padding: Etc.edgeInsets(
          json['padding'] as List<dynamic>?,
        ),
        margin: Etc.edgeInsets(
              json['margin'] as List<dynamic>?,
            ) ??
            const pw.EdgeInsets.only(bottom: 2.0 * PdfPageFormat.mm),
        style: Etc.textStyle(
          json['style'] as Dict? ?? {},
          state,
        ),
        bulletMargin: Etc.edgeInsets(
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
            Etc.boxShape(json['bulletShape'] as String?) ?? pw.BoxShape.circle,
        bulletColor:
            Etc.color(json['bulletColor'] as String?) ?? PdfColors.black);
  }
}
