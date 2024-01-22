import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/LogisticsServiceCharge.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeParty.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradePaymentTerms.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeSettlementHeaderMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/TradeTax.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Util.dart';
import 'package:xml/xml.dart';

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
          invoiceReferencedDocument!
              .toXml(builder, 'ram:InvoiceReferencedDocument');
        }
      },
    );
  }

  static HeaderTradeSettlement fromJson(Dict json) {
    return HeaderTradeSettlement(
      creditorReferenceID: json['creditorReferenceID'] as String?,
      paymentReference: json['paymentReference'] as String?,
      currency: json['currency'] as String? ?? '?',
      payeeTradeParty:
          TradeParty.fromJson(json['payeeTradeParty'] as Dict? ?? {}),
      specifiedTradeSettlementPaymentMeans:
          (json['specifiedTradeSettlementPaymentMeans'] as List<dynamic>? ?? [])
              .map((dynamic e) =>
                  TradeSettlementPaymentMeans.fromJson(e as Dict))
              .toList(),
      tradeTaxes: (json['tradeTaxes'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
      specifiedTradeAllowanceCharge:
          (json['specifiedTradeAllowanceCharge'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradeAllowanceCharge.fromJson(e as Dict))
              .toList(),
      specifiedLogisticsServiceCharge:
          (json['specifiedLogisticsServiceCharge'] as List<dynamic>? ?? [])
              .map((dynamic e) => LogisticsServiceCharge.fromJson(e as Dict))
              .toList(),
      specifiedTradePaymentTerms:
          (json['specifiedTradePaymentTerms'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradePaymentTerms.fromJson(e as Dict))
              .toList(),
      specifiedTradeSettlementHeaderMonetarySummation:
          TradeSettlementHeaderMonetarySummation.fromJson(
        json['specifiedTradeSettlementHeaderMonetarySummation'] as Dict? ?? {},
      ),
      invoiceReferencedDocument: ReferencedDocument.fromJson(
          json['invoiceReferencedDocument'] as Dict? ?? {}),
    );
  }
}
