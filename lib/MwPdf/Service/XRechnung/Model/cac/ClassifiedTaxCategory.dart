import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/TaxScheme.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/Percent.dart';
import '../cbc/BaseUnitMeasure.dart';
import '../cbc/PerUnitAmount.dart';
import '../cbc/TaxExemptionReasonCode.dart';
import '../cbc/TaxExemptionReason.dart';
import '../cbc/TierRange.dart';
import '../cbc/TierRatePercent.dart';

// A class to describe one of the tax categories within a taxation scheme (e.g., High Rate VAT, Low Rate VAT).
class ClassifiedTaxCategory {


  // The taxation scheme within which this tax category is defined.
  final TaxScheme taxScheme;

  // An identifier for this tax category.
  final ID? iD;

  // The name of this tax category.
  final Name? name;

  // The tax rate for this category, expressed as a percentage.
  final Percent? percent;

  // A Unit of Measures used as the basic for the tax calculation applied at a certain rate per unit.
  final BaseUnitMeasure? baseUnitMeasure;

  // Where a tax is applied at a certain rate per unit, the rate per unit applied.
  final PerUnitAmount? perUnitAmount;

  // The reason for tax being exempted, expressed as a code.
  final TaxExemptionReasonCode? taxExemptionReasonCode;

  // The reason for tax being exempted, expressed as text.
  final List<TaxExemptionReason> taxExemptionReason;

  // Where a tax is tiered, the range of taxable amounts that determines the rate of tax applicable to this tax category.
  final TierRange? tierRange;

  // Where a tax is tiered, the tax rate that applies within the specified range of taxable amounts for this tax category.
  final TierRatePercent? tierRatePercent;

  ClassifiedTaxCategory ({
    required this.taxScheme,
    this.iD,
    this.name,
    this.percent,
    this.baseUnitMeasure,
    this.perUnitAmount,
    this.taxExemptionReasonCode,
    this.taxExemptionReason = const [],
    this.tierRange,
    this.tierRatePercent,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'percent': percent?.toJson(),
      'baseUnitMeasure': baseUnitMeasure?.toJson(),
      'perUnitAmount': perUnitAmount?.toJson(),
      'taxExemptionReasonCode': taxExemptionReasonCode?.toJson(),
      'taxExemptionReason': taxExemptionReason.map((e) => e.toJson()).toList(),
      'tierRange': tierRange?.toJson(),
      'tierRatePercent': tierRatePercent?.toJson(),
      'taxScheme': taxScheme.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ClassifiedTaxCategory? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ClassifiedTaxCategory (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      percent: Percent.fromJson(json['percent'] as Map<String, dynamic>?),
      baseUnitMeasure: BaseUnitMeasure.fromJson(json['baseUnitMeasure'] as Map<String, dynamic>?),
      perUnitAmount: PerUnitAmount.fromJson(json['perUnitAmount'] as Map<String, dynamic>?),
      taxExemptionReasonCode: TaxExemptionReasonCode.fromJson(json['taxExemptionReasonCode'] as Map<String, dynamic>?),
      taxExemptionReason: (json['taxExemptionReason'] as List? ?? []).map((dynamic d) => TaxExemptionReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      tierRange: TierRange.fromJson(json['tierRange'] as Map<String, dynamic>?),
      tierRatePercent: TierRatePercent.fromJson(json['tierRatePercent'] as Map<String, dynamic>?),
      taxScheme: TaxScheme.fromJson(json['taxScheme'] as Map<String, dynamic>?)!,
    );
  }

  static ClassifiedTaxCategory? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ClassifiedTaxCategory (
      iD: null,
      name: null,
      percent: null,
      baseUnitMeasure: null,
      perUnitAmount: null,
      taxExemptionReasonCode: null,
      taxExemptionReason: null,
      tierRange: null,
      tierRatePercent: null,
      taxScheme: null,
    );
  }

}

