import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/DartClasses.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/Schema.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/XsdParser.dart';

Future<void> main() async {
  String outputDir =
      '/home/ilja/PhpstormProjects/mwcdn/lib/MwPdf/Service/XRechnung/Model';

  String identifier = 'ubl';
  String schemaUrl =
      'http://docs.oasis-open.org/ubl/os-UBL-2.3/xsd/maindoc/UBL-Invoice-2.3.xsd';
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
