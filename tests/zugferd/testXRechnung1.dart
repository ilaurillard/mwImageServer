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

Future<void> main() async {
  Invoice i = Invoice(
    iD: ID(value: '333'),
    issueDate: IssueDate(value: '2024-04-24'),
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

  print(i.toJson());

  // XmlDocument xml = i.toXml();
  //
  // print(xml.toXmlString(pretty: true));

  // File f = await File('xrechnung1.xml').create();
  // f.writeAsString(
  //   Util.prettyXml(xml),
  //   flush: true,
  // );
}
