import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LogisticsServiceCharge.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeParty.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradePaymentTerms.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementHeaderMonetarySummation.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementPaymentMeans.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class HeaderTradeSettlement {
  final String? creditorReferenceID;
  final String? paymentReference;
  final String currency;
  final TradeParty? payeeTradeParty;
  final List<TradeSettlementPaymentMeans> tradeSettlementPaymentMeans;
  final List<TradeTax> tradeTax;
  final List<TradeAllowanceCharge> tradeAllowanceCharge;
  final List<LogisticsServiceCharge> logisticsServiceCharge;
  final List<TradePaymentTerms> tradePaymentTerms;
  final TradeSettlementHeaderMonetarySummation
      summation;
  final ReferencedDocument? referencedDocument;

  HeaderTradeSettlement({
    this.creditorReferenceID,
    this.paymentReference,
    required this.currency,
    this.payeeTradeParty,
    this.tradeSettlementPaymentMeans = const [],
    this.tradeTax = const [],
    this.tradeAllowanceCharge = const [],
    this.logisticsServiceCharge = const [],
    this.tradePaymentTerms = const [],
    required this.summation,
    this.referencedDocument,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(
          builder,
          creditorReferenceID,
          'ram:CreditorReferenceID',
        );
        Util.stringElement(
          builder,
          paymentReference,
          'ram:PaymentReference',
        );
        Util.stringElement(
          builder,
          currency,
          'ram:InvoiceCurrencyCode',
        );
        if (payeeTradeParty != null) {
          payeeTradeParty!.toXml(
            builder,
            'ram:PayeeTradeParty',
          );
        }
        for (TradeSettlementPaymentMeans t
            in tradeSettlementPaymentMeans) {
          t.toXml(
            builder,
            'ram:SpecifiedTradeSettlementPaymentMeans',
          );
        }
        for (TradeTax t in tradeTax) {
          t.toXml(
            builder,
            'ram:ApplicableTradeTax',
          );
        }
        for (TradeAllowanceCharge t in tradeAllowanceCharge) {
          t.toXml(
            builder,
            'ram:SpecifiedTradeAllowanceCharge',
          );
        }
        for (LogisticsServiceCharge t in logisticsServiceCharge) {
          t.toXml(
            builder,
            'ram:SpecifiedLogisticsServiceCharge',
          );
        }
        for (TradePaymentTerms t in tradePaymentTerms) {
          t.toXml(
            builder,
            'ram:SpecifiedTradePaymentTerms',
          );
        }
        summation.toXml(
          builder,
          'ram:SpecifiedTradeSettlementHeaderMonetarySummation',
        );
        if (referencedDocument != null) {
          referencedDocument!.toXml(
            builder,
            'ram:InvoiceReferencedDocument',
          );
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
      tradeSettlementPaymentMeans:
          (json['tradeSettlementPaymentMeans'] as List<dynamic>? ?? [])
              .map((dynamic e) =>
                  TradeSettlementPaymentMeans.fromJson(e as Dict))
              .toList(),
      tradeTax: (json['tradeTax'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
      tradeAllowanceCharge:
          (json['tradeAllowanceCharge'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradeAllowanceCharge.fromJson(e as Dict))
              .toList(),
      logisticsServiceCharge:
          (json['logisticsServiceCharge'] as List<dynamic>? ?? [])
              .map((dynamic e) => LogisticsServiceCharge.fromJson(e as Dict))
              .toList(),
      tradePaymentTerms:
          (json['tradePaymentTerms'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradePaymentTerms.fromJson(e as Dict))
              .toList(),
      summation:
          TradeSettlementHeaderMonetarySummation.fromJson(
        json['summation'] as Dict? ?? {},
      ),
      referencedDocument: ReferencedDocument.fromJson(
          json['referencedDocument'] as Dict? ?? {}),
    );
  }
}
