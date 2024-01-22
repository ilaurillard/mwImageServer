import 'dart:io';

import 'package:mwcdn/MwPdf/Service/Facturx/Model/Amount.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/CreditorFinancialAccount.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/CreditorFinancialInstitution.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/DateTime.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/DateTimeString.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/DocumentContextParameter.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/ExchangedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/ExchangedDocumentContext.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/HeaderTradeAgreement.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/HeaderTradeDelivery.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/HeaderTradeSettlement.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/LineTradeAgreement.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/LineTradeDelivery.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/LineTradeSettlement.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/Note.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/Quantity.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/SupplyChainTradeLineItem.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/SupplyChainTradeTransaction.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TaxRegistration.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeAddress.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeContact.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeParty.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradePaymentTerms.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradePrice.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeProduct.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeSettlementHeaderMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeSettlementLineMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeTax.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/UniversalCommunication.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Util.dart';
import 'package:xml/xml.dart';

Future<void> main() async {
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
    Util.prettyXml(xml),
    flush: true,
  );
}
