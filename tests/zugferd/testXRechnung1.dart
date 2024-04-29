import 'dart:convert';

import 'package:mwcdn/MwPdf/Service/XRechnung/Etc/Util.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cac/AccountingCustomerParty.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cac/AccountingSupplierParty.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cac/InvoiceLine.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cac/Item.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cac/LegalMonetaryTotal.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cbc/ID.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cbc/IssueDate.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cbc/LineExtensionAmount.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/cbc/PayableAmount.dart';
import 'package:mwcdn/MwPdf/Service/XRechnung/Model/ubl/Invoice.dart';
import 'package:xml/xml.dart';

Future<void> main() async {
  Invoice i = Invoice(
    iD: ID(value: '333'),
    issueDate: IssueDate(value: XsdDate(value: '2024-02-06')),
    accountingSupplierParty: AccountingSupplierParty(),
    accountingCustomerParty: AccountingCustomerParty(),
    legalMonetaryTotal: LegalMonetaryTotal(
      payableAmount: PayableAmount(
        value: 123,
        currencyID: 'EUR',
      ),
    ),
    invoiceLine: [
      InvoiceLine(
        iD: ID(value: 'xx'),
        lineExtensionAmount: LineExtensionAmount(
          value: 123,
          currencyID: 'EUR',
        ),
        item: Item(),
      ),
    ],
  );

  // String json = jsonEncode(i.toJson());
  // print(json);
  //
  // Invoice? i2 = Invoice.fromJson(jsonDecode(json) as Map<String, dynamic>);
  // String json2 = jsonEncode(i2!.toJson());
  // print(json2);

  XmlDocument doc = XmlDocument.parse('''
<ubl:Invoice xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
              xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
              xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2 http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/maindoc/UBL-Invoice-2.1.xsd">
   <cbc:ID>333</cbc:ID>
</ubl:Invoice>
''');
  XmlElement root = doc.rootElement;

  Invoice? i3 = Invoice.fromXml(root);
  String json2 = jsonEncode(i3!.toJson());
  print(json2);


  // XmlDocument xml = i.toXml();
  //
  // print(xml.toXmlString(pretty: true));

  // File f = await File('xrechnung1.xml').create();
  // f.writeAsString(
  //   Util.prettyXml(xml),
  //   flush: true,
  // );
}
