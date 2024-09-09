// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A character string to identify and uniquely distinguish one instance of an object in an identification scheme from all other objects in the same scheme, together with relevant supplementary information.
class UBLVersionID {

  final String value; // (normalizedString)

  // The identification of the identification scheme.
  final String? schemeID; // (normalizedString)

  // The name of the identification scheme.
  final String? schemeName; // (string)

  // The identification of the agency that maintains the identification scheme.
  final String? schemeAgencyID; // (normalizedString)

  // The name of the agency that maintains the identification scheme.
  final String? schemeAgencyName; // (string)

  // The version of the identification scheme.
  final String? schemeVersionID; // (normalizedString)

  // The Uniform Resource Identifier that identifies where the identification scheme data is located.
  final String? schemeDataURI; // (anyURI)

  // The Uniform Resource Identifier that identifies where the identification scheme is located.
  final String? schemeURI; // (anyURI)

  UBLVersionID ({
    required this.value,
    this.schemeID,
    this.schemeName,
    this.schemeAgencyID,
    this.schemeAgencyName,
    this.schemeVersionID,
    this.schemeDataURI,
    this.schemeURI,
  }) {
    if (value.isEmpty) { throw Exception('empty value given'); }
  }

  static UBLVersionID? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return UBLVersionID (
      value: json['value'] as String? ?? '',
      schemeID: json['schemeID'] as String?,
      schemeName: json['schemeName'] as String?,
      schemeAgencyID: json['schemeAgencyID'] as String?,
      schemeAgencyName: json['schemeAgencyName'] as String?,
      schemeVersionID: json['schemeVersionID'] as String?,
      schemeDataURI: json['schemeDataURI'] as String?,
      schemeURI: json['schemeURI'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
      'schemeID': schemeID?.toString(),
      'schemeName': schemeName?.toString(),
      'schemeAgencyID': schemeAgencyID?.toString(),
      'schemeAgencyName': schemeAgencyName?.toString(),
      'schemeVersionID': schemeVersionID?.toString(),
      'schemeDataURI': schemeDataURI?.toString(),
      'schemeURI': schemeURI?.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static UBLVersionID? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return UBLVersionID (
      value: xml.innerText,
      schemeID: xml.getAttribute('schemeID'),
      schemeName: xml.getAttribute('schemeName'),
      schemeAgencyID: xml.getAttribute('schemeAgencyID'),
      schemeAgencyName: xml.getAttribute('schemeAgencyName'),
      schemeVersionID: xml.getAttribute('schemeVersionID'),
      schemeDataURI: xml.getAttribute('schemeDataURI'),
      schemeURI: xml.getAttribute('schemeURI'),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [

      schemeID != null ? XmlAttribute(XmlName('schemeID'), schemeID.toString(),) : null,
      schemeName != null ? XmlAttribute(XmlName('schemeName'), schemeName.toString(),) : null,
      schemeAgencyID != null ? XmlAttribute(XmlName('schemeAgencyID'), schemeAgencyID.toString(),) : null,
      schemeAgencyName != null ? XmlAttribute(XmlName('schemeAgencyName'), schemeAgencyName.toString(),) : null,
      schemeVersionID != null ? XmlAttribute(XmlName('schemeVersionID'), schemeVersionID.toString(),) : null,
      schemeDataURI != null ? XmlAttribute(XmlName('schemeDataURI'), schemeDataURI.toString(),) : null,
      schemeURI != null ? XmlAttribute(XmlName('schemeURI'), schemeURI.toString(),) : null,

    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'UBLVersionID',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

