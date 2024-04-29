import 'package:pdf/pdf.dart';

class ConfigDay {
  final double heightHour;

  final int firstHour;
  final int lastHour;

  final double entryCornerRadius;

  const ConfigDay({
    this.heightHour = 7 * PdfPageFormat.mm,
    this.firstHour = 8,
    this.lastHour = 20,
    this.entryCornerRadius = 1 * PdfPageFormat.mm,
  });
}
