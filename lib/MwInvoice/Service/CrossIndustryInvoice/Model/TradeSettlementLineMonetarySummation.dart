import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:xml/xml.dart';

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
          totalAllowanceChargeAmount!
              .toXml(builder, 'ram:TotalAllowanceChargeAmount');
        }
      },
    );
  }

  static TradeSettlementLineMonetarySummation fromJson(Dict json) {
    return TradeSettlementLineMonetarySummation(
      totalAmount: Amount.fromJson(json['totalAmount'] as Dict? ?? {}) ?? Amount.empty(),
      totalAllowanceChargeAmount: Amount.fromJson(json['totalAllowanceChargeAmount'] as Dict? ?? {}),
    );
  }
}
