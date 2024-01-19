import 'dart:io';

import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Amount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/CreditorFinancialAccount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/CreditorFinancialInstitution.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTime.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTimeString.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DocumentContextParameter.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ExchangedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ExchangedDocumentContext.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/HeaderTradeAgreement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/HeaderTradeDelivery.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/HeaderTradeSettlement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Indicator.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LineTradeAgreement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LineTradeDelivery.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LineTradeSettlement.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Note.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Quantity.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainTradeLineItem.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainTradeTransaction.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TaxRegistration.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeAddress.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeContact.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeParty.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradePaymentTerms.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradePrice.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeProduct.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementHeaderMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementLineMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeTax.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/UniversalCommunication.dart';
import 'package:xml/xml.dart';

Future<void> main() async {
//   XmlDocument metaXml = XmlDocument.parse('''
// <?xpacket begin="" id="W5M0MpCehiHzreSzNTczkc9d"?>
// <rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
//
// </rdf:RDF>
// <?xpacket end="r"?>
// ''');
//
//   // $s .= $this->_getxmpdescription('pdf', 'http://ns.adobe.com/pdf/1.3/', $pdf);
//   // $s .= $this->_getxmpdescription('xmp', 'http://ns.adobe.com/xap/1.0/', $xmp);
//   // if($dc)
//   // $s .= $this->_getxmpdescription('dc', 'http://purl.org/dc/elements/1.1/', $dc);
//   // $s .= $this->_getxmpdescription('pdfaid', 'http://www.aiim.org/pdfa/ns/id/', $pdfaid);
//   // $s .= '</rdf:RDF>'."\n";
//   // $s .= '<?xpacket end="r"?>';
//
//   print(metaXml);

  CrossIndustryInvoice i = CrossIndustryInvoice(
    exchangedDocumentContext: ExchangedDocumentContext(
      documentContextParameter: DocumentContextParameter(
        id: 'urn:cen.eu:en16931:2017#compliant#urn:xoev-de:kosit:standard:xrechnung_1.2',
      ),
    ),
    exchangedDocument: ExchangedDocument(
      id: '471102',
      typeCode: '380',
      issueDateTime: DateTime(
        dateTimeString: DateTimeString(format: 102, value: '20180305'),
      ),
      // languageId: ['XXX'],
      notes: [
        Note(
          content: 'Rechnung gemäß Bestellung vom 01.03.2018.',
        ),
        Note(
          content: '''
          Lieferant GmbH				
Lieferantenstraße 20				
80333 München				
Deutschland				
Geschäftsführer: Hans Muster
Handelsregisternummer: H A 123
          ''',
          subjectCode: 'REG',
        ),
      ],
    ),
    supplyChainTradeTransaction: SupplyChainTradeTransaction(
      lineItems: [
        SupplyChainTradeLineItem(
          associatedDocumentLineDocument: DocumentLineDocument(
            lineId: '1',
            // notes: [Note(content: 'xxx')],
          ),
          specifiedTradeProduct: TradeProduct(
            name: 'Trennblätter A4',
            sellerAssignedID: 'TB100A4',
            globalID: Id(
              value: '4012345001235',
              schemeID: '0160',
            ),
            // description: 'XXX',
            // tradeCountry: TradeCountry(id: 'XXX'),
          ),
          tradeAgreement: LineTradeAgreement(
            grossPrice: TradePrice(
              chargeAmount: Amount(
                value: '9.9000',
              ),
            ),
            netPrice: TradePrice(
              chargeAmount: Amount(
                value: '9.9000',
              ),
            ),
          ),
          delivery: LineTradeDelivery(
            billedQuantity: Quantity(
              value: '20.0000',
              unitCode: 'H87',
            ),
            // chainEvent: SupplyChainEvent(
            //   date: DateTime(
            //     dateTimeString: DateTimeString(
            //       format: 1,
            //       value: 'xxx',
            //     ),
            //   ),
            // ),
          ),
          specifiedLineTradeSettlement: LineTradeSettlement(
            tradeTax: [
              TradeTax(
                typeCode: 'VAT',
                categoryCode: 'S',
                rateApplicablePercent: '19.00',
              ),
            ],
            monetarySummation: TradeSettlementLineMonetarySummation(
              totalAmount: Amount(value: '198.00'),
            ),
            // specifiedTradeAllowanceCharge: [
            //   TradeAllowanceCharge(
            //     actualAmount: Amount(value: 'xxx'),
            //     indicator: Indicator(indicator: true),
            //   ),
            // ],
          ),
        ),
        SupplyChainTradeLineItem(
          associatedDocumentLineDocument: DocumentLineDocument(
            lineId: '2',
          ),
          specifiedTradeProduct: TradeProduct(
            name: 'Joghurt Banane',
            sellerAssignedID: 'ARNR2',
            globalID: Id(
              value: '4000050986428',
              schemeID: '0160',
            ),
          ),
          tradeAgreement: LineTradeAgreement(
            grossPrice: TradePrice(
              chargeAmount: Amount(
                value: '5.5000',
              ),
            ),
            netPrice: TradePrice(
              chargeAmount: Amount(
                value: '5.5000',
              ),
            ),
          ),
          delivery: LineTradeDelivery(
            billedQuantity: Quantity(
              value: '50.0000',
              unitCode: 'H87',
            ),
          ),
          specifiedLineTradeSettlement: LineTradeSettlement(
            tradeTax: [
              TradeTax(
                typeCode: 'VAT',
                categoryCode: 'S',
                rateApplicablePercent: '7.00',
              ),
            ],
            monetarySummation: TradeSettlementLineMonetarySummation(
              totalAmount: Amount(value: '275.00'),
            ),
          ),
        ),
      ],
      applicableHeaderTradeAgreement: HeaderTradeAgreement(
        sellerTradeParty: TradeParty(
          globalID: [Id(value: '4000001123452', schemeID: '0088')],
          name: 'Lieferant GmbH',
          definedTradeContact: TradeContact(
            personName: 'Max Mustermann',
            departmentName: 'Muster-Einkauf',
            telephoneUniversalCommunication: UniversalCommunication(
              completeNumber: '+49891234567',
            ),
            emailURIUniversalCommunication: UniversalCommunication(
              uriid: Id(
                value: 'Max@Mustermann.de',
              ),
            ),
          ),
          postalTradeAddress: TradeAddress(
            postcode: '80333',
            lineOne: 'Lieferantenstraße 20',
            city: 'München',
            countryCode: 'DE',
          ),
          taxRegistrations: [
            TaxRegistration(
              registration: Id(
                value: '201/113/40209',
                schemeID: 'FC',
              ),
            ),
            TaxRegistration(
              registration: Id(
                value: 'DE123456789',
                schemeID: 'VA',
              ),
            ),
          ],
        ),
        buyerTradeParty: TradeParty(
          id: Id(value: 'GE2020211'),
          name: 'Kunden AG Mitte',
          postalTradeAddress: TradeAddress(
            postcode: '69876',
            lineOne: 'Kundenstraße 15',
            city: 'Frankfurt',
            countryCode: 'DE',
          ),
        ),
        buyerReference: '04011000-12345-34',
      ),
      applicableHeaderTradeDelivery: HeaderTradeDelivery(
        chainEvent: SupplyChainEvent(
          date: DateTime(
            dateTimeString: DateTimeString(
              format: 102,
              value: '20180305',
            ),
          ),
        ),
      ),
      applicableHeaderTradeSettlement: HeaderTradeSettlement(
        specifiedTradeSettlementHeaderMonetarySummation:
            TradeSettlementHeaderMonetarySummation(
          lineTotalAmount: Amount(value: '473.00'),
          chargeTotalAmount: Amount(value: '0.00'),
          allowanceTotalAmount: Amount(value: '0.00'),
          taxBasisTotalAmount: [Amount(value: '473.00')],
          taxTotalAmount: [Amount(value: '56.87', currency: 'EUR')],
          grandTotalAmount: [Amount(value: '529.87')],
          totalPrepaidAmount: Amount(value: '0.00'),
          duePayableAmount: Amount(value: '529.87'),
        ),
        specifiedTradePaymentTerms: [
          TradePaymentTerms(
            description:
                'Zahlbar innerhalb 30 Tagen netto bis 04.04.2018, 3% Skonto innerhalb 10 Tagen bis 15.03.2018',
          )
        ],
        tradeTaxes: [
          TradeTax(
            typeCode: 'VAT',
            categoryCode: 'S',
            basisAmount: Amount(value: '275.00'),
            calculatedAmount: Amount(value: '19.25'),
            rateApplicablePercent: '7.00',
          ),
          TradeTax(
            typeCode: 'VAT',
            categoryCode: 'S',
            basisAmount: Amount(value: '198.00'),
            calculatedAmount: Amount(value: '37.62'),
            rateApplicablePercent: '19.00',
          ),
        ],
        currency: 'EUR',
        specifiedTradeSettlementPaymentMeans: [
          TradeSettlementPaymentMeans(
            typeCode: '58',
            information: 'Zahlung per SEPA Überweisung.',
            payeePartyCreditorFinancialAccount: CreditorFinancialAccount(
              ibanId: Id(value: 'DE02120300000000202051'),
              accountName: 'Kunden AG',
            ),
            payeeSpecifiedCreditorFinancialInstitution:
                CreditorFinancialInstitution(
              bicId: Id(
                value: 'BYLADEM1001',
              ),
            ),
          )
        ],
      ),
    ),
  );

  XmlDocument xml = i.toXml();
  // print(xml.toXmlString(pretty: true));

  File f = await File('zug_dart.xml').create();
  f.writeAsString(
    xml.toXmlString(pretty: true),
    flush: true,
  );
}
