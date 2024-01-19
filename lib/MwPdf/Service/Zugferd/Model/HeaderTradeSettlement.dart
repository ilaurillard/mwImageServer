import 'package:mwcdn/MwPdf/Service/Zugferd/Model/LogisticsServiceCharge.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeParty.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradePaymentTerms.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementHeaderMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeTax.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
import 'package:xml/src/xml/builder.dart';

class HeaderTradeSettlement {
  final String? creditorReferenceID;
  final String? paymentReference;
  final String currency;
  final TradeParty? payeeTradeParty;
  final List<TradeSettlementPaymentMeans> specifiedTradeSettlementPaymentMeans;
  final List<TradeTax> tradeTaxes;
  final List<TradeAllowanceCharge> specifiedTradeAllowanceCharge;
  final List<LogisticsServiceCharge> specifiedLogisticsServiceCharge;
  final List<TradePaymentTerms> specifiedTradePaymentTerms;
  final TradeSettlementHeaderMonetarySummation
      specifiedTradeSettlementHeaderMonetarySummation;
  final ReferencedDocument? invoiceReferencedDocument;

  HeaderTradeSettlement({
    this.creditorReferenceID,
    this.paymentReference,
    required this.currency,
    this.payeeTradeParty,
    this.specifiedTradeSettlementPaymentMeans = const [],
    this.tradeTaxes = const [],
    this.specifiedTradeAllowanceCharge = const [],
    this.specifiedLogisticsServiceCharge = const [],
    this.specifiedTradePaymentTerms = const [],
    required this.specifiedTradeSettlementHeaderMonetarySummation,
    this.invoiceReferencedDocument,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(
            builder, creditorReferenceID, 'ram:CreditorReferenceID');
        Util.stringElement(builder, paymentReference, 'ram:PaymentReference');
        Util.stringElement(builder, currency, 'ram:InvoiceCurrencyCode');
        if (payeeTradeParty != null) {
          payeeTradeParty!.toXml(builder, 'ram:PayeeTradeParty');
        }
        for (TradeSettlementPaymentMeans t
            in specifiedTradeSettlementPaymentMeans) {
          t.toXml(builder, 'ram:SpecifiedTradeSettlementPaymentMeans');
        }
        for (TradeTax t in tradeTaxes) {
          t.toXml(builder, 'ram:ApplicableTradeTax');
        }
        for (TradeAllowanceCharge t in specifiedTradeAllowanceCharge) {
          t.toXml(builder, 'ram:SpecifiedTradeAllowanceCharge');
        }
        for (LogisticsServiceCharge t in specifiedLogisticsServiceCharge) {
          t.toXml(builder, 'ram:SpecifiedLogisticsServiceCharge');
        }
        for (TradePaymentTerms t in specifiedTradePaymentTerms) {
          t.toXml(builder, 'ram:SpecifiedTradePaymentTerms');
        }
        specifiedTradeSettlementHeaderMonetarySummation.toXml(
          builder,
          'ram:SpecifiedTradeSettlementHeaderMonetarySummation',
        );
        if (invoiceReferencedDocument != null) {
          invoiceReferencedDocument!.toXml(builder, 'ram:InvoiceReferencedDocument');
        }
      },
    );
  }
}
