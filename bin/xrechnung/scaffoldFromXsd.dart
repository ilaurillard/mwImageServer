import 'dart:io';

import 'package:args/args.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cac/AccountingSupplierParty.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cac/InvoiceLine.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cac/Item.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cac/LegalMonetaryTotal.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cbc/ID.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cbc/IssueDate.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cbc/LineExtensionAmount.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/cbc/PayableAmount.dart';
// import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/ubl/Invoice.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/DartClasses.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/JsonScheme.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/Schema.dart';
// import 'package:mwcdn/MwPdf/Service/XRechnung/Scaffold/Schema.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Scaffold/XsdParser.dart';

Future<void> main(List<String> arguments) async {
  var parser = ArgParser();
  parser.addOption('modelDir', abbr: 'o', defaultsTo: '');
  parser.addOption('schemaDir', abbr: 's', defaultsTo: '');
  var argResults = parser.parse(arguments);
  String modelDir = argResults['modelDir'].toString();
  String schemaDir = argResults['schemaDir'].toString();

  String schemaUrl =
      'http://docs.oasis-open.org/ubl/os-UBL-2.4/xsd/maindoc/UBL-Invoice-2.4.xsd';

  await XsdParser(
    schemaUrl,
    'ubl',
  ).parse();

  Schema rootSchema = XsdParser.schemaForIdentifier(
    'ubl',
  );

  print('------------------');
  print('Schema parsed ...\n');

  if (Directory(modelDir).existsSync()) {
    print('Generating classes ...\n');
    DartClasses(
      rootSchema,
      modelDir,
    ).execute();
  } else {
    print('Folder $modelDir not found');
  }

  print('---------------------');

  if (Directory(schemaDir).existsSync()) {
    print('Generating json scheme ...\n');
    JsonScheme(
      rootSchema,
      schemaDir,
    ).execute();
  } else {
    print('Folder $schemaDir not found');
  }

  // print('------------------');
  print('THANKYOU\n');

  // Invoice invoice = Invoice(
  //   iD: ID(value: 'xxx'),
  //   issueDate: IssueDate(
  //     value: XsdDate(value: '2024-12-12'),
  //   ),
  //   accountingSupplierParty: AccountingSupplierParty(),
  //   legalMonetaryTotal: LegalMonetaryTotal(
  //     payableAmount: PayableAmount(
  //       value: 234.5,
  //       currencyID: 'EUR',
  //     ),
  //   ),
  //   invoiceLine: [
  //     InvoiceLine(
  //       iD: ID(value: 'yyy'),
  //       lineExtensionAmount: LineExtensionAmount(
  //         value: 123.4,
  //         currencyID: 'EUR',
  //       ),
  //       item: Item(),
  //     ),
  //   ],
  // );
  // print(invoice.toXml());
}
