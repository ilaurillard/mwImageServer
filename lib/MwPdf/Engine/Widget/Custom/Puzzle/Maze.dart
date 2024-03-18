import 'package:mwcdn/MwPdf/Service/Maze/maze_builder.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Maze {
  final int size;
  final String seed;
  final bool solve;
  final PdfColor color;
  final double line1Thickness;
  final double line2Thickness;
  final pw.TextStyle? textStyle;

  Maze({
    this.size = 20,
    this.seed = '',
    this.solve = false,
    this.color = PdfColors.black,
    this.line1Thickness = 1.5,
    this.line2Thickness = 0.5,
    this.textStyle,
  });

  pw.Widget build() {
    List<List<Cell>> maze = generate(
      size: size,
      seed: int.tryParse(seed) ?? 1,
    );

    pw.BorderSide brd = pw.BorderSide(
      color: color,
      width: line2Thickness * PdfPageFormat.mm,
    );

    List<pw.Widget> cellWidgets = [];
    for (List<Cell> row in maze) {
      for (Cell cell in row) {
        cellWidgets.add(
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                top: cell.top ? brd : pw.BorderSide.none,
                left: cell.left ? brd : pw.BorderSide.none,
                bottom: cell.bottom ? brd : pw.BorderSide.none,
                right: cell.right ? brd : pw.BorderSide.none,
              ),
            ),
            alignment: pw.Alignment.center,
          ),
        );
      }
    }

    return pw.Container(
      child: pw.GridView(
        childAspectRatio: 1,
        direction: pw.Axis.vertical,
        crossAxisCount: size,
        children: cellWidgets,
      ),
    );
  }
}
