import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

class Day {
  final double heightHour;

  final int firstHour;
  final int lastHour;

  final double entryCornerRadius;

  const Day({
    this.heightHour = 7 * PdfPageFormat.mm,
    this.firstHour = 8,
    this.lastHour = 20,
    this.entryCornerRadius = 1 * PdfPageFormat.mm,
  });
}
