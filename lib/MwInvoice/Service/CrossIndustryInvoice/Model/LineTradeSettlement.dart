import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Period.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAccountingAccount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementLineMonetarySummation.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:xml/xml.dart';

class LineTradeSettlement {
  final List<TradeTax> tradeTax;
  final List<TradeAllowanceCharge> specifiedTradeAllowanceCharge;
  final Period? billingSpecifiedPeriod;
  final TradeSettlementLineMonetarySummation monetarySummation;
  final List<TradeAccountingAccount> tradeAccountingAccount;

  LineTradeSettlement({
    this.tradeTax = const [],
    this.specifiedTradeAllowanceCharge = const [],
    this.billingSpecifiedPeriod,
    required this.monetarySummation,
    this.tradeAccountingAccount = const [],
  });

  void toXml(XmlBuilder builder) {
    for (TradeTax t in tradeTax) {
      t.toXml(builder, 'ram:ApplicableTradeTax');
    }
    for (TradeAllowanceCharge t in specifiedTradeAllowanceCharge) {
      t.toXml(builder, 'ram:SpecifiedTradeAllowanceCharge');
    }
    if (billingSpecifiedPeriod != null) {
      billingSpecifiedPeriod!.toXml(builder, 'ram:BillingSpecifiedPeriod');
    }
    monetarySummation.toXml(
        builder, 'ram:SpecifiedTradeSettlementLineMonetarySummation');

    for (TradeAccountingAccount t in tradeAccountingAccount) {
      t.toXml(builder, 'ram:ReceivableSpecifiedTradeAccountingAccount');
    }
  }

  static LineTradeSettlement fromJson(Dict json) {
    return LineTradeSettlement(
      tradeTax: (json['tradeTax'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
      specifiedTradeAllowanceCharge:
          (json['specifiedTradeAllowanceCharge'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradeAllowanceCharge.fromJson(e as Dict))
              .toList(),
      billingSpecifiedPeriod:
          Period.fromJson(json['billingSpecifiedPeriod'] as Dict? ?? {}),
      monetarySummation: TradeSettlementLineMonetarySummation.fromJson(
          json['monetarySummation'] as Dict? ?? {}),
      tradeAccountingAccount:
          (json['tradeAccountingAccount'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradeAccountingAccount.fromJson(e as Dict))
              .toList(),
    );
  }
}
