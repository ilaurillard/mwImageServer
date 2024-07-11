// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/TaxAmount.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CalculationSequenceNumeric.dart';
import '../cbc/RoundingAmount.dart';
import '../cbc/TaxEvidenceIndicator.dart';
import '../cbc/TaxIncludedIndicator.dart';
import '../cac/TaxSubtotal.dart';

// A class to describe the total tax for a particular taxation scheme.
class TaxTotal {


  // The total tax amount for a particular taxation scheme, e.g., VAT; the sum of the tax subtotals for each tax category within the taxation scheme.
  final TaxAmount taxAmount;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The number of this tax total in the sequence of tax totals corresponding to the order in which multiple taxes are applied. If all taxes are applied to the same taxable amount (i.e., their order of application is inconsequential), then CalculationSequenceNumeric is 1 for all tax totals applied to a given amount.
  final CalculationSequenceNumeric? calculationSequenceNumeric;

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
    this.uBLExtensions,
    this.calculationSequenceNumeric,
    this.roundingAmount,
    this.taxEvidenceIndicator,
    this.taxIncludedIndicator,
    this.taxSubtotal = const [],
  });

  static TaxTotal? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TaxTotal (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      taxAmount: TaxAmount.fromJson(json['taxAmount'] as Map<String, dynamic>?)!,
      calculationSequenceNumeric: CalculationSequenceNumeric.fromJson(json['calculationSequenceNumeric'] as Map<String, dynamic>?),
      roundingAmount: RoundingAmount.fromJson(json['roundingAmount'] as Map<String, dynamic>?),
      taxEvidenceIndicator: TaxEvidenceIndicator.fromJson(json['taxEvidenceIndicator'] as Map<String, dynamic>?),
      taxIncludedIndicator: TaxIncludedIndicator.fromJson(json['taxIncludedIndicator'] as Map<String, dynamic>?),
      taxSubtotal: (json['taxSubtotal'] as List? ?? []).map((dynamic d) => TaxSubtotal.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'taxAmount': taxAmount.toJson(),
      'calculationSequenceNumeric': calculationSequenceNumeric?.toJson(),
      'roundingAmount': roundingAmount?.toJson(),
      'taxEvidenceIndicator': taxEvidenceIndicator?.toJson(),
      'taxIncludedIndicator': taxIncludedIndicator?.toJson(),
      'taxSubtotal': taxSubtotal.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TaxTotal? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TaxTotal (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      taxAmount: TaxAmount.fromXml(xml.findElements('cbc:TaxAmount').singleOrNull)!,
      calculationSequenceNumeric: CalculationSequenceNumeric.fromXml(xml.findElements('cbc:CalculationSequenceNumeric').singleOrNull),
      roundingAmount: RoundingAmount.fromXml(xml.findElements('cbc:RoundingAmount').singleOrNull),
      taxEvidenceIndicator: TaxEvidenceIndicator.fromXml(xml.findElements('cbc:TaxEvidenceIndicator').singleOrNull),
      taxIncludedIndicator: TaxIncludedIndicator.fromXml(xml.findElements('cbc:TaxIncludedIndicator').singleOrNull),
      taxSubtotal: xml.findElements('cac:TaxSubtotal').map((XmlElement e) => TaxSubtotal.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      taxAmount.toXml(),
      calculationSequenceNumeric?.toXml(),
      roundingAmount?.toXml(),
      taxEvidenceIndicator?.toXml(),
      taxIncludedIndicator?.toXml(),
      ...taxSubtotal.map((TaxSubtotal e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TaxTotal',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

