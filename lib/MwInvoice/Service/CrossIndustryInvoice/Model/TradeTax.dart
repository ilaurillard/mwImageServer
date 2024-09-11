import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Amount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeTax {
  final Amount? calculatedAmount;
  final String typeCode;
  final String? exemptionReason;
  final Amount? basisAmount;
  final Amount? lineTotalBasisAmount;
  final Amount? allowanceChargeBasisAmount;
  final String? applicablePercent;
  final String? categoryCode;
  final String? rateApplicablePercent;

  TradeTax({
    this.calculatedAmount,
    required this.typeCode,
    this.exemptionReason,
    this.basisAmount,
    this.lineTotalBasisAmount,
    this.allowanceChargeBasisAmount,
    this.applicablePercent,
    this.categoryCode,
    this.rateApplicablePercent,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        if (calculatedAmount != null) {
          calculatedAmount!.toXml(
            builder,
            'ram:CalculatedAmount',
          );
        }
        builder.element(
          'ram:TypeCode',
          nest: () {
            builder.text(typeCode);
          },
        );
        if (exemptionReason != null) {
          builder.element(
            'ram:ExemptionReason',
            nest: () {
              builder.text(exemptionReason!);
            },
          );
        }
        if (basisAmount != null) {
          basisAmount!.toXml(
            builder,
            'ram:BasisAmount',
          );
        }
        if (lineTotalBasisAmount != null) {
          lineTotalBasisAmount!.toXml(
            builder,
            'ram:LineTotalBasisAmount',
          );
        }
        if (allowanceChargeBasisAmount != null) {
          allowanceChargeBasisAmount!.toXml(
            builder,
            'ram:AllowanceChargeBasisAmount',
          );
        }
        if (applicablePercent != null) {
          builder.element(
            'ram:ApplicablePercent',
            nest: () {
              builder.text(applicablePercent!);
            },
          );
        }
        if (categoryCode != null) {
          builder.element(
            'ram:CategoryCode',
            nest: () {
              builder.text(categoryCode!);
            },
          );
        }
        if (rateApplicablePercent != null) {
          builder.element(
            'ram:RateApplicablePercent',
            nest: () {
              builder.text(rateApplicablePercent!);
            },
          );
        }
      },
    );
  }

  static TradeTax? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return TradeTax(
      calculatedAmount: Amount.fromXml(
        xml.findElements('ram:CalculatedAmount').singleOrNull,
      ),
      typeCode: Util.innerTextOf(xml, 'ram:TypeCode') ?? '',
      exemptionReason: Util.innerTextOf(xml, 'ram:ExemptionReason'),
      basisAmount: Amount.fromXml(
        xml.findElements('ram:BasisAmount').singleOrNull,
      ),
      lineTotalBasisAmount: Amount.fromXml(
        xml.findElements('ram:LineTotalBasisAmount').singleOrNull,
      ),
      allowanceChargeBasisAmount: Amount.fromXml(
        xml.findElements('ram:AllowanceChargeBasisAmount').singleOrNull,
      ),
      applicablePercent: Util.innerTextOf(xml, 'ram:ApplicablePercent'),
      categoryCode: Util.innerTextOf(xml, 'ram:CategoryCode'),
      rateApplicablePercent: Util.innerTextOf(xml, 'ram:RateApplicablePercent'),
    );
  }

  static TradeTax fromJson(
    Dict json,
  ) {
    return TradeTax(
      calculatedAmount:
          Amount.fromJson(json['calculatedAmount'] as Dict? ?? {}),
      typeCode: json['typeCode'] as String? ?? '?',
      exemptionReason: json['exemptionReason'] as String?,
      basisAmount: Amount.fromJson(json['basisAmount'] as Dict? ?? {}),
      lineTotalBasisAmount:
          Amount.fromJson(json['lineTotalBasisAmount'] as Dict? ?? {}),
      allowanceChargeBasisAmount:
          Amount.fromJson(json['allowanceChargeBasisAmount'] as Dict? ?? {}),
      applicablePercent: json['applicablePercent'] as String?,
      categoryCode: json['categoryCode'] as String?,
      rateApplicablePercent: json['rateApplicablePercent'] as String?,
    );
  }
}
