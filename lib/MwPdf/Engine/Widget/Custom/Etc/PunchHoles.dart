import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PunchHoles {
  static pw.Widget build({
    pw.Axis direction = pw.Axis.horizontal,
    double offset = 20,
    pw.EdgeInsets? padding,
  }) {
    // TODO define options
    double holeSize = 5.6 * PdfPageFormat.mm;
    double holeSizeHalf = holeSize / 2;
    double margin = (12 * PdfPageFormat.mm) - holeSizeHalf;
    double dist = 80 * PdfPageFormat.mm;
    double firstHole = ((297 * PdfPageFormat.mm) / 2) - (dist * 1.5);
    List<pw.Widget> holes = [];
    for (int nr = 0; nr < 4; nr++) {
      holes.add(
        _hole(
          margin: margin,
          firstHole: firstHole,
          holeSize: holeSize,
          dist: dist * nr,
        ),
      );
    }
    return pw.Stack(
      children: holes,
    );
  }

  static pw.Widget _hole({
    double margin = (12 - 2.8 * PdfPageFormat.mm),
    required double firstHole,
    double holeSize = 5.6 * PdfPageFormat.mm,
    double dist = 80 * PdfPageFormat.mm,
  }) {
    double holeSizeHalf = holeSize / 2;
    return pw.Positioned(
      left: margin,
      top: (firstHole + dist) - holeSizeHalf,
      child: pw.SizedBox(
        width: holeSize,
        height: holeSize,
        child: pw.Circle(
          strokeColor: PdfColors.grey,
        ),
      ),
    );
  }
}
