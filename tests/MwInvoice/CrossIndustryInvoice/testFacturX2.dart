import 'dart:convert';
import 'dart:io';

import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:xml/xml.dart';

Future<void> main() async {
//   TradeParty tp1 = TradeParty(
//     globalID: [Id(value: '4000001123452', schemeID: '0088')],
//     name: 'Lieferant GmbH',
//     tradeContact: TradeContact(
//       personName: 'Max Mustermann',
//       departmentName: 'Muster-Einkauf',
//       telephone: UniversalCommunication(
//         completeNumber: '+49891234567',
//       ),
//       email: UniversalCommunication(
//         uriid: Id(
//           value: 'Max@Mustermann.de',
//         ),
//       ),
//     ),
//     tradeAddress: TradeAddress(
//       postcode: '80333',
//       lineOne: 'Lieferantenstraße 20',
//       city: 'München',
//       countryCode: 'DE',
//     ),
//     taxRegistrations: [
//       TaxRegistration(
//         registration: Id(
//           value: '201/113/40209',
//           schemeID: 'FC',
//         ),
//       ),
//       TaxRegistration(
//         registration: Id(
//           value: 'DE123456789',
//           schemeID: 'VA',
//         ),
//       ),
//     ],
//   );
//
//   CrossIndustryInvoice i = CrossIndustryInvoice(
//     documentContext: ExchangedDocumentContext(
//       parameter: DocumentContextParameter(
//         id: 'urn:cen.eu:en16931:2017#conformant#urn:zugferd.de:2p1:extended',
//       ),
//     ),
//     document: ExchangedDocument(
//       id: '471102',
//       name: 'Rechnung',
//       typeCode: '380',
//       issueDateTime: DateTime(
//         dateTimeString: DateTimeString(
//           format: 102,
//           value: '20180305',
//         ),
//       ),
//       languageId: ['de'],
//       notes: [
//         Note(
//           content: 'Rechnung gemäß Bestellung vom 01.03.2018.',
//         ),
//         Note(
//           content: '''
//           Lieferant GmbH
// Lieferantenstraße 20
// 80333 München
// Deutschland
// Geschäftsführer: Hans Muster
// Handelsregisternummer: H A 123
//           ''',
//           subjectCode: 'REG',
//         ),
//       ],
//     ),
//     tradeTransaction: SupplyChainTradeTransaction(
//       lineItems: [
//         SupplyChainTradeLineItem(
//           documentLineDocument: DocumentLineDocument(
//             lineId: '1',
//             notes: [
//               Note(
//                   content: 'Neutrale Umverpackung',
//                   contentCode: 'Umverpackung',
//                   subjectCode: 'AAI')
//             ],
//           ),
//           product: TradeProduct(
//             name: 'Trennblätter A4',
//             sellerAssignedID: 'TB100A4',
//             globalID: Id(
//               value: '4012345001235',
//               schemeID: '0160',
//             ),
//             // description: 'XXX',
//             tradeCountry: TradeCountry(id: 'DE'),
//           ),
//           tradeAgreement: LineTradeAgreement(
//             grossPrice: TradePrice(
//               amount: Amount(
//                 value: '9.9000',
//               ),
//             ),
//             netPrice: TradePrice(
//               amount: Amount(
//                 value: '9.9000',
//               ),
//               quantity: Quantity(unitCode: 'C62', value: '1'),
//             ),
//           ),
//           delivery: LineTradeDelivery(
//             billedQuantity: Quantity(
//               value: '20.0000',
//               unitCode: 'H87',
//             ),
//             chainEvent: SupplyChainEvent(
//               date: DateTime(
//                 dateTimeString: DateTimeString(
//                   format: 102,
//                   value: '20180305',
//                 ),
//               ),
//             ),
//           ),
//           lineTradeSettlement: LineTradeSettlement(
//             tradeTax: [
//               TradeTax(
//                 typeCode: 'VAT',
//                 categoryCode: 'S',
//                 rateApplicablePercent: '19.00',
//               ),
//             ],
//             monetarySummation: TradeSettlementLineMonetarySummation(
//               totalAmount: Amount(value: '190.00'),
//               totalAllowanceChargeAmount: Amount(value: '8.00'),
//             ),
//             tradeAllowanceCharge: [
//               TradeAllowanceCharge(
//                 actualAmount: Amount(value: '8.00'),
//                 indicator: Indicator(indicator: false),
//                 reason: 'Artikelrabatt',
//                 basisAmount: Amount(value: '198.00'),
//               ),
//             ],

//           ),
//         ),
//         SupplyChainTradeLineItem(
//           documentLineDocument: DocumentLineDocument(
//             lineId: '2',
//           ),
//           product: TradeProduct(
//             name: 'Joghurt Banane',
//             sellerAssignedID: 'ARNR2',
//             globalID: Id(
//               value: '4000050986428',
//               schemeID: '0160',
//             ),
//           ),
//           tradeAgreement: LineTradeAgreement(
//             grossPrice: TradePrice(
//               amount: Amount(
//                 value: '5.5000',
//               ),
//             ),
//             netPrice: TradePrice(
//               amount: Amount(
//                 value: '5.5000',
//               ),
//             ),
//           ),
//           delivery: LineTradeDelivery(
//             billedQuantity: Quantity(
//               value: '50.0000',
//               unitCode: 'H87',
//             ),
//           ),
//           lineTradeSettlement: LineTradeSettlement(
//             tradeTax: [
//               TradeTax(
//                 typeCode: 'VAT',
//                 categoryCode: 'S',
//                 rateApplicablePercent: '7.00',
//               ),
//             ],
//             monetarySummation: TradeSettlementLineMonetarySummation(
//               totalAmount: Amount(value: '275.00'),
//             ),
//           ),
//         ),
//       ],
//       headerTradeAgreement: HeaderTradeAgreement(
//         sellerTradeParty: tp1,
//         buyerTradeParty: TradeParty(
//           id: Id(value: 'GE2020211'),
//           name: 'Kunden AG Mitte',
//           tradeAddress: TradeAddress(
//             postcode: '69876',
//             lineOne: 'Kundenstraße 15',
//             city: 'Frankfurt',
//             countryCode: 'DE',
//           ),
//         ),
//         buyerReference: '04011000-12345-34',
//         procuringProject: ProcuringProject(
//           id: '1234',
//           name: 'Projekt',
//         ),
//       ),
//       headerTradeDelivery: HeaderTradeDelivery(
//         shipToTradeParty: TradeParty(
//           id: Id(value: 'GE2020211'),
//           name: 'Kunden AG Mitte',
//           tradeAddress: TradeAddress(
//             postcode: '69876',
//             lineOne: 'Kundenstraße 15',
//             city: 'Frankfurt',
//             countryCode: 'DE',
//           ),
//         ),
//         chainEvent: SupplyChainEvent(
//           date: DateTime(
//             dateTimeString: DateTimeString(
//               format: 102,
//               value: '20180305',
//             ),
//           ),
//         ),
//         referencedDocument: ReferencedDocument(
//           issuerAssignedID: Id(value: '123456'),
//           dateTime: FormattedDateTime(
//               dateTimeString: DateTimeString(format: 102, value: '20180305')),
//         ),
//       ),
//       headerTradeSettlement: HeaderTradeSettlement(
//         summation:
//             TradeSettlementHeaderMonetarySummation(
//           lineTotalAmount: Amount(value: '465.00'),
//           chargeTotalAmount: Amount(value: '0.00'),
//           allowanceTotalAmount: Amount(value: '0.00'),
//           taxBasisTotalAmount: [Amount(value: '465.00')],
//           taxTotalAmount: [Amount(value: '55.35', currency: 'EUR')],
//           grandTotalAmount: [Amount(value: '520.35')],
//           totalPrepaidAmount: Amount(value: '0.00'),
//           duePayableAmount: Amount(value: '520.35'),
//         ),
//         tradePaymentTerms: [
//           TradePaymentTerms(
//               description:
//                   'Zahlbar innerhalb 30 Tagen netto bis 04.04.2018, 3% Skonto innerhalb 10 Tagen bis 15.03.2018',
//               directDebitMandateID: 'Mandate Reference')
//         ],
//         payeeTradeParty: tp1,
//         creditorReferenceID: 'TEST1234',
//         paymentReference: '421102',
//         logisticsServiceCharge: [
//           LogisticsServiceCharge(
//             description: 'Versandkosten',
//             appliedAmount: Amount(value: '0'),
//             tradeTax: [
//               TradeTax(
//                 typeCode: 'VAT',
//                 categoryCode: 'S',
//                 rateApplicablePercent: '19.00'
//
//               ),
//             ],
//           ),
//         ],
//         tradeTax: [
//           TradeTax(
//             typeCode: 'VAT',
//             categoryCode: 'S',
//             basisAmount: Amount(value: '275.00'),
//             calculatedAmount: Amount(value: '19.25'),
//             rateApplicablePercent: '7.00',
//           ),
//           TradeTax(
//             typeCode: 'VAT',
//             categoryCode: 'S',
//             basisAmount: Amount(value: '190.00'),
//             calculatedAmount: Amount(value: '36.10'),
//             rateApplicablePercent: '19.00',
//           ),
//         ],
//         currency: 'EUR',
//         tradeSettlementPaymentMeans: [
//           TradeSettlementPaymentMeans(
//             typeCode: '58',
//             information: 'Zahlung per SEPA Überweisung.',
//             payeePartyCreditorFinancialAccount: CreditorFinancialAccount(
//               ibanId: Id(value: 'DE02120300000000202051'),
//               accountName: 'Kunden AG',
//             ),
//             payeeSpecifiedCreditorFinancialInstitution:
//                 CreditorFinancialInstitution(
//               bicId: Id(
//                 value: 'BYLADEM1001',
//               ),
//             ),
//           )
//         ],
//       ),
//     ),
//   );

  CrossIndustryInvoice i = CrossIndustryInvoice.fromJson(
    (json.decode(
      File(
        'tests/MwPdf/examples/pdf_zugferd1.json',
      ).readAsStringSync(),
    ) as Dict)['invoice_cii'] as Dict,
  );

  XmlDocument xml = i.toXml();
  print(Util.prettyXml(xml));

  // File f = await File('zug_dart2.xml').create();
  // f.writeAsString(
  //   Util.prettyXml(xml),
  //   flush: true,
  // );
}
