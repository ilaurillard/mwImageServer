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
    json = _lineaturPreset(json);

    return pw.Stack(
      children: [
        // Linien ---------------
        pw.Container(
          color: Util.color(json['bgColor'] as String?),
          padding: Util.edgeInsets(
                json['paddingLines'] as List<dynamic>?,
              ) ??
              pw.EdgeInsets.zero,
          child: pw.Row(
            children: _columns(
              divisions: ((json['divisions'] as List<dynamic>?) ?? [1]).cast(),
              gap: double.tryParse(json['gap'].toString()) ?? 0.0,
              amountLines: json['amountLines'] as int? ?? 10,
              lineHeight: double.tryParse(json['lineHeight'].toString()) ?? 9.0,
              lineGap: double.tryParse(json['lineGap'].toString()) ?? 0.0,
              top: json['top'] as bool? ?? false,
              boxed: json['boxed'] as bool? ?? false,
              lineDivisions:
                  ((json['lineDivisions'] as List<dynamic>?) ?? [1]).cast(),
              color: Util.color(json['lineColor'] as String?),
              colorSublines: Util.color(json['lineColorSub'] as String?),
              thickness: double.tryParse(json['thickness'].toString()) ?? 0.2,
              thicknessSublines:
                  double.tryParse(json['thicknessSub'].toString()) ?? 0.1,
              bgColor: Util.color(json['lineBgColor'] as String?),
              childLine: Widget.parse(
                json['childLine'] as Dict? ?? {},
                state,
              ),
            ),
          ),
        ),
        // Korrekturrand ---------------
        _raender(
          at: ((json['marginLinesAt'] as List<dynamic>?) ?? [])
              .map((e) => double.parse(e.toString()))
              .toList(),
          thickness: double.tryParse(json['thicknessMargin'].toString()) ?? 0.1,
        ),
        // Inhalt -----------------------
        pw.Padding(
          padding: Util.edgeInsets(
                json['paddingContent'] as List<dynamic>?,
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
    pw.Widget? childLine,
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
          last: n == amount - 1,
          bgColor: bgColor,
          child: childLine,
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
    bool last = false,
    pw.Widget? child,
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
              // color: bgColor,
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
        bottom: last ? 0 : gap * PdfPageFormat.mm,
      ),
      child: pw.Container(
        decoration: pw.BoxDecoration(
          color: bgColor,
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
        ),
        height: height * PdfPageFormat.mm,
        child: pw.Stack(
          children: [
            pw.Column(
              children: sublines,
            ),
            if (child != null) child,
          ],
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
    pw.Widget? childLine,
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
                childLine: childLine,
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

  static Dict _lineaturPreset(Dict json) {
    Dict common1 = {
      'lineColor': 'AAAAAA',
      'lineColorSub': 'AAAAAA',
      'bgColor': 'EEEEFF',
      'lineBgColor': 'FFFFFF',
      'thickness': 0.2,
      'thicknessSub': 0.1,
      'boxed': true,
    };
    Dict base = {};

    String preset = json['preset'] as String? ?? '';
    switch (preset) {
      case '0-a5':
        base = {
          ...common1,
          ...{
            'amountLines': 5,
            'lineHeight': 18,
            'lineGap': 9.5,
            'lineDivisions': [1, 1, 1],
            'paddingLines': [10],
            'paddingContent': [10],
          }
        };
        break;
      case '1-a4':
        base = {
          ...common1,
          ...{
            'amountLines': 14,
            'lineHeight': 15,
            'lineGap': 5,
            'lineDivisions': [1, 1, 1],
            'paddingLines': [10],
            'paddingContent': [10],
          }
        };
        break;
      case '1q-a5':
        base = {
          ...common1,
          ...{
            'amountLines': 7,
            'lineHeight': 15,
            'lineGap': 4,
            'lineDivisions': [1, 1, 1],
            'paddingLines': [10, 10, 10, 9],
            'paddingContent': [10, 10, 10, 9],
          }
        };
        break;
      case '2-a4':
        base = {
          ...common1,
          ...{
            'amountLines': 17,
            'lineHeight': 12,
            'lineGap': 4.5,
            'lineDivisions': [1, 1, 1],
            'paddingLines': [10],
            'paddingContent': [10],
          }
        };
        break;
      case '2W-a5':
        base = {
          ...common1,
          ...{
            'gap': 5,
            'divisions': [1,1],
            'amountLines': 12,
            'lineHeight': 12,
            'lineGap': 2.5,
            'lineDivisions': [1, 1, 1],
            'paddingLines': [10, 15, 10, 15],
            'paddingContent': [10, 15, 10, 15],
          }
        };
        break;
      case '3-a4':
        base = {
          'amountLines': 14,
          'boxed': true,
          'lineHeight': 4,
          'thickness': 0.2,
          'lineGap': 13.0,
          'paddingLines': [20, 30, 10, 30],
          'paddingContent': [20, 30, 10, 30],
          'lineColor': 'AAAAAA',
        };
        break;
      case '3R-a4':
        base = {
          'amountLines': 21,
          'boxed': true,
          'lineHeight': 4,
          'thickness': 0.2,
          'lineGap': 8.0,
          'paddingLines': [40, 28, 10, 12],
          'paddingContent': [40, 20, 10, 20],
          'lineColor': 'AAAAAA',
          'marginLinesAt': [40],
          'thicknessMargin': 0.3,
        };
        break;
      case '3Rr-a4':
        base = {
          'amountLines': 21,
          'boxed': true,
          'lineHeight': 4,
          'thickness': 0.2,
          'lineGap': 8.0,
          'paddingLines': [10, 28, 40, 12],
          'paddingContent': [10, 20, 40, 20],
          'lineColor': 'AAAAAA',
          'marginLinesAt': [170],
          'thicknessMargin': 0.3,
        };
        break;
      default:
        base = {};
    }

    return {...base, ...json};
  }
}
