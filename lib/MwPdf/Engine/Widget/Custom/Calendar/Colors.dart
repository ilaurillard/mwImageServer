import 'package:pdf/pdf.dart';

class Colors {
  final PdfColor cell;
  final PdfColor cellToday;
  final PdfColor cellWeekend;
  final PdfColor textCurrent;
  final PdfColor textSpecial;
  final PdfColor border;
  final double muteOpacity;

  const Colors({
    this.border = PdfColors.white,
    this.cell = PdfColors.grey200,
    this.cellToday = PdfColors.lightBlue50,
    this.cellWeekend = PdfColors.lightGreen100,
    this.textCurrent = PdfColors.blue,
    this.textSpecial = PdfColors.red,
    this.muteOpacity = 0.35,
  });
}
