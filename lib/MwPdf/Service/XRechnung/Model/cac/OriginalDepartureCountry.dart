// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/IdentificationCode.dart';
import '../cbc/Name.dart';

// A class to describe a country.
class OriginalDepartureCountry {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code signifying this country.
  final IdentificationCode? identificationCode;

  // The name of this country.
  final Name? name;

  OriginalDepartureCountry ({
    this.uBLExtensions,
    this.identificationCode,
    this.name,
  });

  static OriginalDepartureCountry? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OriginalDepartureCountry (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      identificationCode: IdentificationCode.fromJson(json['identificationCode'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'identificationCode': identificationCode?.toJson(),
      'name': name?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OriginalDepartureCountry? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OriginalDepartureCountry (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      identificationCode: IdentificationCode.fromXml(xml.findElements('cbc:IdentificationCode').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      identificationCode?.toXml(),
      name?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OriginalDepartureCountry',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

