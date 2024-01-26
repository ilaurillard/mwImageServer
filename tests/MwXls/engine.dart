import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwMs/Etc/Util.dart';
import 'package:mwcdn/MwXls/Engine/Engine.dart';
import 'package:mwcdn/MwXls/Engine/Schema/Schema.dart';

const resDir = '/home/ilja/PhpstormProjects/mwcdn/lib/MwXls/res';
const examplesDir = '/home/ilja/PhpstormProjects/mwcdn/tests/MwXls/examples';

Future<void> main() async {
  String templateFile = '';
  String jsonFile = 'xls_simple1.json';
  // String jsonFile = 'xls_simple2.json';
  // ----------------------

  // Stopwatch s = Stopwatch()..start();
  // String alle = await File(
  //     '$examplesDir/ALLE.json',
  //   ).readAsString();
  // List<dynamic> alleList = json.decode(alle) as List<dynamic>;
  // print(alle.length);
  // print(alleList.length);
  // print(s.elapsed);

  // Uint8List alle = await File(
  //     '$examplesDir/ALLE.ndjson.gz',
  //   ).readAsBytes();
  // InputStream stream = InputStream(alle);
  // OutputStream output = OutputStream();
  // GZipDecoder().decodeStream(stream, output);

  // String d = String.fromCharCodes(output.getBytes());
  // List<String> lines = d.split('\n');
  // for (String c in lines) {
  //   if (c.isNotEmpty) {
  //     List<dynamic> row = json.decode(c.toString()) as List<dynamic>;
  //     // Row.fromValues(row);
  //   }
  // }

  // ----------------------

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
    Dict xlsJsonDict = Util.mergeMap([
      json.decode(xlsBase) as Dict,
      json.decode(xlsJson) as Dict,
    ]);

    Results results = (await Schema.create(
      resDir: resDir,
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
          resDir: resDir,
        );

        String name = '$examplesDir/output/$jsonFile.xlsx';
        await File(name).writeAsBytes(
          await engine.excel.save(),
        );

        // final inputStream = InputFileStream(name);
        // final archive = ZipDecoder().decodeBuffer(inputStream);
        // archive.addFile(ArchiveFile('test.txt', 3, 'xxx'));
        // String name2 = '$examplesDir/output/test.zip';
        // await File(name2).writeAsBytes(
        //   ZipEncoder().encode(archive)!,
        // );

        Console.info(
          '\nThank you, rendered "$jsonFile" to "$name"\n\n',
        );
      } catch (e) {
        Console.error('Fatal error: $e');
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
    Console.error('Parse error: $e');
    // throw e;
  }
}
