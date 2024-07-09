import 'dart:io';

import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/DartClasses.dart';
// import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/Schema.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdParser.dart';
import 'package:args/args.dart';

Future<void> main(List<String> arguments) async {

  var parser = ArgParser();
  parser.addOption('outputDir', abbr: 'o', defaultsTo: '');
  var argResults = parser.parse(arguments);
  String outputDir = argResults['outputDir'].toString();
  Directory f = Directory(outputDir);

  if (!f.existsSync()) {
    print('Folder $outputDir not found');
  }
  else {
    String identifier = 'ubl';
    String schemaUrl =
        'http://docs.oasis-open.org/ubl/os-UBL-2.4/xsd/maindoc/UBL-Invoice-2.4.xsd';
    // String url =
    //     'http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/maindoc/UBL-Invoice-2.1.xsd';

    await XsdParser(
      schemaUrl,
      identifier,
    ).parse();

    print('------------------');
    print('Schema parsed ...\n');

    DartClasses(
      XsdParser.schemaForIdentifier(
        identifier,
      ),
      outputDir,
    ).execute();

    print('------------------');
    print('THANKYOU\n');
  }
}
