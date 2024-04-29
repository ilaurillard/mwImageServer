import 'package:mwcdn/MwPdf/Service/Puzzle/kakuro.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Kakuro {
  int size;
  final bool solve;
  final PdfColor color;
  final pw.TextStyle? textStyle;
  final double line1Thickness;
  final double line2Thickness;

  Kakuro({
    this.size = 10,
    this.solve = false,
    this.color = PdfColors.black,
    this.line1Thickness = 0.5,
    this.line2Thickness = 0.25,
    this.textStyle,
  }) {
    if (size < 10) {
      size = 10;
    }
    if (size > 24) {
      size = 24;
    }
  }

  pw.Widget build() {
    Board board = makeBoard(size - 2, size - 2, 0.3);

    List<pw.Widget> cellWidgets = [];

    double line1Thickness = this.line1Thickness * PdfPageFormat.mm;
    // double line2Thickness = this.line2Thickness * PdfPageFormat.mm;

    for (int y = 0; y < board.length; y++) {
      for (int x = 0; x < board[y].length; x++) {
        Cell cell = board[y][x];
        Cell? cellRgt = x < board[y].length - 1 ? board[y][x + 1] : null;
        Cell? cellBlw = y < board.length - 1 ? board[y + 1][x] : null;

        PdfColor? colRgt;
        PdfColor? colBlw;
        if (cell.isHint()) {
          if (cellRgt != null && cellRgt.isHint()) {
            colRgt = PdfColors.white;
          }
          if (cellBlw != null && cellBlw.isHint()) {
            colBlw = PdfColors.white;
          }
        } else {
          if (cellRgt != null && !cellRgt.isHint()) {
            colRgt = PdfColors.grey;
          }
          if (cellBlw != null && !cellBlw.isHint()) {
            colBlw = PdfColors.grey;
          }
        }

        cellWidgets.add(
          pw.Container(
            decoration: pw.BoxDecoration(
              border: pw.Border(
                right: colRgt != null
                    ? pw.BorderSide(
                        color: colRgt,
                        width: line1Thickness,
                      )
                    : pw.BorderSide.none,
                bottom: colBlw != null
                    ? pw.BorderSide(
                        color: colBlw,
                        width: line1Thickness,
                      )
                    : pw.BorderSide.none,
              ),
              color: cell.isHint() ? color : null,
            ),
            child: cell.isHint()
                ? pw.Stack(
                    children: [
                      if (cell.hintv > 0)
                        pw.Padding(
                          padding: pw.EdgeInsets.all(0.5 * PdfPageFormat.mm),
                          child: pw.Align(
                            alignment: pw.Alignment.bottomLeft,
                            child: pw.Text(
                              cell.hintv.toString(),
                              style: textStyle,
                            ),
                          ),
                        ),
                      if (cell.hinth > 0)
                        pw.Padding(
                          padding: pw.EdgeInsets.all(0.5 * PdfPageFormat.mm),
                          child: pw.Align(
                            alignment: pw.Alignment.topRight,
                            child: pw.Text(
                              cell.hinth.toString(),
                              style: textStyle,
                            ),
                          ),
                        ),
                      if (cell.hintv > 0 || cell.hinth > 0)
                        pw.Container(
                          child: pw.SvgImage(
                            width: double.infinity,
                            height: double.infinity,
                            fit: pw.BoxFit.contain,
                            clip: false,
                            colorFilter: PdfColors.white,
                            svg:
                                '<svg height="100" width="100"><line x1="0" y1="0" x2="100" y2="100" stroke="white"  stroke-width="$line1Thickness" stroke-linecap="round"/></svg>',
                          ),
                        ),
                    ],
                  )
                : solve
                    ? pw.Container(
                        child: pw.Center(
                          child: pw.Text(cell.value.toString()),
                        ),
                      )
                    : pw.Container(),
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
