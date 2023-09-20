import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Engine/Engine.dart';

const basedir = '/home/ilja/PhpstormProjects/mwcdn/';

Future<void> main() async {

  // String jsonFile = 'pdf_simple.json';
  // String jsonFile = 'pdf_simple2.json';
  // String jsonFile = 'pdf_simple3.json';
  // String jsonFile = 'pdf_simple4.json';
  // String jsonFile = 'pdf_layout.json';
  // String jsonFile = 'pdf_shapes.json';
  // String jsonFile = 'pdf_table.json';
  // String jsonFile = 'pdf_table2.json';
  // String jsonFile = 'pdf_table3.json';
  // String jsonFile = 'pdf_table4.json';
  // String jsonFile = 'pdf_charts.json';
  // String jsonFile = 'pdf_barcodes.json';
  // String jsonFile = 'pdf_grid.json';
  // String jsonFile = 'pdf_gridView.json';
  // String jsonFile = 'pdf_listView.json';
  // String jsonFile = 'pdf_images.json';
  // String jsonFile = 'pdf_stack.json';
  // String jsonFile = 'pdf_partitions.json';
  // String jsonFile = 'pdf_header.json';
  // String jsonFile = 'pdf_form.json';
  String jsonFile = 'pdf_simple5.json';

  String data = await File('${basedir}tests/mwpdf/examples/$jsonFile').readAsString();

  Engine engine = await Engine.fromJson(
    json.decode(data) as Dict,
  );

  pw.Document pdf = engine.buildPdf();

  String name = '${basedir}tests/mwpdf/output/$jsonFile.pdf';
  final file = File(name);
  await file.writeAsBytes(await pdf.save());
  print('');
  print(
      'Thank you, parsed "$jsonFile", wrote "$name" (${engine.pages.length} pages) ... \n\n');
}
