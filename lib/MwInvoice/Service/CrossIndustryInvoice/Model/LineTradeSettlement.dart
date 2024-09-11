import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Period.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAccountingAccount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementLineMonetarySummation.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class LineTradeSettlement {
  final List<TradeTax> tradeTax;
  final List<TradeAllowanceCharge> tradeAllowanceCharge;
  final Period? period;
  final TradeSettlementLineMonetarySummation monetarySummation;
  final List<TradeAccountingAccount> tradeAccountingAccount;

  LineTradeSettlement({
    this.tradeTax = const [],
    this.tradeAllowanceCharge = const [],
    this.period,
    required this.monetarySummation,
    this.tradeAccountingAccount = const [],
  });

  void toXml(
    XmlBuilder builder,
  ) {
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
    if (period != null) {
      period!.toXml(
        builder,
        'ram:BillingSpecifiedPeriod',
      );
    }
    monetarySummation.toXml(
      builder,
      'ram:SpecifiedTradeSettlementLineMonetarySummation',
    );

    for (TradeAccountingAccount t in tradeAccountingAccount) {
      t.toXml(
        builder,
        'ram:ReceivableSpecifiedTradeAccountingAccount',
      );
    }
  }

  static LineTradeSettlement? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return LineTradeSettlement(
      tradeTax: xml
          .findElements('ram:ApplicableTradeTax')
          .map((XmlElement e) => TradeTax.fromXml(e)!)
          .toList(),
      tradeAllowanceCharge: xml
          .findElements('ram:SpecifiedTradeAllowanceCharge')
          .map(
            (XmlElement e) => TradeAllowanceCharge.fromXml(e)!,
          )
          .toList(),
      period: Period.fromXml(
        xml.findElements('ram:BillingSpecifiedPeriod').singleOrNull,
      ),
      monetarySummation: TradeSettlementLineMonetarySummation.fromXml(
        xml
            .findElements('ram:SpecifiedTradeSettlementLineMonetarySummation')
            .singleOrNull,
      )!,
      tradeAccountingAccount: xml
          .findElements('ram:ReceivableSpecifiedTradeAccountingAccount')
          .map(
            (XmlElement e) => TradeAccountingAccount.fromXml(e)!,
          )
          .toList(),
    );
  }

  static LineTradeSettlement fromJson(
    Dict json,
  ) {
    return LineTradeSettlement(
      tradeTax: (json['tradeTax'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
      tradeAllowanceCharge:
          (json['tradeAllowanceCharge'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradeAllowanceCharge.fromJson(e as Dict))
              .toList(),
      period: Period.fromJson(json['period'] as Dict? ?? {}),
      monetarySummation: TradeSettlementLineMonetarySummation.fromJson(
          json['monetarySummation'] as Dict? ?? {}),
      tradeAccountingAccount:
          (json['tradeAccountingAccount'] as List<dynamic>? ?? [])
              .map((dynamic e) => TradeAccountingAccount.fromJson(e as Dict))
              .toList(),
    );
  }
}
