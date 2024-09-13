import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class FoldingMarks {
  static pw.Widget build() {
    List<pw.Widget> marks = [
      _mark(
        nr: 1,
      ),
      _mark(
        nr: 2,
      )
    ];
    return pw.Stack(
      children: marks,
    );
  }

  static pw.Widget _mark({
    required int nr,
    double space = 99.0,
    double width = 4.0,
    double strokeWidth = 0.2
  }) {
    return pw.Positioned(
      left: 0 * PdfPageFormat.mm,
      top: ((space - strokeWidth) * nr) * PdfPageFormat.mm,
      child: pw.SizedBox(
        width: width * PdfPageFormat.mm,
        height: strokeWidth * PdfPageFormat.mm,
        child: pw.Rectangle(
          fillColor: PdfColors.black,
        ),
      ),
    );
  }
}
