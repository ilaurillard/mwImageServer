import 'dart:convert';
import 'dart:io';

import 'package:merge_map_null_safety/merge_map.dart';
import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Engine.dart';
import 'package:mwcdn/MwXls/Engine/Schema/Schema.dart';

const baseDir = '/home/ilja/PhpstormProjects/mwcdn/lib/MwXls';
const examplesDir = '/home/ilja/PhpstormProjects/mwcdn/tests/MwXls/examples';

Future<void> main() async {

  String templateFile = '';
  String jsonFile = 'xls_simple1.json';

  String xlsBase = '{}';
  if (templateFile.isNotEmpty) {
    xlsBase = await File(
      '$examplesDir/$templateFile',
    ).readAsString();
  }

  String xlsJson = await File(
    '$examplesDir/$jsonFile',
  ).readAsString();

  try {
    Dict xlsJsonDict = mergeMap([
      json.decode(xlsBase) as Dict,
      json.decode(xlsJson) as Dict,
    ]);

    Results results = (await Schema.create(
      baseDir: baseDir,
    ))
        .validate(
      json.encode(
        xlsJsonDict,
      ),
    );

    if (results.valid) {
      try {
        Engine engine = await Engine.create(
          xlsJsonDict,
          baseDir: baseDir,
        );

        String name = '$examplesDir/output/$jsonFile.xls';
        await File(name).writeAsBytes(
          await engine.excel.save(),
        );

        Console.info(
          '\nThank you, rendered "$jsonFile" into "output/$jsonFile.xls"\n\n',
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
