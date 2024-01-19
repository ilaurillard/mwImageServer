import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Period.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeAccountingAccount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeAllowanceCharge.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementLineMonetarySummation.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeTax.dart';
import 'package:xml/src/xml/builder.dart';

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
}
