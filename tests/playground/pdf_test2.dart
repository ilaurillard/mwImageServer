import 'dart:io';
import 'dart:convert';
import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;
import 'Engine/PdfEngine.dart';

Future<void> main() async {
  String data = await File('tests/playground/pdf.json').readAsString();

  PdfEngine engine =
      PdfEngine.fromJson(json.decode(data) as Dict);

  // print('Themes: ${engine.themes.length}');
  // print('Headers: ${engine.headers.length}');
  // print('Footers: ${engine.footers.length}');
  // print('Pages: ${engine.pages.length}');

  pw.Document pdf = engine.build();

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

  final file = File('test.pdf');
  await file.writeAsBytes(await pdf.save());
  print('Thank you\n\n');
}












