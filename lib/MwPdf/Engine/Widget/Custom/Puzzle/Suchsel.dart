import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwPdf/Service/Puzzle/word_search.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Suchsel {
  final int size;
  final String seed;
  final bool solve;
  final PdfColor color;
  final double line1Thickness;
  final double line2Thickness;
  final pw.TextStyle? textStyle;
  final Datasource? source;

  Suchsel({
    this.size = 10,
    this.seed = '',
    this.solve = false,
    this.color = PdfColors.black,
    this.line1Thickness = 1.5,
    this.line2Thickness = 0.5,
    this.textStyle,
    this.source,
  });

  pw.Widget build() {
    List<String> words = [];
    if (source != null) {
      for (Dict row in source!.data) {
        String w = row['value'] as String? ?? '';
        if (w.isNotEmpty) {
          words.add(w);
        }
      }
    }

    WordSearchBuilder wsb = WordSearchBuilder(
      size: size,
      words: words,
      seed: int.tryParse(seed),
    );
    wsb.create();

    pw.BorderSide bs = pw.BorderSide(
      color: color,
      width: line2Thickness * PdfPageFormat.mm,
    );

    List<pw.Widget> cellWidgets = [];
    for (List<String> row in wsb.grid) {
      for (String s in row) {
        cellWidgets.add(
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border.fromBorderSide(bs),
            ),
            alignment: pw.Alignment.center,
            child: pw.Text(s),
          ),
        );
      }
    }


    List<pw.Widget> strokes = [];
    if (solve) {
      double cc = 100 / size;
      double cc2 = cc / 2;
      for (Option p in wsb.placements) {
        double x1 = p.offset.x * cc + cc2;
        double y1 = p.offset.y * cc + cc2;
        double x2 = p.end.x * cc + cc2;
        double y2 = p.end.y * cc + cc2;
        double w = cc * 0.75;
        strokes.add(
          pw.Opacity(
            opacity: 0.3,
            child: pw.SvgImage(
              width: double.infinity,
              height: double.infinity,
              fit: pw.BoxFit.contain,
              clip: false,
              colorFilter: PdfColors.orange,
              svg:
              '<svg height="100" width="100"><line x1="$x1" y1="$y1" x2="$x2" y2="$y2" stroke="black" stroke-width="$w" stroke-linecap="round"/></svg>',
            ),
          ),
        );
      }
    }

    return pw.Container(
      child: pw.Stack(
        overflow: pw.Overflow.visible,
        children: <pw.Widget>[
          pw.GridView(
            childAspectRatio: 1,
            direction: pw.Axis.vertical,
            crossAxisCount: size,
            children: cellWidgets,
          ),
        ] + strokes,
      ),
    );
  }
}
