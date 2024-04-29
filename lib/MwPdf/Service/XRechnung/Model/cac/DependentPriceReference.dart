import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Percent.dart';
import '../cac/LocationAddress.dart';
import '../cac/DependentLineReference.dart';

// A class to define the price of an item as a percentage of the price of a different item.
class DependentPriceReference {


  // The percentage by which the price of the different item is multiplied to calculate the price of the item.
  final Percent? percent;

  // The reference location for this dependent price reference.
  final LocationAddress? locationAddress;

  // A reference to a line that the price is depended of.
  final DependentLineReference? dependentLineReference;

  DependentPriceReference ({
    this.percent,
    this.locationAddress,
    this.dependentLineReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'percent': percent?.toJson(),
      'locationAddress': locationAddress?.toJson(),
      'dependentLineReference': dependentLineReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DependentPriceReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DependentPriceReference (
      percent: Percent.fromJson(json['percent'] as Map<String, dynamic>?),
      locationAddress: LocationAddress.fromJson(json['locationAddress'] as Map<String, dynamic>?),
      dependentLineReference: DependentLineReference.fromJson(json['dependentLineReference'] as Map<String, dynamic>?),
    );
  }

  static DependentPriceReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return DependentPriceReference (
      percent: null,
      locationAddress: null,
      dependentLineReference: null,
    );
  }

}

