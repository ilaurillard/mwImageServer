import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math_64.dart';

import 'Etc.dart';
import 'Internal.dart';
import 'Widget.dart';

class Content {
  static pw.Watermark watermark(
    Dict json,
  ) {
    return pw.Watermark(
      fit: Etc.boxFit(json['fit'] as String?) ?? pw.BoxFit.contain,
      angle: radians(double.tryParse(json['angle'].toString()) ?? 0),
      child: Widget.child(json),
    );
  }

  static pw.Paragraph paragraph(
    Dict json,
  ) {
    return pw.Paragraph(
      text: Etc.replaceParameters(json['text'] as String? ?? '¿'),
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
      style: Etc.textStyle(json['style'] as Dict? ?? {}),
    );
  }

  static pw.Header header(
    Dict json,
  ) {
    return pw.Header(
      title: json['title'] as String?,
      text: json['text'] as String?,
      child: Widget.child(json),
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
      ),
    );
  }

  static pw.Footer footer(
    Dict json,
  ) {
    return pw.Footer(
      leading: json['leading'] != null
          ? Widget.parse(json['leading'] as Dict? ?? {})
          : null,
      title: json['title'] != null
          ? Widget.parse(json['title'] as Dict? ?? {})
          : null,
      trailing: json['trailing'] != null
          ? Widget.parse(json['trailing'] as Dict? ?? {})
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
  ) {
    double? bulletSize = double.tryParse(json['bulletSize'].toString());

    return pw.Bullet(
        text: Etc.replaceParameters(json['text'] as String? ?? '¿'),
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
        style: Etc.textStyle(json['style'] as Dict? ?? {}),
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
