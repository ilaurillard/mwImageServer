import 'package:pdf/pdf.dart';

import 'package:pdf/widgets.dart' as pw;

class Lane {
  final double laneHeight;
  final double laneGapV;
  final double laneGapH;
  final double laneCornerRadius;
  final double lanePadding;

  const Lane({
    this.laneHeight = 5 * PdfPageFormat.mm,
    this.laneGapV = 1 * PdfPageFormat.mm,
    this.laneGapH = 0.75 * PdfPageFormat.mm,
    this.laneCornerRadius = 2 * PdfPageFormat.mm,
    this.lanePadding = 1.5 * PdfPageFormat.mm,
  });
}
