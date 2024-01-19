import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Amount.dart';
import 'package:xml/src/xml/builder.dart';

class TradeSettlementLineMonetarySummation {
  final Amount totalAmount;
  final Amount? totalAllowanceChargeAmount;

  TradeSettlementLineMonetarySummation({
    required this.totalAmount,
    this.totalAllowanceChargeAmount,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        totalAmount.toXml(builder, 'ram:LineTotalAmount');
        if (totalAllowanceChargeAmount != null) {
          totalAllowanceChargeAmount!.toXml(builder, 'ram:TotalAllowanceChargeAmount');
        }
      },
    );
  }
}
