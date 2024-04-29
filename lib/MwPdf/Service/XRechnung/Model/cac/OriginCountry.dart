import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/IdentificationCode.dart';
import '../cbc/Name.dart';

// A class to describe a country.
class OriginCountry {


  // A code signifying this country.
  final IdentificationCode? identificationCode;

  // The name of this country.
  final Name? name;

  OriginCountry ({
    this.identificationCode,
    this.name,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'identificationCode': identificationCode?.toJson(),
      'name': name?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OriginCountry? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OriginCountry (
      identificationCode: IdentificationCode.fromJson(json['identificationCode'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
    );
  }

  static OriginCountry? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return OriginCountry (
      identificationCode: null,
      name: null,
    );
  }

}

