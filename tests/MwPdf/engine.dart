import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/MwCdn/Service/Database/SqliteStorage.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwMs/Model/RootToken.dart';
import 'package:mwcdn/MwMs/Service/FileStorage/FileStorage.dart';
import 'package:mwcdn/MwPdf/Engine/Engine.dart';
import 'package:mwcdn/MwPdf/Engine/Schema/Schema.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:pdf/widgets.dart';
import 'package:yaml/yaml.dart';

const dataDir = '/home/ilja/PhpstormProjects/mwcdn/data';
const examplesDir = '/home/ilja/PhpstormProjects/mwcdn/tests/MwPdf/examples';
const resDir = '/home/ilja/PhpstormProjects/mwcdn/lib/MwPdf/res';

Future<void> main() async {
  Schema schema = await Schema.create(
    resDir: resDir,
  );

  String templateFile = '';
  // String templateFile = 'templates/pdf_template1.json';

  // String jsonFile = 'pdf_barcodes.json';
  // String jsonFile = 'pdf_barcodes2.json';
  // String jsonFile = 'pdf_barcodes3.json';
  // String jsonFile = 'pdf_barcodes4.json';
  // String jsonFile = 'pdf_charts.json';
  // String jsonFile = 'pdf_charts2.json';
  // String jsonFile = 'pdf_form.json';
  // String jsonFile = 'pdf_grid.json';
  // String jsonFile = 'pdf_gridView.json';
  // String jsonFile = 'pdf_header.json';
  // String jsonFile = 'pdf_hyphenation.json';
  // String jsonFile = 'pdf_images.json';
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
  // String jsonFile = 'pdf_table6.json';
  // String jsonFile = 'pdf_toc.json';
  // String jsonFile = 'pdf_template1_data.json';
  // String jsonFile = 'pdf_a.json';
  // String jsonFile = 'pdf_zugferd1.json';
  // String jsonFile = 'pdf_zugferd2.json';
  // String jsonFile = 'pdf_xrechnung1.json';
  // String jsonFile = 'pdf_invoice1.json';
  // String jsonFile = 'pdf_energie.json';
  // String jsonFile = 'pdf_mindworks.json';
  // String jsonFile = 'pdf_grid.yaml';
  // String jsonFile = 'pdf_cal.json';
  //String jsonFile = 'pdf_comic.json';
  // String jsonFile = 'pdf_puzzle.json';
  // String jsonFile = 'pdf_puzzle2.json';
  // String jsonFile = 'pdf_bates.json';
  // String jsonFile = 'pdf_paper.json';
  //  String jsonFile = 'pdf_avery.json';
  // String jsonFile = 'pdf_hello.json';
  // String jsonFile = 'pdf_gadgets.yaml';
  // String jsonFile = 'pdf_reisswolf.json';
  // String jsonFile = 'pdf_reisswolf2.json';
  // String jsonFile = 'pdf_helpers.json';
  String jsonFile = 'pdf_definitionList.json';

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
    if (jsonFile.endsWith('.yaml')) {
      pdfJson = json.encode(loadYaml(pdfJson));
    }
    Dict pdfData = json.decode(pdfJson) as Dict;

    Dict pdfTplData = json.decode(pdfTplJson) as Dict;
    pdfData = Util.mergeMap([pdfTplData, pdfData]);

    Results results = schema.validate(
      json.encode(pdfData),
    );

    if (results.valid) {
      try {
        SqliteStorage sqliteStorage = await SqliteStorage.create(
          dataDir: dataDir,
        );

        // prepare engine
        Engine engine = await Engine.create(
          pdfData,
          resDir: resDir,
          storage: Storage(
            fileStorage: FileStorage(
              dataDir: dataDir,
              resDir: '',
            ),
            resources: sqliteStorage.resources,
            bucketId: 98,
            token: RootToken(),
          ),
        );

        // build pdf
        Document pdf = await engine.pdf();

        // store pdf
        String name = '$examplesDir/output/$jsonFile.pdf';
        await File(name).writeAsBytes(
          await pdf.save(),
        );

        Console.info(
          '\nThank you, rendered "$jsonFile" into "output/$jsonFile.pdf"\nwrote "$name"\n${engine.pages.length} pages)\n\n',
        );
      } catch (e) {
        Console.error('Fatal error, exception: $e');
        // throw e;
      }
    } else {
      Console.warning('Document does not validate!');
      if (results.errors.isNotEmpty) {
        Console.warning('Errors: ');
        for (String e in results.errors) {
          Console.warning('>> $e');
        }
      }
      if (results.warnings.isNotEmpty) {
        Console.warning('Warnings: ');
        for (String w in results.warnings) {
          Console.warning('>> $w');
        }
      }
    }
  } catch (e) {
    Console.error('Parse error, exception: $e');
    // throw e;
  }
}
