// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/CorporateRegistrationTypeCode.dart';
import '../cac/JurisdictionRegionAddress.dart';

// A class to describe a scheme for corporate registration.
class CorporateRegistrationScheme {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this registration scheme.
  final ID? iD;

  // The name of this registration scheme.
  final Name? name;

  // A code signifying the type of this registration scheme.
  final CorporateRegistrationTypeCode? corporateRegistrationTypeCode;

  // A geographic area in which this registration scheme applies.
  final List<JurisdictionRegionAddress> jurisdictionRegionAddress;

  CorporateRegistrationScheme ({
    this.uBLExtensions,
    this.iD,
    this.name,
    this.corporateRegistrationTypeCode,
    this.jurisdictionRegionAddress = const [],
  });

  static CorporateRegistrationScheme? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CorporateRegistrationScheme (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      corporateRegistrationTypeCode: CorporateRegistrationTypeCode.fromJson(json['corporateRegistrationTypeCode'] as Map<String, dynamic>?),
      jurisdictionRegionAddress: (json['jurisdictionRegionAddress'] as List? ?? []).map((dynamic d) => JurisdictionRegionAddress.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'corporateRegistrationTypeCode': corporateRegistrationTypeCode?.toJson(),
      'jurisdictionRegionAddress': jurisdictionRegionAddress.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CorporateRegistrationScheme? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CorporateRegistrationScheme (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      corporateRegistrationTypeCode: CorporateRegistrationTypeCode.fromXml(xml.findElements('cbc:CorporateRegistrationTypeCode').singleOrNull),
      jurisdictionRegionAddress: xml.findElements('cac:JurisdictionRegionAddress').map((XmlElement e) => JurisdictionRegionAddress.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      name?.toXml(),
      corporateRegistrationTypeCode?.toXml(),
      ...jurisdictionRegionAddress.map((JurisdictionRegionAddress e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'CorporateRegistrationScheme',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

