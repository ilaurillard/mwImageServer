import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/TaxAmount.dart';
import '../cac/TaxCategory.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/TaxableAmount.dart';
import '../cbc/CalculationSequenceNumeric.dart';
import '../cbc/TransactionCurrencyTaxAmount.dart';
import '../cbc/Percent.dart';
import '../cbc/BaseUnitMeasure.dart';
import '../cbc/PerUnitAmount.dart';
import '../cbc/TierRange.dart';
import '../cbc/TierRatePercent.dart';

// A class to define the subtotal for a particular tax category within a particular taxation scheme, such as standard rate within VAT.
class TaxSubtotal {


  // The amount of this tax subtotal.
  final TaxAmount taxAmount;

  // The tax category applicable to this subtotal.
  final TaxCategory taxCategory;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The net amount to which the tax percent (rate) is applied to calculate the tax amount.
  final TaxableAmount? taxableAmount;

  // The number of this tax subtotal in the sequence of subtotals corresponding to the order in which multiple taxes are applied. If all taxes are applied to the same taxable amount (i.e., their order of application is inconsequential), then CalculationSequenceNumeric is 1 for all tax subtotals applied to a given amount.
  final CalculationSequenceNumeric? calculationSequenceNumeric;

  // The amount of this tax subtotal, expressed in the currency used for invoicing.
  final TransactionCurrencyTaxAmount? transactionCurrencyTaxAmount;

  // The tax rate of the tax category applied to this tax subtotal, expressed as a percentage.
  final Percent? percent;

  // The unit of measure on which the tax calculation is based
  final BaseUnitMeasure? baseUnitMeasure;

  // Where a tax is applied at a certain rate per unit, the rate per unit applied.
  final PerUnitAmount? perUnitAmount;

  // Where a tax is tiered, the range of taxable amounts that determines the rate of tax applicable to this tax subtotal.
  final TierRange? tierRange;

  // Where a tax is tiered, the tax rate that applies within a specified range of taxable amounts for this tax subtotal.
  final TierRatePercent? tierRatePercent;

  TaxSubtotal ({
    required this.taxAmount,
    required this.taxCategory,
    this.uBLExtensions,
    this.taxableAmount,
    this.calculationSequenceNumeric,
    this.transactionCurrencyTaxAmount,
    this.percent,
    this.baseUnitMeasure,
    this.perUnitAmount,
    this.tierRange,
    this.tierRatePercent,
  });

  static TaxSubtotal? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TaxSubtotal (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      taxableAmount: TaxableAmount.fromJson(json['taxableAmount'] as Map<String, dynamic>?),
      taxAmount: TaxAmount.fromJson(json['taxAmount'] as Map<String, dynamic>?)!,
      calculationSequenceNumeric: CalculationSequenceNumeric.fromJson(json['calculationSequenceNumeric'] as Map<String, dynamic>?),
      transactionCurrencyTaxAmount: TransactionCurrencyTaxAmount.fromJson(json['transactionCurrencyTaxAmount'] as Map<String, dynamic>?),
      percent: Percent.fromJson(json['percent'] as Map<String, dynamic>?),
      baseUnitMeasure: BaseUnitMeasure.fromJson(json['baseUnitMeasure'] as Map<String, dynamic>?),
      perUnitAmount: PerUnitAmount.fromJson(json['perUnitAmount'] as Map<String, dynamic>?),
      tierRange: TierRange.fromJson(json['tierRange'] as Map<String, dynamic>?),
      tierRatePercent: TierRatePercent.fromJson(json['tierRatePercent'] as Map<String, dynamic>?),
      taxCategory: TaxCategory.fromJson(json['taxCategory'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'taxableAmount': taxableAmount?.toJson(),
      'taxAmount': taxAmount.toJson(),
      'calculationSequenceNumeric': calculationSequenceNumeric?.toJson(),
      'transactionCurrencyTaxAmount': transactionCurrencyTaxAmount?.toJson(),
      'percent': percent?.toJson(),
      'baseUnitMeasure': baseUnitMeasure?.toJson(),
      'perUnitAmount': perUnitAmount?.toJson(),
      'tierRange': tierRange?.toJson(),
      'tierRatePercent': tierRatePercent?.toJson(),
      'taxCategory': taxCategory.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TaxSubtotal? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TaxSubtotal (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      taxableAmount: TaxableAmount.fromXml(xml.findElements('cbc:TaxableAmount').singleOrNull),
      taxAmount: TaxAmount.fromXml(xml.findElements('cbc:TaxAmount').singleOrNull)!,
      calculationSequenceNumeric: CalculationSequenceNumeric.fromXml(xml.findElements('cbc:CalculationSequenceNumeric').singleOrNull),
      transactionCurrencyTaxAmount: TransactionCurrencyTaxAmount.fromXml(xml.findElements('cbc:TransactionCurrencyTaxAmount').singleOrNull),
      percent: Percent.fromXml(xml.findElements('cbc:Percent').singleOrNull),
      baseUnitMeasure: BaseUnitMeasure.fromXml(xml.findElements('cbc:BaseUnitMeasure').singleOrNull),
      perUnitAmount: PerUnitAmount.fromXml(xml.findElements('cbc:PerUnitAmount').singleOrNull),
      tierRange: TierRange.fromXml(xml.findElements('cbc:TierRange').singleOrNull),
      tierRatePercent: TierRatePercent.fromXml(xml.findElements('cbc:TierRatePercent').singleOrNull),
      taxCategory: TaxCategory.fromXml(xml.findElements('cac:TaxCategory').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      taxableAmount?.toXml(),
      taxAmount.toXml(),
      calculationSequenceNumeric?.toXml(),
      transactionCurrencyTaxAmount?.toXml(),
      percent?.toXml(),
      baseUnitMeasure?.toXml(),
      perUnitAmount?.toXml(),
      tierRange?.toXml(),
      tierRatePercent?.toXml(),
      taxCategory.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TaxSubtotal',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

