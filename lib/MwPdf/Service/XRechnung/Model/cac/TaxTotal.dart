import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/TaxAmount.dart';
import '../cbc/RoundingAmount.dart';
import '../cbc/TaxEvidenceIndicator.dart';
import '../cbc/TaxIncludedIndicator.dart';
import '../cac/TaxSubtotal.dart';

// A class to describe the total tax for a particular taxation scheme.
class TaxTotal {


  // The total tax amount for a particular taxation scheme, e.g., VAT; the sum of the tax subtotals for each tax category within the taxation scheme.
  final TaxAmount taxAmount;

  // The rounding amount (positive or negative) added to the calculated tax total to produce the rounded TaxAmount.
  final RoundingAmount? roundingAmount;

  // An indicator that this total is recognized as legal evidence for taxation purposes (true) or not (false).
  final TaxEvidenceIndicator? taxEvidenceIndicator;

  // An indicator that tax is included in the calculation (true) or not (false).
  final TaxIncludedIndicator? taxIncludedIndicator;

  // One of the subtotals the sum of which equals the total tax amount for a particular taxation scheme.
  final List<TaxSubtotal> taxSubtotal;

  TaxTotal ({
    required this.taxAmount,
    this.roundingAmount,
    this.taxEvidenceIndicator,
    this.taxIncludedIndicator,
    this.taxSubtotal = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'taxAmount': taxAmount.toJson(),
      'roundingAmount': roundingAmount?.toJson(),
      'taxEvidenceIndicator': taxEvidenceIndicator?.toJson(),
      'taxIncludedIndicator': taxIncludedIndicator?.toJson(),
      'taxSubtotal': taxSubtotal.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TaxTotal? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TaxTotal (
      taxAmount: TaxAmount.fromJson(json['taxAmount'] as Map<String, dynamic>?)!,
      roundingAmount: RoundingAmount.fromJson(json['roundingAmount'] as Map<String, dynamic>?),
      taxEvidenceIndicator: TaxEvidenceIndicator.fromJson(json['taxEvidenceIndicator'] as Map<String, dynamic>?),
      taxIncludedIndicator: TaxIncludedIndicator.fromJson(json['taxIncludedIndicator'] as Map<String, dynamic>?),
      taxSubtotal: (json['taxSubtotal'] as List? ?? []).map((dynamic d) => TaxSubtotal.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static TaxTotal? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return TaxTotal (
      taxAmount: null,
      roundingAmount: null,
      taxEvidenceIndicator: null,
      taxIncludedIndicator: null,
      taxSubtotal: null,
    );
  }

}

