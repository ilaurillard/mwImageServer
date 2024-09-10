import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CreditorFinancialAccount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CreditorFinancialInstitution.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CrossIndustryInvoice.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DateTime.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DateTimeString.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DocumentContextParameter.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DocumentLineDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ExchangedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ExchangedDocumentContext.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeAgreement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeDelivery.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/HeaderTradeSettlement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeAgreement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeDelivery.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LineTradeSettlement.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Note.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Quantity.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainEvent.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainTradeLineItem.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainTradeTransaction.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TaxRegistration.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAddress.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeContact.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeParty.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradePaymentTerms.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradePrice.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeProduct.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementHeaderMonetarySummation.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementLineMonetarySummation.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/UniversalCommunication.dart';
import 'package:xml/xml.dart';

Future<void> main() async {
  CrossIndustryInvoice i = CrossIndustryInvoice(
    documentContext: ExchangedDocumentContext(
      parameter: DocumentContextParameter(
        id: 'urn:cen.eu:en16931:2017#compliant#urn:xoev-de:kosit:standard:xrechnung_1.2',
      ),
    ),
    document: ExchangedDocument(
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
    tradeTransaction: SupplyChainTradeTransaction(
      lineItems: [
        SupplyChainTradeLineItem(
          documentLineDocument: DocumentLineDocument(
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
              amount: Amount(
                value: '9.9000',
              ),
            ),
            netPrice: TradePrice(
              amount: Amount(
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
          lineTradeSettlement: LineTradeSettlement(
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
            // tradeAllowanceCharge: [
            //   TradeAllowanceCharge(
            //     actualAmount: Amount(value: 'xxx'),
            //     indicator: Indicator(indicator: true),
            //   ),
            // ],
          ),
        ),
        SupplyChainTradeLineItem(
          documentLineDocument: DocumentLineDocument(
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
              amount: Amount(
                value: '5.5000',
              ),
            ),
            netPrice: TradePrice(
              amount: Amount(
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
          lineTradeSettlement: LineTradeSettlement(
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
      headerTradeAgreement: HeaderTradeAgreement(
        sellerTradeParty: TradeParty(
          globalID: [Id(value: '4000001123452', schemeID: '0088')],
          name: 'Lieferant GmbH',
          tradeContact: TradeContact(
            personName: 'Max Mustermann',
            departmentName: 'Muster-Einkauf',
            telephone: UniversalCommunication(
              completeNumber: '+49891234567',
            ),
            email: UniversalCommunication(
              uriid: Id(
                value: 'Max@Mustermann.de',
              ),
            ),
          ),
          tradeAddress: TradeAddress(
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
          tradeAddress: TradeAddress(
            postcode: '69876',
            lineOne: 'Kundenstraße 15',
            city: 'Frankfurt',
            countryCode: 'DE',
          ),
        ),
        buyerReference: '04011000-12345-34',
      ),
      headerTradeDelivery: HeaderTradeDelivery(
        chainEvent: SupplyChainEvent(
          date: DateTime(
            dateTimeString: DateTimeString(
              format: 102,
              value: '20180305',
            ),
          ),
        ),
      ),
      headerTradeSettlement: HeaderTradeSettlement(
        tradeSettlementHeaderMonetarySummation:
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
        tradePaymentTerms: [
          TradePaymentTerms(
            description:
                'Zahlbar innerhalb 30 Tagen netto bis 04.04.2018, 3% Skonto innerhalb 10 Tagen bis 15.03.2018',
          )
        ],
        tradeTax: [
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
        tradeSettlementPaymentMeans: [
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

  print(xml.toXmlString(pretty: true));

  // File f = await File('zug_dart.xml').create();
  // f.writeAsString(
  //   Util.prettyXml(xml),
  //   flush: true,
  // );
}
