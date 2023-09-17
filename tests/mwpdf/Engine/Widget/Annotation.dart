import 'package:pdf/pdf.dart';

class Annotation {
  static PdfOutlineStyle? pdfOutlineStyle(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'normal':
          return PdfOutlineStyle.normal;
        case 'italic':
          return PdfOutlineStyle.italic;
        case 'italicBold':
          return PdfOutlineStyle.italicBold;
        case 'bold':
          return PdfOutlineStyle.bold;
      }
    }
    return null;
  }
}
