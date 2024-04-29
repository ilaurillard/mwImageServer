import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/CorporateRegistrationTypeCode.dart';
import '../cac/JurisdictionRegionAddress.dart';

// A class to describe a scheme for corporate registration.
class CorporateRegistrationScheme {


  // An identifier for this registration scheme.
  final ID? iD;

  // The name of this registration scheme.
  final Name? name;

  // A code signifying the type of this registration scheme.
  final CorporateRegistrationTypeCode? corporateRegistrationTypeCode;

  // A geographic area in which this registration scheme applies.
  final List<JurisdictionRegionAddress> jurisdictionRegionAddress;

  CorporateRegistrationScheme ({
    this.iD,
    this.name,
    this.corporateRegistrationTypeCode,
    this.jurisdictionRegionAddress = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'corporateRegistrationTypeCode': corporateRegistrationTypeCode?.toJson(),
      'jurisdictionRegionAddress': jurisdictionRegionAddress.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CorporateRegistrationScheme? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CorporateRegistrationScheme (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      corporateRegistrationTypeCode: CorporateRegistrationTypeCode.fromJson(json['corporateRegistrationTypeCode'] as Map<String, dynamic>?),
      jurisdictionRegionAddress: (json['jurisdictionRegionAddress'] as List? ?? []).map((dynamic d) => JurisdictionRegionAddress.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static CorporateRegistrationScheme? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return CorporateRegistrationScheme (
      iD: null,
      name: null,
      corporateRegistrationTypeCode: null,
      jurisdictionRegionAddress: null,
    );
  }

}

