import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:xml/xml.dart';

class TradeSettlementHeaderMonetarySummation {
  final Amount? lineTotalAmount;
  final Amount? chargeTotalAmount;
  final Amount? allowanceTotalAmount;
  final List<Amount> taxBasisTotalAmount;
  final List<Amount> taxTotalAmount;
  final Amount? roundingAmount;
  final List<Amount> grandTotalAmount;
  final Amount? totalPrepaidAmount;
  final Amount duePayableAmount;

  TradeSettlementHeaderMonetarySummation({
    this.lineTotalAmount,
    this.chargeTotalAmount,
    this.allowanceTotalAmount,
    this.taxBasisTotalAmount = const [],
    this.taxTotalAmount = const [],
    this.roundingAmount,
    this.grandTotalAmount = const [],
    this.totalPrepaidAmount,
    required this.duePayableAmount,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(name, nest: () {
      if (lineTotalAmount != null) {
        lineTotalAmount!.toXml(builder, 'ram:LineTotalAmount');
      }
      if (chargeTotalAmount != null) {
        chargeTotalAmount!.toXml(builder, 'ram:ChargeTotalAmount');
      }
      if (allowanceTotalAmount != null) {
        allowanceTotalAmount!.toXml(builder, 'ram:AllowanceTotalAmount');
      }
      for (Amount a in taxBasisTotalAmount) {
        a.toXml(builder, 'ram:TaxBasisTotalAmount');
      }
      for (Amount a in taxTotalAmount) {
        a.toXml(builder, 'ram:TaxTotalAmount');
      }
      if (roundingAmount != null) {
        roundingAmount!.toXml(builder, 'ram:RoundingAmount');
      }
      for (Amount a in grandTotalAmount) {
        a.toXml(builder, 'ram:GrandTotalAmount');
      }
      if (totalPrepaidAmount != null) {
        totalPrepaidAmount!.toXml(builder, 'ram:TotalPrepaidAmount');
      }
      duePayableAmount.toXml(builder, 'ram:DuePayableAmount');
    });
  }

  static TradeSettlementHeaderMonetarySummation fromJson(Dict json) {
    return TradeSettlementHeaderMonetarySummation(
      lineTotalAmount: Amount.fromJson(json['lineTotalAmount'] as Dict? ?? {}),
      chargeTotalAmount:
          Amount.fromJson(json['chargeTotalAmount'] as Dict? ?? {}),
      allowanceTotalAmount:
          Amount.fromJson(json['allowanceTotalAmount'] as Dict? ?? {}),
      taxBasisTotalAmount: (json['taxBasisTotalAmount'] as List<dynamic>? ?? [])
          .map((dynamic e) => Amount.fromJson(e as Dict) ?? Amount.empty())
          .toList(),
      taxTotalAmount: (json['taxTotalAmount'] as List<dynamic>? ?? [])
          .map((dynamic e) => Amount.fromJson(e as Dict) ?? Amount.empty())
          .toList(),
      roundingAmount: Amount.fromJson(json['roundingAmount'] as Dict? ?? {}),
      grandTotalAmount: (json['grandTotalAmount'] as List<dynamic>? ?? [])
          .map((dynamic e) => Amount.fromJson(e as Dict) ?? Amount.empty())
          .toList(),
      totalPrepaidAmount:
          Amount.fromJson(json['totalPrepaidAmount'] as Dict? ?? {}),
      duePayableAmount:
          Amount.fromJson(json['duePayableAmount'] as Dict? ?? {}) ??
              Amount.empty(),
    );
  }
}
