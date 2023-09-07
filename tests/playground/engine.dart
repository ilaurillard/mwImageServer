import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Engine/PdfEngine.dart';

Map<String, pw.Font> fontRegistry = {};
String exampleSvg = '';

Future<void> main() async {

  exampleSvg = await File('tests/playground/files/logo.svg').readAsString();

  fontRegistry['openSansRegular'] = pw.Font.ttf(
    ByteData.view(
      (await File('tests/playground/files/Open Sans Regular.ttf').readAsBytes())
          .buffer,
    ),
  );

  fontRegistry['material'] = pw.Font.ttf(
    ByteData.view(
      (await File('tests/playground/files/MaterialIcons-Regular.ttf').readAsBytes())
          .buffer,
    ),
  );

  // -----------------------

  // String jsonFile = 'pdf_simple.json';
  // String jsonFile = 'pdf_simple2.json';
  // String jsonFile = 'pdf_simple3.json';
  // String jsonFile = 'pdf_simple4.json';
  String jsonFile = 'pdf_simple5.json';
  // String jsonFile = 'pdf_table.json';
  // String jsonFile = 'pdf_charts.json';
  // String jsonFile = 'pdf_barcodes.json';

  String data = await File('tests/playground/$jsonFile').readAsString();
  PdfEngine engine = PdfEngine.fromJson(json.decode(data) as Dict);

  // print('Themes: ${engine.themes.length}');
  // print('Headers: ${engine.headers.length}');
  // print('Footers: ${engine.footers.length}');
  // print('Pages: ${engine.pages.length}');

  pw.Document pdf = engine.build();

  String name = '$jsonFile.pdf';
  final file = File(name);
  await file.writeAsBytes(await pdf.save());
  print('Thank you, parsed "$jsonFile", wrote "$name" (${engine.pages.length} pages) ... \n\n');
}
