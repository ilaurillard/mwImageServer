// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Description.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cac/AppliedSecurityMeasure.dart';
import '../cac/Period.dart';
import '../cac/Location.dart';

// A class to describe a ship to ship activity record.
class ShipToShipActivityRecord {


  // A text describing the ship to ship activity.
  final List<Description> description;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An indentifier for this ship to ship activity.
  final ID? iD;

  // Any security measures applied to this ship to ship activity in lieu of those specified in the approved Ship Security Plan (SSP).
  final List<AppliedSecurityMeasure> appliedSecurityMeasure;

  // The duration of this ship to ship activity.
  final Period? period;

  // The location where this ship to ship activity took place.
  final Location? location;

  ShipToShipActivityRecord ({
    required this.description,
    this.uBLExtensions,
    this.iD,
    this.appliedSecurityMeasure = const [],
    this.period,
    this.location,
  }) {
    if (description.isEmpty) { throw Exception('empty description given'); }
  }

  static ShipToShipActivityRecord? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ShipToShipActivityRecord (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      appliedSecurityMeasure: (json['appliedSecurityMeasure'] as List? ?? []).map((dynamic d) => AppliedSecurityMeasure.fromJson(d as Map<String, dynamic>?)!).toList(),
      period: Period.fromJson(json['period'] as Map<String, dynamic>?),
      location: Location.fromJson(json['location'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'appliedSecurityMeasure': appliedSecurityMeasure.map((e) => e.toJson()).toList(),
      'period': period?.toJson(),
      'location': location?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ShipToShipActivityRecord? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ShipToShipActivityRecord (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      appliedSecurityMeasure: xml.findElements('cac:AppliedSecurityMeasure').map((XmlElement e) => AppliedSecurityMeasure.fromXml(e)!).toList(),
      period: Period.fromXml(xml.findElements('cac:Period').singleOrNull),
      location: Location.fromXml(xml.findElements('cac:Location').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      ...description.map((Description e) => e.toXml()),
      ...appliedSecurityMeasure.map((AppliedSecurityMeasure e) => e.toXml()),
      period?.toXml(),
      location?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ShipToShipActivityRecord',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

