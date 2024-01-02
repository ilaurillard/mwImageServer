import 'dart:convert';
import 'dart:io';

import 'package:merge_map_null_safety/merge_map.dart';
import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Model/RootToken.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';

const dataDir = '/home/ilja/PhpstormProjects/mwcdn/data';
const baseDir = '/home/ilja/PhpstormProjects/mwcdn/lib/MwPdf';
const examplesDir = '/home/ilja/PhpstormProjects/mwcdn/tests/MwPdf/examples';

Future<void> main() async {
  Schema schema = await Schema.create(
    baseDir: baseDir,
  );

  String templateFile = '';
  // String templateFile = 'templates/pdf_template1.json';

  // String jsonFile = 'pdf_barcodes.json';
  // String jsonFile = 'pdf_charts.json';
  // String jsonFile = 'pdf_charts2.json';
  // String jsonFile = 'pdf_form.json'; // TODO
  // String jsonFile = 'pdf_grid.json';
  // String jsonFile = 'pdf_gridView.json';
  // String jsonFile = 'pdf_header.json';
  // String jsonFile = 'pdf_images.json';
  // String jsonFile = 'pdf_invoice.json';
  // String jsonFile = 'pdf_layout.json';
  // String jsonFile = 'pdf_listView.json';
  // String jsonFile = 'pdf_multiCol.json';
  // String jsonFile = 'pdf_multiPage.json';
  // String jsonFile = 'pdf_partitions.json';
  // String jsonFile = 'pdf_richtext.json';
  // String jsonFile = 'pdf_shapes.json';
  // String jsonFile = 'pdf_simple.json';
  // String jsonFile = 'pdf_simple2.json';
  // String jsonFile = 'pdf_simple3.json';
  // String jsonFile = 'pdf_simple4.json';
  // String jsonFile = 'pdf_simple5.json';
  // String jsonFile = 'pdf_simple6.json';
  // String jsonFile = 'pdf_sources.json';
  // String jsonFile = 'pdf_stack.json';
  // String jsonFile = 'pdf_table.json';
  // String jsonFile = 'pdf_table2.json';
  // String jsonFile = 'pdf_table3.json';
  // String jsonFile = 'pdf_table4.json';
  // String jsonFile = 'pdf_table5.json';
  String jsonFile = 'pdf_text1.json';
  // String jsonFile = 'pdf_toc.json';
  // String jsonFile = 'pdf_template1_data.json';

  String pdfTplJson = '{}';
  if (templateFile.isNotEmpty) {
    pdfTplJson = await File(
      '$examplesDir/$templateFile',
    ).readAsString();
  }

  String pdfJson = await File(
    '$examplesDir/$jsonFile',
  ).readAsString();

  try {
    Dict pdfTplData = json.decode(pdfTplJson) as Dict;
    Dict pdfData = json.decode(pdfJson) as Dict;
    pdfData = mergeMap([pdfTplData, pdfData]);

    Results results = schema.validate(
      json.encode(pdfData),
    );

    if (results.valid) {
      try {
        SqliteStorage sqliteStorage = SqliteStorage(
          dataDir: dataDir,
        );
        await sqliteStorage.init();

        Engine engine = await Engine.create(
          pdfData,
          baseDir: baseDir,
          storage: Storage(
            fileStorage: FileStorage(
              dataDir: dataDir,
            ),
            resources: sqliteStorage.resources,
            bucketId: 98,
            token: RootToken(),
          ),
        );

        String name = '$examplesDir/output/$jsonFile.pdf';
        await File(name).writeAsBytes(
          await engine.pdf().save(),
        );

        Console.info(
          '\nThank you, rendered "$jsonFile" into "output/$jsonFile.pdf"\nwrote "$name"\n${engine.pages.length} pages)\n\n',
        );
      } catch (e) {
        print('Fatal error: $e');
        // throw e;
      }
    } else {
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
  } catch (e) {
    print('Parse error: $e');
    // throw e;
  }
}
