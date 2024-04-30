import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ChargeIndicator.dart';
import '../cbc/Amount.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/AllowanceChargeReasonCode.dart';
import '../cbc/AllowanceChargeReason.dart';
import '../cbc/MultiplierFactorNumeric.dart';
import '../cbc/PrepaidIndicator.dart';
import '../cbc/SequenceNumeric.dart';
import '../cbc/BaseAmount.dart';
import '../cbc/AccountingCostCode.dart';
import '../cbc/AccountingCost.dart';
import '../cbc/PerUnitAmount.dart';
import '../cac/TaxCategory.dart';
import '../cac/TaxTotal.dart';
import '../cac/PaymentMeans.dart';

// A class to describe information about a charge or discount as applied to a price component.
class FreightAllowanceCharge {


  // An indicator that this AllowanceCharge describes a charge (true) or a discount (false).
  final ChargeIndicator chargeIndicator;

  // The monetary amount of this allowance or charge to be applied.
  final Amount amount;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this allowance or charge.
  final ID? iD;

  // A mutually agreed code signifying the reason for this allowance or charge.
  final AllowanceChargeReasonCode? allowanceChargeReasonCode;

  // The reason for this allowance or charge.
  final List<AllowanceChargeReason> allowanceChargeReason;

  // A number by which the base amount is multiplied to calculate the actual amount of this allowance or charge.
  final MultiplierFactorNumeric? multiplierFactorNumeric;

  // An indicator that this allowance or charge is prepaid (true) or not (false).
  final PrepaidIndicator? prepaidIndicator;

  // A number indicating the order of this allowance or charge in the sequence of calculations applied when there are multiple allowances or charges.
  final SequenceNumeric? sequenceNumeric;

  // The monetary amount to which the multiplier factor is applied in calculating the amount of this allowance or charge.
  final BaseAmount? baseAmount;

  // The accounting cost centre used by the buyer to account for this allowance or charge, expressed as a code.
  final AccountingCostCode? accountingCostCode;

  // The accounting cost centre used by the buyer to account for this allowance or charge, expressed as text.
  final AccountingCost? accountingCost;

  // The allowance or charge per item; the total allowance or charge is calculated by multiplying the per unit amount by the quantity of items, either at the level of the individual transaction line or for the total number of items in the document, depending on the context in which it appears.
  final PerUnitAmount? perUnitAmount;

  // A tax category applicable to this allowance or charge.
  final List<TaxCategory> taxCategory;

  // The total of all the taxes applicable to this allowance or charge.
  final TaxTotal? taxTotal;

  // A means of payment for this allowance or charge.
  final List<PaymentMeans> paymentMeans;

  FreightAllowanceCharge ({
    required this.chargeIndicator,
    required this.amount,
    this.uBLExtensions,
    this.iD,
    this.allowanceChargeReasonCode,
    this.allowanceChargeReason = const [],
    this.multiplierFactorNumeric,
    this.prepaidIndicator,
    this.sequenceNumeric,
    this.baseAmount,
    this.accountingCostCode,
    this.accountingCost,
    this.perUnitAmount,
    this.taxCategory = const [],
    this.taxTotal,
    this.paymentMeans = const [],
  });

  static FreightAllowanceCharge? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FreightAllowanceCharge (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      chargeIndicator: ChargeIndicator.fromJson(json['chargeIndicator'] as Map<String, dynamic>?)!,
      allowanceChargeReasonCode: AllowanceChargeReasonCode.fromJson(json['allowanceChargeReasonCode'] as Map<String, dynamic>?),
      allowanceChargeReason: (json['allowanceChargeReason'] as List? ?? []).map((dynamic d) => AllowanceChargeReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      multiplierFactorNumeric: MultiplierFactorNumeric.fromJson(json['multiplierFactorNumeric'] as Map<String, dynamic>?),
      prepaidIndicator: PrepaidIndicator.fromJson(json['prepaidIndicator'] as Map<String, dynamic>?),
      sequenceNumeric: SequenceNumeric.fromJson(json['sequenceNumeric'] as Map<String, dynamic>?),
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?)!,
      baseAmount: BaseAmount.fromJson(json['baseAmount'] as Map<String, dynamic>?),
      accountingCostCode: AccountingCostCode.fromJson(json['accountingCostCode'] as Map<String, dynamic>?),
      accountingCost: AccountingCost.fromJson(json['accountingCost'] as Map<String, dynamic>?),
      perUnitAmount: PerUnitAmount.fromJson(json['perUnitAmount'] as Map<String, dynamic>?),
      taxCategory: (json['taxCategory'] as List? ?? []).map((dynamic d) => TaxCategory.fromJson(d as Map<String, dynamic>?)!).toList(),
      taxTotal: TaxTotal.fromJson(json['taxTotal'] as Map<String, dynamic>?),
      paymentMeans: (json['paymentMeans'] as List? ?? []).map((dynamic d) => PaymentMeans.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'chargeIndicator': chargeIndicator.toJson(),
      'allowanceChargeReasonCode': allowanceChargeReasonCode?.toJson(),
      'allowanceChargeReason': allowanceChargeReason.map((e) => e.toJson()).toList(),
      'multiplierFactorNumeric': multiplierFactorNumeric?.toJson(),
      'prepaidIndicator': prepaidIndicator?.toJson(),
      'sequenceNumeric': sequenceNumeric?.toJson(),
      'amount': amount.toJson(),
      'baseAmount': baseAmount?.toJson(),
      'accountingCostCode': accountingCostCode?.toJson(),
      'accountingCost': accountingCost?.toJson(),
      'perUnitAmount': perUnitAmount?.toJson(),
      'taxCategory': taxCategory.map((e) => e.toJson()).toList(),
      'taxTotal': taxTotal?.toJson(),
      'paymentMeans': paymentMeans.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FreightAllowanceCharge? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return FreightAllowanceCharge (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      chargeIndicator: ChargeIndicator.fromXml(xml.findElements('cbc:ChargeIndicator').singleOrNull)!,
      allowanceChargeReasonCode: AllowanceChargeReasonCode.fromXml(xml.findElements('cbc:AllowanceChargeReasonCode').singleOrNull),
      allowanceChargeReason: xml.findElements('cbc:AllowanceChargeReason').map((XmlElement e) => AllowanceChargeReason.fromXml(e)!).toList(),
      multiplierFactorNumeric: MultiplierFactorNumeric.fromXml(xml.findElements('cbc:MultiplierFactorNumeric').singleOrNull),
      prepaidIndicator: PrepaidIndicator.fromXml(xml.findElements('cbc:PrepaidIndicator').singleOrNull),
      sequenceNumeric: SequenceNumeric.fromXml(xml.findElements('cbc:SequenceNumeric').singleOrNull),
      amount: Amount.fromXml(xml.findElements('cbc:Amount').singleOrNull)!,
      baseAmount: BaseAmount.fromXml(xml.findElements('cbc:BaseAmount').singleOrNull),
      accountingCostCode: AccountingCostCode.fromXml(xml.findElements('cbc:AccountingCostCode').singleOrNull),
      accountingCost: AccountingCost.fromXml(xml.findElements('cbc:AccountingCost').singleOrNull),
      perUnitAmount: PerUnitAmount.fromXml(xml.findElements('cbc:PerUnitAmount').singleOrNull),
      taxCategory: xml.findElements('cac:TaxCategory').map((XmlElement e) => TaxCategory.fromXml(e)!).toList(),
      taxTotal: TaxTotal.fromXml(xml.findElements('cac:TaxTotal').singleOrNull),
      paymentMeans: xml.findElements('cac:PaymentMeans').map((XmlElement e) => PaymentMeans.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      chargeIndicator.toXml(),
      allowanceChargeReasonCode?.toXml(),
      ...allowanceChargeReason.map((AllowanceChargeReason e) => e.toXml()).toList(),
      multiplierFactorNumeric?.toXml(),
      prepaidIndicator?.toXml(),
      sequenceNumeric?.toXml(),
      amount.toXml(),
      baseAmount?.toXml(),
      accountingCostCode?.toXml(),
      accountingCost?.toXml(),
      perUnitAmount?.toXml(),
      ...taxCategory.map((TaxCategory e) => e.toXml()).toList(),
      taxTotal?.toXml(),
      ...paymentMeans.map((PaymentMeans e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'FreightAllowanceCharge',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

