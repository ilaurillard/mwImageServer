import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Engine/PdfEngine.dart';

Future<void> main() async {
  // String data = await File('tests/playground/pdf_simple.json').readAsString();
  // String data = await File('tests/playground/pdf_simple2.json').readAsString();
  String data = await File('tests/playground/pdf_simple3.json').readAsString();
  // String data = await File('tests/playground/pdf_table.json').readAsString();
  // String data = await File('tests/playground/pdf_charts.json').readAsString();
  // String data = await File('tests/playground/pdf_barcodes.json').readAsString();

  PdfEngine engine = PdfEngine.fromJson(json.decode(data) as Dict);

  // print('Themes: ${engine.themes.length}');
  // print('Headers: ${engine.headers.length}');
  // print('Footers: ${engine.footers.length}');
  // print('Pages: ${engine.pages.length}');

  pw.Document pdf = engine.build();

  final file = File('_test2.pdf');
  await file.writeAsBytes(await pdf.save());
  print('Thank you\n\n');
}
