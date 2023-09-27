import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/Etc/Types.dart';
import 'Engine/Engine.dart';

import 'Engine/Schema/Schema.dart';

const basedir = '/home/ilja/PhpstormProjects/mwcdn/tests/MwPdf/';

Future<void> main() async {

  Schema schema = await Schema.create(
    basedir: basedir,
  );

  // String jsonFile = 'pdf_simple.json';
  // String jsonFile = 'pdf_simple2.json';
  // String jsonFile = 'pdf_simple3.json';
  // String jsonFile = 'pdf_simple4.json';
  // String jsonFile = 'pdf_simple5.json';
  // String jsonFile = 'pdf_simple6.json';
  // String jsonFile = 'pdf_layout.json';
  // String jsonFile = 'pdf_shapes.json';
  // String jsonFile = 'pdf_table.json';
  // String jsonFile = 'pdf_table2.json';
  // String jsonFile = 'pdf_table3.json';
  // String jsonFile = 'pdf_table4.json';
  // String jsonFile = 'pdf_charts.json';
  String jsonFile = 'pdf_charts2.json';
  // String jsonFile = 'pdf_barcodes.json';
  // String jsonFile = 'pdf_grid.json';
  // String jsonFile = 'pdf_gridView.json';
  // String jsonFile = 'pdf_listView.json';
  // String jsonFile = 'pdf_images.json';
  // String jsonFile = 'pdf_stack.json';
  // String jsonFile = 'pdf_partitions.json';
  // String jsonFile = 'pdf_header.json';
  // String jsonFile = 'pdf_form.json';

  String pdfJson = await File('${basedir}examples/$jsonFile').readAsString();

  bool valid = schema.validate(pdfJson);

  if (valid) {
    Engine engine = await Engine.run(
      json.decode(pdfJson) as Dict,
      basedir: basedir,
    );

    String name = '${basedir}examples/output/$jsonFile.pdf';
    await File(name).writeAsBytes(await engine.buildPdf().save());
    print(
        '\nThank you, parsed "$jsonFile"\nwrote "$name"\n${engine.pages.length} pages)\n\n');
  }
}
