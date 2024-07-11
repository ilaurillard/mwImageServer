// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cac/OriginalItemLocationQuantity.dart';
import '../cac/AlternativeConditionPrice.dart';

// A reference to the basis for pricing. This may be based on a catalogue or a quoted amount from a price list and include some alternative pricing conditions.
class PricingReference {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An original set of location-specific properties (e.g., price and quantity) associated with this item.
  final OriginalItemLocationQuantity? originalItemLocationQuantity;

  // The price expressed in terms other than the actual price, e.g., the list price v. the contracted price, or the price in bags v. the price in kilos, or the list price in bags v. the contracted price in kilos.
  final List<AlternativeConditionPrice> alternativeConditionPrice;

  PricingReference ({
    this.uBLExtensions,
    this.originalItemLocationQuantity,
    this.alternativeConditionPrice = const [],
  });

  static PricingReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PricingReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      originalItemLocationQuantity: OriginalItemLocationQuantity.fromJson(json['originalItemLocationQuantity'] as Map<String, dynamic>?),
      alternativeConditionPrice: (json['alternativeConditionPrice'] as List? ?? []).map((dynamic d) => AlternativeConditionPrice.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'originalItemLocationQuantity': originalItemLocationQuantity?.toJson(),
      'alternativeConditionPrice': alternativeConditionPrice.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PricingReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PricingReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      originalItemLocationQuantity: OriginalItemLocationQuantity.fromXml(xml.findElements('cac:OriginalItemLocationQuantity').singleOrNull),
      alternativeConditionPrice: xml.findElements('cac:AlternativeConditionPrice').map((XmlElement e) => AlternativeConditionPrice.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      originalItemLocationQuantity?.toXml(),
      ...alternativeConditionPrice.map((AlternativeConditionPrice e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PricingReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

