import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:mwcdn/MwPdf/Engine/Etc/ColPage.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  Uint8List pdf = await generate(
    PdfPageFormat(
      20 * PdfPageFormat.cm,
      20 * PdfPageFormat.cm,
      marginAll: 1.0 * PdfPageFormat.cm,
    ),
  );

  final file = File('_test.pdf');
  await file.writeAsBytes(pdf);
  print('Thank you\n\n');
}

pw.Widget _buildHeader(
  pw.Context context,
) {
  return pw.Container(
    height: 40,
    alignment: pw.Alignment.centerLeft,
    child: pw.Text(
      'HEADER',
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}

pw.Widget _buildFooter(
  pw.Context context,
) {
  return pw.Container(
    height: 40,
    alignment: pw.Alignment.centerLeft,
    child: pw.Text(
      'FOOTER',
      style: pw.TextStyle(
        fontWeight: pw.FontWeight.bold,
        fontSize: 20,
      ),
    ),
  );
}

Future<Uint8List> generate(
  PdfPageFormat format,
) async {
  final doc = pw.Document(
    title: 'test',
  );

  doc.addPage(
    ColPage(
        pageFormat: format,
        columns: 1,
        gapWidth: 7 * PdfPageFormat.mm,
        header: _buildHeader,
        footer: _buildFooter,
        build: (
          pw.Context context,
        ) {
          return [
            pw.Paragraph(
                text: pw.LoremText(random: math.Random(123)).paragraph(50)),
            // pw.Paragraph(
            //     text: pw.LoremText(random: math.Random(124)).paragraph(30)),
            // pw.Paragraph(
            //     text: pw.LoremText(random: math.Random(125)).paragraph(30)),
            // pw.Paragraph(
            //     text: pw.LoremText(random: math.Random(126)).paragraph(50)),
            // pw.Paragraph(
            //     text: pw.LoremText(random: math.Random(127)).paragraph(50)),
            // pw.Paragraph(
            //     text: pw.LoremText(random: math.Random(128)).paragraph(50)),
          ];
        }),
  );

  return doc.save();
}
