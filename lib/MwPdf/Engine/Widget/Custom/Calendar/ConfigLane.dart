import 'package:pdf/pdf.dart';

class ConfigLane {
  final double laneHeight;
  final double laneGapV;
  final double laneGapH;
  final double laneCornerRadius;
  final double lanePadding;

  const ConfigLane({
    this.laneHeight = 5 * PdfPageFormat.mm,
    this.laneGapV = 1 * PdfPageFormat.mm,
    this.laneGapH = 0.75 * PdfPageFormat.mm,
    this.laneCornerRadius = 2 * PdfPageFormat.mm,
    this.lanePadding = 1.5 * PdfPageFormat.mm,
  });
}
