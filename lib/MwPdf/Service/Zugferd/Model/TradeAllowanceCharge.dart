import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Amount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Indicator.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeTax.dart';
import 'package:xml/src/xml/builder.dart';

class TradeAllowanceCharge {
  final Indicator? indicator;
  final String? calculationPercent;
  final Amount? basisAmount;
  final Amount actualAmount;
  final String? reason;
  final List<TradeTax> tradeTax;

  TradeAllowanceCharge({
    this.indicator,
    this.calculationPercent,
    this.basisAmount,
    required this.actualAmount,
    this.reason,
    this.tradeTax = const [],
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        if (indicator != null) {
          indicator!.toXml(builder, 'ram:ChargeIndicator');
        }
        if (calculationPercent != null) {
          builder.element(
            'ram:CalculationPercent',
            nest: () {
              builder.text(calculationPercent!);
            },
          );
        }
        if (basisAmount != null) {
          basisAmount!.toXml(builder, 'ram:BasisAmount');
        }
        actualAmount.toXml(builder, 'ram:ActualAmount');
        if (reason != null) {
          builder.element(
            'ram:Reason',
            nest: () {
              builder.text(reason!);
            },
          );
        }
        for (TradeTax t in tradeTax) {
          t.toXml(builder, 'ram:CategoryTradeTax');
        }
      },
    );
  }
}
