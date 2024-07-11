// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/SecurityLevelCode.dart';
import '../cac/SecurityMeasure.dart';
import '../cac/PortFacilityLocation.dart';
import '../cac/Period.dart';

// A record for a ship call at a port facility.
class PortCallRecord {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this port call record.
  final ID? iD;

  // A code describing the security level of the port facility call record.
  final SecurityLevelCode? securityLevelCode;

  // One or more security measures applied to this port call record.
  final List<SecurityMeasure> securityMeasure;

  // The location of the port facility.
  final PortFacilityLocation? portFacilityLocation;

  // The period when this port call took place.
  final Period? period;

  PortCallRecord ({
    this.uBLExtensions,
    this.iD,
    this.securityLevelCode,
    this.securityMeasure = const [],
    this.portFacilityLocation,
    this.period,
  });

  static PortCallRecord? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PortCallRecord (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      securityLevelCode: SecurityLevelCode.fromJson(json['securityLevelCode'] as Map<String, dynamic>?),
      securityMeasure: (json['securityMeasure'] as List? ?? []).map((dynamic d) => SecurityMeasure.fromJson(d as Map<String, dynamic>?)!).toList(),
      portFacilityLocation: PortFacilityLocation.fromJson(json['portFacilityLocation'] as Map<String, dynamic>?),
      period: Period.fromJson(json['period'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'securityLevelCode': securityLevelCode?.toJson(),
      'securityMeasure': securityMeasure.map((e) => e.toJson()).toList(),
      'portFacilityLocation': portFacilityLocation?.toJson(),
      'period': period?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PortCallRecord? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PortCallRecord (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      securityLevelCode: SecurityLevelCode.fromXml(xml.findElements('cbc:SecurityLevelCode').singleOrNull),
      securityMeasure: xml.findElements('cac:SecurityMeasure').map((XmlElement e) => SecurityMeasure.fromXml(e)!).toList(),
      portFacilityLocation: PortFacilityLocation.fromXml(xml.findElements('cac:PortFacilityLocation').singleOrNull),
      period: Period.fromXml(xml.findElements('cac:Period').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      securityLevelCode?.toXml(),
      ...securityMeasure.map((SecurityMeasure e) => e.toXml()),
      portFacilityLocation?.toXml(),
      period?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PortCallRecord',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

