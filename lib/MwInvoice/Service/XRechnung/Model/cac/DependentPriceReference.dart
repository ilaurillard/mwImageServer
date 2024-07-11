// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Percent.dart';
import '../cac/LocationAddress.dart';
import '../cac/DependentLineReference.dart';

// A class to define the price of an item as a percentage of the price of a different item.
class DependentPriceReference {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The percentage by which the price of the different item is multiplied to calculate the price of the item.
  final Percent? percent;

  // The reference location for this dependent price reference.
  final LocationAddress? locationAddress;

  // A reference to a line that the price is depended of.
  final DependentLineReference? dependentLineReference;

  DependentPriceReference ({
    this.uBLExtensions,
    this.percent,
    this.locationAddress,
    this.dependentLineReference,
  });

  static DependentPriceReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DependentPriceReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      percent: Percent.fromJson(json['percent'] as Map<String, dynamic>?),
      locationAddress: LocationAddress.fromJson(json['locationAddress'] as Map<String, dynamic>?),
      dependentLineReference: DependentLineReference.fromJson(json['dependentLineReference'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'percent': percent?.toJson(),
      'locationAddress': locationAddress?.toJson(),
      'dependentLineReference': dependentLineReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DependentPriceReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DependentPriceReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      percent: Percent.fromXml(xml.findElements('cbc:Percent').singleOrNull),
      locationAddress: LocationAddress.fromXml(xml.findElements('cac:LocationAddress').singleOrNull),
      dependentLineReference: DependentLineReference.fromXml(xml.findElements('cac:DependentLineReference').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      percent?.toXml(),
      locationAddress?.toXml(),
      dependentLineReference?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DependentPriceReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

