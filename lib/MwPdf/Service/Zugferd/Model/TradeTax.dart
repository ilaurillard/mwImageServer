import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Amount.dart';
import 'package:xml/src/xml/builder.dart';

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

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        if (calculatedAmount != null) {
          calculatedAmount!.toXml(builder, 'ram:CalculatedAmount');
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
          basisAmount!.toXml(builder, 'ram:BasisAmount');
        }
        if (lineTotalBasisAmount != null) {
          lineTotalBasisAmount!.toXml(builder, 'ram:LineTotalBasisAmount');
        }
        if (allowanceChargeBasisAmount != null) {
          allowanceChargeBasisAmount!.toXml(builder, 'ram:AllowanceChargeBasisAmount');
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
}
