import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PayableAmount.dart';
import '../cbc/LineExtensionAmount.dart';
import '../cbc/TaxExclusiveAmount.dart';
import '../cbc/TaxInclusiveAmount.dart';
import '../cbc/AllowanceTotalAmount.dart';
import '../cbc/ChargeTotalAmount.dart';
import '../cbc/PrepaidAmount.dart';
import '../cbc/PayableRoundingAmount.dart';
import '../cbc/PayableAlternativeAmount.dart';

// A class to define a monetary total.
class LegalMonetaryTotal {


  // The amount of the monetary total to be paid.
  final PayableAmount payableAmount;

  // The monetary amount of an extended transaction line, net of tax and settlement discounts, but inclusive of any applicable rounding amount.
  final LineExtensionAmount? lineExtensionAmount;

  // The monetary amount of an extended transaction line, exclusive of taxes.
  final TaxExclusiveAmount? taxExclusiveAmount;

  // The monetary amount including taxes; the sum of payable amount and prepaid amount.
  final TaxInclusiveAmount? taxInclusiveAmount;

  // The total monetary amount of all allowances.
  final AllowanceTotalAmount? allowanceTotalAmount;

  // The total monetary amount of all charges.
  final ChargeTotalAmount? chargeTotalAmount;

  // The total prepaid monetary amount.
  final PrepaidAmount? prepaidAmount;

  // The rounding amount (positive or negative) added to produce the line extension amount.
  final PayableRoundingAmount? payableRoundingAmount;

  // The amount of the monetary total to be paid, expressed in an alternative currency.
  final PayableAlternativeAmount? payableAlternativeAmount;

  LegalMonetaryTotal ({
    required this.payableAmount,
    this.lineExtensionAmount,
    this.taxExclusiveAmount,
    this.taxInclusiveAmount,
    this.allowanceTotalAmount,
    this.chargeTotalAmount,
    this.prepaidAmount,
    this.payableRoundingAmount,
    this.payableAlternativeAmount,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'lineExtensionAmount': lineExtensionAmount?.toJson(),
      'taxExclusiveAmount': taxExclusiveAmount?.toJson(),
      'taxInclusiveAmount': taxInclusiveAmount?.toJson(),
      'allowanceTotalAmount': allowanceTotalAmount?.toJson(),
      'chargeTotalAmount': chargeTotalAmount?.toJson(),
      'prepaidAmount': prepaidAmount?.toJson(),
      'payableRoundingAmount': payableRoundingAmount?.toJson(),
      'payableAmount': payableAmount.toJson(),
      'payableAlternativeAmount': payableAlternativeAmount?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LegalMonetaryTotal? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LegalMonetaryTotal (
      lineExtensionAmount: LineExtensionAmount.fromJson(json['lineExtensionAmount'] as Map<String, dynamic>?),
      taxExclusiveAmount: TaxExclusiveAmount.fromJson(json['taxExclusiveAmount'] as Map<String, dynamic>?),
      taxInclusiveAmount: TaxInclusiveAmount.fromJson(json['taxInclusiveAmount'] as Map<String, dynamic>?),
      allowanceTotalAmount: AllowanceTotalAmount.fromJson(json['allowanceTotalAmount'] as Map<String, dynamic>?),
      chargeTotalAmount: ChargeTotalAmount.fromJson(json['chargeTotalAmount'] as Map<String, dynamic>?),
      prepaidAmount: PrepaidAmount.fromJson(json['prepaidAmount'] as Map<String, dynamic>?),
      payableRoundingAmount: PayableRoundingAmount.fromJson(json['payableRoundingAmount'] as Map<String, dynamic>?),
      payableAmount: PayableAmount.fromJson(json['payableAmount'] as Map<String, dynamic>?)!,
      payableAlternativeAmount: PayableAlternativeAmount.fromJson(json['payableAlternativeAmount'] as Map<String, dynamic>?),
    );
  }

  static LegalMonetaryTotal? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return LegalMonetaryTotal (
      lineExtensionAmount: null,
      taxExclusiveAmount: null,
      taxInclusiveAmount: null,
      allowanceTotalAmount: null,
      chargeTotalAmount: null,
      prepaidAmount: null,
      payableRoundingAmount: null,
      payableAmount: null,
      payableAlternativeAmount: null,
    );
  }

}

