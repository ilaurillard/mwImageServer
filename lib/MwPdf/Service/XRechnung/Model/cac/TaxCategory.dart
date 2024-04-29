import 'dart:convert';
import '../../Etc/Util.dart';
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
class TaxCategory {


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

  TaxCategory ({
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


  TaxCategory fromJson(Map<String, dynamic> json) {
    return TaxCategory (
    );
  }

}

