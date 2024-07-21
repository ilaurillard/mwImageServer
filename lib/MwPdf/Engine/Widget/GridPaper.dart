import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';
import 'Widget.dart';

class GridPaper {
  static const lineColor = PdfColor.fromInt(0xffc3e8f3);

  static pw.Widget writingPaper(
    Dict json,
    State state,
  ) {
    return pw.Stack(
      children: [
        // Linien ---------------
        pw.Padding(
          padding: Util.edgeInsets(
                json['paddingLines'] as List<dynamic>?,
              ) ??
              pw.EdgeInsets.zero,
          child: pw.Container(
            color: Util.color(json['bgColor'] as String?),
            child: pw.Row(
              children: _columns(
                divisions: ((json['divisions'] as List<dynamic>?) ?? []).cast(),
                gap: double.tryParse(json['gap'].toString()) ?? 0.0,
                amountLines: json['amountLines'] as int? ?? 10,
                lineHeight:
                    double.tryParse(json['lineHeight'].toString()) ?? 9.0,
                lineGap: double.tryParse(json['lineGap'].toString()) ?? 0.0,
                top: json['top'] as bool? ?? false,
                boxed: json['boxed'] as bool? ?? false,
                lineDivisions:
                    ((json['lineDivisions'] as List<dynamic>?) ?? []).cast(),
                color: Util.color(json['lineColor'] as String?),
                colorSublines: Util.color(json['lineColorSub'] as String?),
                thickness: double.tryParse(json['thickness'].toString()) ?? 0.2,
                thicknessSublines:
                    double.tryParse(json['thicknessSub'].toString()) ?? 0.1,
                bgColor: Util.color(json['lineBgColor'] as String?),
              ),
            ),
          ),
        ),
        // Korrekturrand ---------------
        _raender(
          at: ((json['marginLines'] as List<dynamic>?) ?? [])
              .map((e) => double.parse(e.toString()))
              .toList(),
          thickness: double.tryParse(json['thicknessMargin'].toString()) ?? 0.1,
        ),
        // Inhalt -----------------------
        pw.Padding(
          padding: Util.edgeInsets(
                json['padding'] as List<dynamic>?,
              ) ??
              pw.EdgeInsets.zero,
          child: Widget.child(
            json,
            state,
          ),
        ),
      ],
    );
  }

  static List<pw.Widget> _lines({
    required int amount,
    required double height,
    required double gap,
    required bool top,
    required bool boxed,
    required List<int> divisions,
    PdfColor? color,
    PdfColor? colorSublines,
    double thickness = 0.2,
    double thicknessSublines = 0.1,
    PdfColor? bgColor,
  }) {
    List<pw.Widget> lines = [];
    for (int n = 0; n < amount; n++) {
      lines.add(
        _line(
          height: height,
          gap: gap,
          top: top,
          boxed: boxed,
          divisions: divisions,
          color: color,
          colorSublines: colorSublines,
          thickness: thickness,
          thicknessSublines: thicknessSublines,
          first: n == 0,
          bgColor: bgColor,
        ),
      );
    }

    return lines;
  }

  static pw.Widget _line({
    required double height,
    required double gap,
    required bool top,
    required bool boxed,
    required List<int> divisions,
    PdfColor? color,
    PdfColor? colorSublines,
    double thickness = 0.2,
    double thicknessSublines = 0.1,
    PdfColor? bgColor,
    bool first = false,
  }) {
    List<pw.Expanded> sublines = [];

    int n = 0;
    for (int d in divisions) {
      bool last = n == divisions.length - 1;
      sublines.add(
        pw.Expanded(
          flex: d,
          child: pw.Container(
            decoration: pw.BoxDecoration(
              color: bgColor,
              border: pw.Border(
                bottom: pw.BorderSide(
                    width: (last ? thickness : thicknessSublines) *
                        PdfPageFormat.mm,
                    color: last
                        ? (color ?? PdfColors.black)
                        : (colorSublines ?? PdfColors.black)),
              ),
            ),
          ),
        ),
      );
      n++;
    }

    return pw.Padding(
      padding: pw.EdgeInsets.only(
        bottom: gap * PdfPageFormat.mm,
      ),
      child: pw.Container(
        decoration: boxed || gap > 0.0
            ? pw.BoxDecoration(
                border: pw.Border(
                  top: (boxed || top) && (first || gap > 0.0)
                      ? pw.BorderSide(
                          width: thickness * PdfPageFormat.mm,
                          color: (color ?? PdfColors.black),
                        )
                      : pw.BorderSide.none,
                  left: boxed
                      ? pw.BorderSide(
                          width: thickness * PdfPageFormat.mm,
                          color: (color ?? PdfColors.black),
                        )
                      : pw.BorderSide.none,
                  right: boxed
                      ? pw.BorderSide(
                          width: thickness * PdfPageFormat.mm,
                          color: (color ?? PdfColors.black),
                        )
                      : pw.BorderSide.none,
                ),
              )
            : null,
        height: height * PdfPageFormat.mm,
        child: pw.Column(
          children: sublines,
        ),
      ),
    );
  }

  static pw.Widget _raender({
    List<double> at = const [],
    PdfColor? color,
    double thickness = 0.1,
    double marginTop = 0.0,
    double marginBottom = 0.0,
  }) {
    if (at.isEmpty) {
      return pw.Container();
    }

    List<pw.Partition> children = [];

    double s = 0;
    for (double a in at) {
      children.add(
        pw.Partition(
          width: (a - s) * PdfPageFormat.mm,
          child: pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                right: pw.BorderSide(
                  width: thickness * PdfPageFormat.mm,
                  color: color ?? PdfColors.black,
                ),
              ),
            ),
          ),
        ),
      );
      s += (a - s);
    }

    return pw.Padding(
      padding: pw.EdgeInsets.fromLTRB(
        0 * PdfPageFormat.mm,
        marginTop * PdfPageFormat.mm,
        0 * PdfPageFormat.mm,
        marginBottom * PdfPageFormat.mm,
      ),
      child: pw.Partitions(
        children: children,
      ),
    );
  }

  static List<pw.Widget> _columns({
    List<int> divisions = const [1],
    double gap = 0.0,
    required int amountLines,
    required double lineHeight,
    double lineGap = 0.0,
    bool top = false,
    bool boxed = false,
    List<int> lineDivisions = const [1],
    PdfColor? color,
    PdfColor? colorSublines,
    double thickness = 0.2,
    double thicknessSublines = 0.1,
    PdfColor? bgColor,
  }) {
    List<pw.Widget> cols = [];

    int n = 0;
    for (int f in divisions) {
      bool last = n == divisions.length - 1;
      cols.add(
        pw.Expanded(
          flex: f,
          child: pw.Container(
            child: pw.Column(
              children: _lines(
                top: top,
                boxed: boxed,
                amount: amountLines,
                height: lineHeight,
                gap: lineGap,
                divisions: lineDivisions,
                thickness: thickness,
                thicknessSublines: thicknessSublines,
                color: color,
                colorSublines: colorSublines,
                bgColor: bgColor,
              ),
            ),
          ),
        ),
      );
      if (gap > 0.0 && !last) {
        cols.add(
          pw.Container(
            width: gap * PdfPageFormat.mm,
          ),
        );
      }
      n++;
    }

    return cols;
  }

  static pw.GridPaper gridPaper(
    Dict json,
    State state,
  ) {
    double? interval = double.tryParse(json['interval'].toString());

    return pw.GridPaper(
      color: Util.color(
            json['color'] as String?,
          ) ??
          lineColor,
      interval: interval != null ? interval * PdfPageFormat.mm : 100.0,
      divisions: int.tryParse(json['divisions'].toString()) ?? 5,
      subdivisions: int.tryParse(json['subdivisions'].toString()) ?? 2,
      child: Widget.child(
        json,
        state,
      ),
    );
  }
}
