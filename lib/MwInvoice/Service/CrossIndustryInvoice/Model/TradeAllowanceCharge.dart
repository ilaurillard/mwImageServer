import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Indicator.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeTax.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeAllowanceCharge {
  final Indicator? indicator;
  final String? calculationPercent;
  final Amount? basisAmount;
  final Amount actualAmount;
  final String? reason;
  final String? reasonCode;
  final List<TradeTax> tradeTax;

  TradeAllowanceCharge({
    this.indicator,
    this.calculationPercent,
    this.basisAmount,
    required this.actualAmount,
    this.reason,
    this.reasonCode,
    this.tradeTax = const [],
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        if (indicator != null) {
          indicator!.toXml(
            builder,
            'ram:ChargeIndicator',
          );
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
          basisAmount!.toXml(
            builder,
            'ram:BasisAmount',
          );
        }
        actualAmount.toXml(
          builder,
          'ram:ActualAmount',
        );
        if (reason != null) {
          builder.element(
            'ram:Reason',
            nest: () {
              builder.text(reason!);
            },
          );
        }
        if (reasonCode != null) {
          builder.element(
            'ram:ReasonCode',
            nest: () {
              builder.text(reasonCode!);
            },
          );
        }
        for (TradeTax t in tradeTax) {
          t.toXml(
            builder,
            'ram:CategoryTradeTax',
          );
        }
      },
    );
  }

  static TradeAllowanceCharge fromJson(Dict json) {
    return TradeAllowanceCharge(
      indicator: Indicator.fromJson(json['indicator'] as Dict? ?? {}),
      calculationPercent: json['calculationPercent'] as String?,
      basisAmount: Amount.fromJson(json['basisAmount'] as Dict? ?? {}),
      actualAmount: Amount.fromJson(json['actualAmount'] as Dict? ?? {}) ??
          Amount.empty(),
      reason: json['reason'] as String?,
      reasonCode: json['reasonCode'] as String?,
      tradeTax: (json['tradeTax'] as List<dynamic>? ?? [])
          .map((dynamic e) => TradeTax.fromJson(e as Dict))
          .toList(),
    );
  }
}
