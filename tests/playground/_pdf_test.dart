// import 'package:test/test.dart';

import 'dart:io';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<void> main() async {
  pw.Document pdf = pw.Document();

  PdfPageFormat pageFormat = PdfPageFormat.a4;

  pw.ThemeData theme = pw.ThemeData.withFont(
    base: pw.Font.courier(),
  );

  pdf.addPage(
    pw.Page(
      pageTheme: pw.PageTheme(
        pageFormat: pageFormat,
        theme: theme,
        // clip: false,
        // orientation: pw.PageOrientation.landscape,
        // textDirection: pw.TextDirection.ltr,
      ),
      build: (pw.Context context) => pw.Center(
        child: pw.Text(pw.LoremText().paragraph(2000)),
      ),
    ),
  );

  // pdf.addPage(
  //   pw.MultiPage(
  //     pageTheme: pw.PageTheme(
  //       pageFormat: pageFormat,
  //       theme: theme,
  //     ),
  //     build: (context) => [
  //       pw.Wrap(
  //         children: [
  //           pw.Text(pw.LoremText().paragraph(40)),
  //         ],
  //       ),
  //       pw.Row(
  //         crossAxisAlignment: pw.CrossAxisAlignment.end,
  //         children: [
  //           pw.Expanded(
  //             child: pw.SizedBox(),
  //           ),
  //           pw.Expanded(
  //             child: pw.Column(
  //               crossAxisAlignment: pw.CrossAxisAlignment.start,
  //               children: [
  //                 pw.Container(
  //                   // decoration: pw.BoxDecoration(
  //                   //   border: pw.Border(top: pw.BorderSide(color: accentColor)),
  //                   // ),
  //                   padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
  //                   child: pw.Text(
  //                     'Terms & Conditions',
  //                     style: pw.TextStyle(
  //                       fontSize: 12,
  //                       // color: baseColor,
  //                       fontWeight: pw.FontWeight.bold,
  //                     ),
  //                   ),
  //                 ),
  //                 pw.Text(
  //                   pw.LoremText().paragraph(40),
  //                   textAlign: pw.TextAlign.justify,
  //                   style: const pw.TextStyle(
  //                     fontSize: 6,
  //                     lineSpacing: 2,
  //                     // color: _darkColor,
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //
  //         ],
  //       ),
  //     ],
  //   ),
  // );

  final file = File('_test.pdf');
  await file.writeAsBytes(await pdf.save());
  print('Thank you\n\n');
}
