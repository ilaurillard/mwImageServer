import 'dart:io';

import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwInvoice/Service/XRechnung/Model/ubl/Invoice.dart';
import 'package:xml/xml.dart';

Future<void> main() async {
  // Invoice i = Invoice(
  //   iD: ID(value: '333'),
  //   issueDate: IssueDate(value: XsdDate(value: '2024-02-06')),
  //   accountingSupplierParty: AccountingSupplierParty(),
  //   accountingCustomerParty: AccountingCustomerParty(),
  //   legalMonetaryTotal: LegalMonetaryTotal(
  //     payableAmount: PayableAmount(
  //       value: 123,
  //       currencyID: 'EUR',
  //     ),
  //   ),
  //   invoiceLine: [
  //     InvoiceLine(
  //       iD: ID(value: 'xx'),
  //       lineExtensionAmount: LineExtensionAmount(
  //         value: 123,
  //         currencyID: 'EUR',
  //       ),
  //       item: Item(),
  //     ),
  //   ],
  // );
  //
  // Map<String, dynamic> json3 = i.toJson();
  // print(jsonEncode(json3));

  // XmlDocument x3 = i.toXml();
  // Invoice i3 = Invoice.fromXml(x3.rootElement)!;
  // Map<String, dynamic> json3 = i3.toJson();
  // Invoice i4 = Invoice.fromJson(json3)!;
  // XmlDocument x5 = i4.toXml();
  // print(x5.toXmlString(pretty: true));

  // print(x1.toXmlString(pretty: true));

  // Invoice i3 = Invoice.fromXml(root)!;

  // String json = jsonEncode(i.toJson());
  // print(json);
  //
  // Invoice i2 = Invoice.fromJson(jsonDecode(json) as Map<String, dynamic>)!;
  // String json2 = jsonEncode(i2.toJson());
  // print(json2);

  // Stopwatch s = Stopwatch();
  // s.start();

//   XmlDocument doc = XmlDocument.parse(
//     '''
// <?xml version="1.0" encoding="UTF-8"?>
// <ubl:Invoice xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
//               xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2"
//               xmlns:ubl="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
//               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
//               xsi:schemaLocation="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2 http://docs.oasis-open.org/ubl/os-UBL-2.1/xsd/maindoc/UBL-Invoice-2.1.xsd">
//    <cbc:CustomizationID>urn:cen.eu:en16931:2017#compliant#urn:xeinkauf.de:kosit:xrechnung_3.0</cbc:CustomizationID>
//    <cbc:ProfileID>urn:fdc:peppol.eu:2017:poacc:billing:01:1.0</cbc:ProfileID>
//    <cbc:ID>333</cbc:ID>
//    <cbc:IssueDate>2024-04-24</cbc:IssueDate>
//    <cbc:DueDate>2024-04-28</cbc:DueDate>
//    <cbc:InvoiceTypeCode>380</cbc:InvoiceTypeCode>
//    <cbc:DocumentCurrencyCode>EUR</cbc:DocumentCurrencyCode>
//    <cbc:BuyerReference>111</cbc:BuyerReference>
//    <cac:InvoicePeriod>
//       <cbc:StartDate>2024-04-01</cbc:StartDate>
//       <cbc:EndDate>2024-04-05</cbc:EndDate>
//    </cac:InvoicePeriod>
//    <cac:OrderReference>
//       <cbc:ID>222</cbc:ID>
//    </cac:OrderReference>
//    <cac:AccountingSupplierParty>
//       <cac:Party>
//          <cbc:EndpointID schemeID="EM">ilaurillard@mindworks.de</cbc:EndpointID>
//          <cac:PartyIdentification>
//             <cbc:ID>c1</cbc:ID>
//          </cac:PartyIdentification>
//          <cac:PartyName>
//             <cbc:Name>ah</cbc:Name>
//          </cac:PartyName>
//          <cac:PostalAddress>
//             <cbc:StreetName>jarrestr 42</cbc:StreetName>
//             <cbc:AdditionalStreetName>a1</cbc:AdditionalStreetName>
//             <cbc:CityName>Hamburg</cbc:CityName>
//             <cbc:PostalZone>21077</cbc:PostalZone>
//             <cac:AddressLine>
//                <cbc:Line>a2</cbc:Line>
//             </cac:AddressLine>
//             <cac:Country>
//                <cbc:IdentificationCode>DE</cbc:IdentificationCode>
//             </cac:Country>
//          </cac:PostalAddress>
//          <cac:PartyTaxScheme>
//             <cbc:CompanyID>DEc3</cbc:CompanyID>
//             <cac:TaxScheme>
//                <cbc:ID>VAT</cbc:ID>
//             </cac:TaxScheme>
//          </cac:PartyTaxScheme>
//          <cac:PartyTaxScheme>
//             <cbc:CompanyID>c4</cbc:CompanyID>
//             <cac:TaxScheme>
//                <cbc:ID>FC</cbc:ID>
//             </cac:TaxScheme>
//          </cac:PartyTaxScheme>
//          <cac:PartyLegalEntity>
//             <cbc:RegistrationName>mindworks GmbH</cbc:RegistrationName>
//             <cbc:CompanyID>c2</cbc:CompanyID>
//             <cbc:CompanyLegalForm>c5</cbc:CompanyLegalForm>
//          </cac:PartyLegalEntity>
//          <cac:Contact>
//             <cbc:Name>Ilja Laurillard</cbc:Name>
//             <cbc:Telephone>321654987</cbc:Telephone>
//             <cbc:ElectronicMail>ilaurillard+2@mindworks.de</cbc:ElectronicMail>
//          </cac:Contact>
//       </cac:Party>
//    </cac:AccountingSupplierParty>
//    <cac:AccountingCustomerParty>
//       <cac:Party>
//          <cbc:EndpointID schemeID="EM">peter@mindworks.de</cbc:EndpointID>
//          <cac:PartyIdentification>
//             <cbc:ID>d1</cbc:ID>
//          </cac:PartyIdentification>
//          <cac:PartyName>
//             <cbc:Name>ah2</cbc:Name>
//          </cac:PartyName>
//          <cac:PostalAddress>
//             <cbc:StreetName>teststr 33</cbc:StreetName>
//             <cbc:CityName>Berlin</cbc:CityName>
//             <cbc:PostalZone>22233</cbc:PostalZone>
//             <cac:Country>
//                <cbc:IdentificationCode>DE</cbc:IdentificationCode>
//             </cac:Country>
//          </cac:PostalAddress>
//          <cac:PartyTaxScheme>
//             <cbc:CompanyID>DEd2</cbc:CompanyID>
//             <cac:TaxScheme>
//                <cbc:ID>VAT</cbc:ID>
//             </cac:TaxScheme>
//          </cac:PartyTaxScheme>
//          <cac:PartyLegalEntity>
//             <cbc:RegistrationName>peter meier</cbc:RegistrationName>
//          </cac:PartyLegalEntity>
//       </cac:Party>
//    </cac:AccountingCustomerParty>
//    <cac:Delivery>
//       <cbc:ActualDeliveryDate>2024-04-30</cbc:ActualDeliveryDate>
//    </cac:Delivery>
//    <cac:PaymentMeans>
//       <cbc:PaymentMeansCode>58</cbc:PaymentMeansCode>
//       <cbc:InstructionNote>SEPA-Überweisung</cbc:InstructionNote>
//       <cbc:PaymentID>xxx</cbc:PaymentID>
//       <cac:PayeeFinancialAccount>
//          <cbc:ID>DE02120300000000202051</cbc:ID>
//          <cbc:Name>ilaj laurillard</cbc:Name>
//          <cac:FinancialInstitutionBranch>
//             <cbc:ID>BYLADEM1001</cbc:ID>
//          </cac:FinancialInstitutionBranch>
//       </cac:PayeeFinancialAccount>
//    </cac:PaymentMeans>
//    <cac:PaymentTerms>
//       <cbc:Note>#SKONTO#TAGE=0#PROZENT=0.00#
// </cbc:Note>
//    </cac:PaymentTerms>
//    <cac:TaxTotal>
//       <cbc:TaxAmount currencyID="EUR">1254.00</cbc:TaxAmount>
//       <cac:TaxSubtotal>
//          <cbc:TaxableAmount currencyID="EUR">6600.00</cbc:TaxableAmount>
//          <cbc:TaxAmount currencyID="EUR">1254.00</cbc:TaxAmount>
//          <cac:TaxCategory>
//             <cbc:ID>S</cbc:ID>
//             <cbc:Percent>19.00</cbc:Percent>
//             <cac:TaxScheme>
//                <cbc:ID>VAT</cbc:ID>
//             </cac:TaxScheme>
//          </cac:TaxCategory>
//       </cac:TaxSubtotal>
//    </cac:TaxTotal>
//    <cac:LegalMonetaryTotal>
//       <cbc:LineExtensionAmount currencyID="EUR">6600.00</cbc:LineExtensionAmount>
//       <cbc:TaxExclusiveAmount currencyID="EUR">6600.00</cbc:TaxExclusiveAmount>
//       <cbc:TaxInclusiveAmount currencyID="EUR">7854.00</cbc:TaxInclusiveAmount>
//       <cbc:AllowanceTotalAmount currencyID="EUR">0.00</cbc:AllowanceTotalAmount>
//       <cbc:ChargeTotalAmount currencyID="EUR">0.00</cbc:ChargeTotalAmount>
//       <cbc:PrepaidAmount currencyID="EUR">0.00</cbc:PrepaidAmount>
//       <cbc:PayableAmount currencyID="EUR">7854.00</cbc:PayableAmount>
//    </cac:LegalMonetaryTotal>
//    <cac:InvoiceLine>
//       <cbc:ID>1</cbc:ID>
//       <cbc:InvoicedQuantity unitCode="C62">220.00</cbc:InvoicedQuantity>
//       <cbc:LineExtensionAmount currencyID="EUR">6600.00</cbc:LineExtensionAmount>
//       <cac:Item>
//          <cbc:Name>ein ding</cbc:Name>
//          <cac:SellersItemIdentification>
//             <cbc:ID>aaa111</cbc:ID>
//          </cac:SellersItemIdentification>
//          <cac:ClassifiedTaxCategory>
//             <cbc:ID>S</cbc:ID>
//             <cbc:Percent>19.00</cbc:Percent>
//             <cac:TaxScheme>
//                <cbc:ID>VAT</cbc:ID>
//             </cac:TaxScheme>
//          </cac:ClassifiedTaxCategory>
//       </cac:Item>
//       <cac:Price>
//          <cbc:PriceAmount currencyID="EUR">30.00</cbc:PriceAmount>
//          <cbc:BaseQuantity unitCode="C62">1.00</cbc:BaseQuantity>
//       </cac:Price>
//    </cac:InvoiceLine>
// </ubl:Invoice>
// ''',
//   );

  // XmlElement root = doc.rootElement;

  // Stopwatch s = Stopwatch();
  // s.start();

  // Invoice i3 = Invoice.fromXml(root)!;

  // print(jsonEncode(i3.toJson()));

  // print(i3.toXml().toXmlString(pretty: true));

  // print(s.elapsed.inMilliseconds);

  // String json2 = jsonEncode(i3!.toJson());
  // print(json2);

  // XmlDocument xml = i.toXml();
  // print(xml.toXmlString(pretty: true));

  String dir =
      '/home/ilja/PhpstormProjects/mwcdn/tests/zugferd/xrechnung/x_rechnung2.0/ubl_files/';
  String filename = '08-01 Rechnung Schwenk IT Solutions AG UBL2.0.xml';
  File input = File('$dir$filename');
  String xml = input.readAsStringSync();
  XmlDocument doc = XmlDocument.parse(xml);
  Invoice? i = Invoice.fromXml(doc.rootElement);
  XmlDocument xml2 = i!.toXml();
  print(Util.prettyXml(xml2));
  // File f = await File('xrechnung1.xml').create();
  // f.writeAsString(
  //   Util.prettyXml(xml2),
  //   flush: true,
  // );
}
