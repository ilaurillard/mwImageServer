import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/LeadTimeMeasure.dart';
import '../cbc/MinimumQuantity.dart';
import '../cbc/MaximumQuantity.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/TradingRestrictions.dart';
import '../cac/ApplicableTerritoryAddress.dart';
import '../cac/Price.dart';
import '../cac/DeliveryUnit.dart';
import '../cac/ApplicableTaxCategory.dart';
import '../cac/Package.dart';
import '../cac/AllowanceCharge.dart';
import '../cac/DependentPriceReference.dart';

// A class for information about pricing structure, lead time, and location associated with an item.
class OriginalItemLocationQuantity {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The lead time, i.e., the time taken from the time at which an item is ordered to the time of its delivery.
  final LeadTimeMeasure? leadTimeMeasure;

  // The minimum quantity that can be ordered to qualify for a specific price.
  final MinimumQuantity? minimumQuantity;

  // The maximum quantity that can be ordered to qualify for a specific price.
  final MaximumQuantity? maximumQuantity;

  // An indication that the transported item, as delivered, in the stated quantity to the stated location, is subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // Text describing trade restrictions on the quantity of this item or on the item itself.
  final List<TradingRestrictions> tradingRestrictions;

  // The applicable sales territory.
  final List<ApplicableTerritoryAddress> applicableTerritoryAddress;

  // The price associated with the given location.
  final Price? price;

  // A delivery unit in which the item is located.
  final List<DeliveryUnit> deliveryUnit;

  // A tax category applicable to this item location quantity.
  final List<ApplicableTaxCategory> applicableTaxCategory;

  // The package to which this price applies.
  final Package? package;

  // An allowance or charge associated with this item location quantity.
  final List<AllowanceCharge> allowanceCharge;

  // The price of the item as a percentage of the price of some other item.
  final DependentPriceReference? dependentPriceReference;

  OriginalItemLocationQuantity ({
    this.uBLExtensions,
    this.leadTimeMeasure,
    this.minimumQuantity,
    this.maximumQuantity,
    this.hazardousRiskIndicator,
    this.tradingRestrictions = const [],
    this.applicableTerritoryAddress = const [],
    this.price,
    this.deliveryUnit = const [],
    this.applicableTaxCategory = const [],
    this.package,
    this.allowanceCharge = const [],
    this.dependentPriceReference,
  });

  static OriginalItemLocationQuantity? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OriginalItemLocationQuantity (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      leadTimeMeasure: LeadTimeMeasure.fromJson(json['leadTimeMeasure'] as Map<String, dynamic>?),
      minimumQuantity: MinimumQuantity.fromJson(json['minimumQuantity'] as Map<String, dynamic>?),
      maximumQuantity: MaximumQuantity.fromJson(json['maximumQuantity'] as Map<String, dynamic>?),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
      tradingRestrictions: (json['tradingRestrictions'] as List? ?? []).map((dynamic d) => TradingRestrictions.fromJson(d as Map<String, dynamic>?)!).toList(),
      applicableTerritoryAddress: (json['applicableTerritoryAddress'] as List? ?? []).map((dynamic d) => ApplicableTerritoryAddress.fromJson(d as Map<String, dynamic>?)!).toList(),
      price: Price.fromJson(json['price'] as Map<String, dynamic>?),
      deliveryUnit: (json['deliveryUnit'] as List? ?? []).map((dynamic d) => DeliveryUnit.fromJson(d as Map<String, dynamic>?)!).toList(),
      applicableTaxCategory: (json['applicableTaxCategory'] as List? ?? []).map((dynamic d) => ApplicableTaxCategory.fromJson(d as Map<String, dynamic>?)!).toList(),
      package: Package.fromJson(json['package'] as Map<String, dynamic>?),
      allowanceCharge: (json['allowanceCharge'] as List? ?? []).map((dynamic d) => AllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      dependentPriceReference: DependentPriceReference.fromJson(json['dependentPriceReference'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'leadTimeMeasure': leadTimeMeasure?.toJson(),
      'minimumQuantity': minimumQuantity?.toJson(),
      'maximumQuantity': maximumQuantity?.toJson(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
      'tradingRestrictions': tradingRestrictions.map((e) => e.toJson()).toList(),
      'applicableTerritoryAddress': applicableTerritoryAddress.map((e) => e.toJson()).toList(),
      'price': price?.toJson(),
      'deliveryUnit': deliveryUnit.map((e) => e.toJson()).toList(),
      'applicableTaxCategory': applicableTaxCategory.map((e) => e.toJson()).toList(),
      'package': package?.toJson(),
      'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
      'dependentPriceReference': dependentPriceReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OriginalItemLocationQuantity? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OriginalItemLocationQuantity (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      leadTimeMeasure: LeadTimeMeasure.fromXml(xml.findElements('cbc:LeadTimeMeasure').singleOrNull),
      minimumQuantity: MinimumQuantity.fromXml(xml.findElements('cbc:MinimumQuantity').singleOrNull),
      maximumQuantity: MaximumQuantity.fromXml(xml.findElements('cbc:MaximumQuantity').singleOrNull),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
      tradingRestrictions: xml.findElements('cbc:TradingRestrictions').map((XmlElement e) => TradingRestrictions.fromXml(e)!).toList(),
      applicableTerritoryAddress: xml.findElements('cac:ApplicableTerritoryAddress').map((XmlElement e) => ApplicableTerritoryAddress.fromXml(e)!).toList(),
      price: Price.fromXml(xml.findElements('cac:Price').singleOrNull),
      deliveryUnit: xml.findElements('cac:DeliveryUnit').map((XmlElement e) => DeliveryUnit.fromXml(e)!).toList(),
      applicableTaxCategory: xml.findElements('cac:ApplicableTaxCategory').map((XmlElement e) => ApplicableTaxCategory.fromXml(e)!).toList(),
      package: Package.fromXml(xml.findElements('cac:Package').singleOrNull),
      allowanceCharge: xml.findElements('cac:AllowanceCharge').map((XmlElement e) => AllowanceCharge.fromXml(e)!).toList(),
      dependentPriceReference: DependentPriceReference.fromXml(xml.findElements('cac:DependentPriceReference').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      leadTimeMeasure?.toXml(),
      minimumQuantity?.toXml(),
      maximumQuantity?.toXml(),
      hazardousRiskIndicator?.toXml(),
      ...tradingRestrictions.map((TradingRestrictions e) => e.toXml()).toList(),
      ...applicableTerritoryAddress.map((ApplicableTerritoryAddress e) => e.toXml()).toList(),
      price?.toXml(),
      ...deliveryUnit.map((DeliveryUnit e) => e.toXml()).toList(),
      ...applicableTaxCategory.map((ApplicableTaxCategory e) => e.toXml()).toList(),
      package?.toXml(),
      ...allowanceCharge.map((AllowanceCharge e) => e.toXml()).toList(),
      dependentPriceReference?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OriginalItemLocationQuantity',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

