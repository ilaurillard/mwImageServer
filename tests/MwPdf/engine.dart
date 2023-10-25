import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/Etc/Console.dart';
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
  // String jsonFile = 'pdf_charts2.json';
  // String jsonFile = 'pdf_barcodes.json';
  // String jsonFile = 'pdf_grid.json';
  // String jsonFile = 'pdf_gridView.json';
  // String jsonFile = 'pdf_listView.json';
  // String jsonFile = 'pdf_images.json';
  // String jsonFile = 'pdf_stack.json';
  // String jsonFile = 'pdf_partitions.json';
  // String jsonFile = 'pdf_header.json';
  // String jsonFile = 'pdf_form.json';
  // String jsonFile = 'pdf_invoice.json';
  String jsonFile = 'pdf_multiCol.json';

  String pdfJson = await File('${basedir}examples/$jsonFile').readAsString();

  Results results = schema.validate(pdfJson);

  if (results.valid) {

    try {
      Engine engine = await Engine.run(
        json.decode(pdfJson) as Dict,
        basedir: basedir,
      );

      String name = '${basedir}examples/output/$jsonFile.pdf';
      await File(name).writeAsBytes(await engine.buildPdf().save());
      Console.info(
          '\nThank you, parsed "$jsonFile"\nwrote "$name"\n${engine.pages.length} pages)\n\n');
    }
    catch (e) {
      print('Fatal error: $e');
    }

  }
  else {

    print('Document does not validate!');
    if (results.errors.isNotEmpty) {
      print('Errors: ');
      for (String e in results.errors) {
        print('>> $e');
      }
    }
    if (results.warnings.isNotEmpty) {
      print('Warnings: ');
      for (String w in results.warnings) {
        print('>> $w');
      }
    }


  }
}
