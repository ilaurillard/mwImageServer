import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Internal.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Util.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Annotation {

  // static pw.SquareAnnotation squareAnnotation(
  //     Dict json,
  //     State state,
  //     ) {
  //   return pw.SquareAnnotation(
  //     child: pw.Text("xxx"),
  //     color: PdfColors.green,
  //     // interiorColor: PdfColor.fromHex('88888833'),
  //     subject: "subject",
  //     content: "content",
  //     date: DateTime.now(),
  //   );
  // }

  static pw.Outline outline(
    Dict json,
    State state,
  ) {
    return pw.Outline(
      title: json['title'] as String? ?? '?',
      name: json['name'] as String? ?? '?',
      child: json['child'] != null
          ? Widget.child(
              json,
              state,
            )
          : null,
      level: json['level'] as int? ?? 0,
      color: Util.color(
        json['color'] as String?,
      ),
      style: Internal.pdfOutlineStyle(
            json['style'] as String?,
          ) ??
          PdfOutlineStyle.normal,
    );
  }

  static pw.UrlLink urlLink(
    Dict json,
    State state,
  ) {
    return pw.UrlLink(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  // link to anchor --->
  static pw.Link link(
    Dict json,
    State state,
  ) {
    return pw.Link(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static pw.Anchor anchor(
    Dict json,
    State state,
  ) {
    return pw.Anchor(
      name: json['name'] as String? ?? '?',
      child: Widget.child(
        json,
        state,
      ),
      description: json['description'] as String? ?? '?',
      zoom: double.tryParse(json['zoom'].toString()),
      setX: json['setX'] as bool? ?? false,
    );
  }
}
