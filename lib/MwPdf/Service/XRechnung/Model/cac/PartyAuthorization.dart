import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/PurposeCode.dart';
import '../cbc/Purpose.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/Certificate.dart';

// A class to define an authorization that as been issued
class PartyAuthorization {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code defining the business purpose or scope of this authorization
  final PurposeCode? purposeCode;

  // The purpose or scope of this authorization expressed as a text
  final List<Purpose> purpose;

  // The period during which this authorization is valid
  final ValidityPeriod? validityPeriod;

  // One or more certificates related to this authorization
  final List<Certificate> certificate;

  PartyAuthorization ({
    this.uBLExtensions,
    this.purposeCode,
    this.purpose = const [],
    this.validityPeriod,
    this.certificate = const [],
  });

  static PartyAuthorization? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PartyAuthorization (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      purposeCode: PurposeCode.fromJson(json['purposeCode'] as Map<String, dynamic>?),
      purpose: (json['purpose'] as List? ?? []).map((dynamic d) => Purpose.fromJson(d as Map<String, dynamic>?)!).toList(),
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
      certificate: (json['certificate'] as List? ?? []).map((dynamic d) => Certificate.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'purposeCode': purposeCode?.toJson(),
      'purpose': purpose.map((e) => e.toJson()).toList(),
      'validityPeriod': validityPeriod?.toJson(),
      'certificate': certificate.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PartyAuthorization? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PartyAuthorization (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      purposeCode: PurposeCode.fromXml(xml.findElements('cbc:PurposeCode').singleOrNull),
      purpose: xml.findElements('cbc:Purpose').map((XmlElement e) => Purpose.fromXml(e)!).toList(),
      validityPeriod: ValidityPeriod.fromXml(xml.findElements('cac:ValidityPeriod').singleOrNull),
      certificate: xml.findElements('cac:Certificate').map((XmlElement e) => Certificate.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      purposeCode?.toXml(),
      ...purpose.map((Purpose e) => e.toXml()).toList(),
      validityPeriod?.toXml(),
      ...certificate.map((Certificate e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PartyAuthorization',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

