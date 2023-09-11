import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Engine/PdfEngine.dart';

Map<String, String> fontMaterialMap = {};
Map<String, pw.Font> fontRegistry = {};
String exampleSvg = '';
pw.MemoryImage exampleImage = pw.MemoryImage(Uint8List(1));

Future<void> main() async {
  exampleSvg = await File('tests/mwpdf/files/logo.svg').readAsString();
  exampleImage = pw.MemoryImage(
    await File('tests/mwpdf/files/profile.jpg').readAsBytes(),
  );

  fontRegistry['openSansRegular'] = pw.Font.ttf(
    ByteData.view(
      (await File('tests/mwpdf/files/Open Sans Regular.ttf').readAsBytes())
          .buffer,
    ),
  );

  fontRegistry['material'] = pw.Font.ttf(
    ByteData.view(
      (await File('tests/mwpdf/files/MaterialIcons-Regular.ttf').readAsBytes())
          .buffer,
    ),
  );


  List<String> lines = File('tests/mwpdf/files/MaterialIcons-Regular.codepoints').readAsLinesSync();
  for (String line in lines) {
    List<String> splitted = line.split(' ');
    fontMaterialMap[splitted[0]] = splitted[1];
  }

  // -----------------------

  // String jsonFile = 'pdf_simple.json';
  // String jsonFile = 'pdf_simple2.json';
  String jsonFile = 'pdf_simple3.json';
  // String jsonFile = 'pdf_layout.json';
  // String jsonFile = 'pdf_shapes.json';
  // String jsonFile = 'pdf_table.json';
  //  String jsonFile = 'pdf_table2.json';
  // String jsonFile = 'pdf_charts.json';
  // String jsonFile = 'pdf_barcodes.json';
  // String jsonFile = 'pdf_grid.json';
  // String jsonFile = 'pdf_gridView.json';
  // String jsonFile = 'pdf_listView.json';
  // String jsonFile = 'pdf_images.json';
  // String jsonFile = 'pdf_stack.json';
  // String jsonFile = 'pdf_partitions.json';

  String data = await File('tests/mwpdf/$jsonFile').readAsString();
  PdfEngine engine = PdfEngine.fromJson(json.decode(data) as Dict);

  pw.Document pdf = engine.build();

  String name = '$jsonFile.pdf';
  final file = File(name);
  await file.writeAsBytes(await pdf.save());
  print(
      'Thank you, parsed "$jsonFile", wrote "$name" (${engine.pages.length} pages) ... \n\n');
}
