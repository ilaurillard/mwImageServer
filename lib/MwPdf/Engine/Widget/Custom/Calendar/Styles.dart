import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;


class Styles {
  final PdfColor cellColor;
  final PdfColor cellColorToday;
  final PdfColor cellColorEnd;
  final PdfColor textColorCurrent;
  final PdfColor textColorSpecial;
  final bool weekendStrong;
  final PdfColor borderColor;
  final pw.TextStyle textStyle;
  final double cellAspect;
  final bool highlightToday;


  const Styles({
    this.cellAspect = 1.0,
    this.borderColor = PdfColors.white,
    this.cellColor = PdfColors.grey200,
    this.cellColorToday = PdfColors.lightBlue50,
    this.cellColorEnd = PdfColors.green100,
    this.textStyle = const pw.TextStyle(),
    this.textColorCurrent = PdfColors.red,
    this.textColorSpecial = PdfColors.red,
    this.weekendStrong = true,
    this.highlightToday = false,
  });
}
