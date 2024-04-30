import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Information.dart';
import '../cbc/Reference.dart';
import '../cac/ApplicableAddress.dart';

// A class for describing the terms of a trade agreement.
class HaulageTradingTerms {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // Text describing the terms of a trade agreement.
  final List<Information> information;

  // A reference quoting the basis of the terms
  final Reference? reference;

  // The address at which these trading terms apply.
  final ApplicableAddress? applicableAddress;

  HaulageTradingTerms ({
    this.uBLExtensions,
    this.information = const [],
    this.reference,
    this.applicableAddress,
  });

  static HaulageTradingTerms? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return HaulageTradingTerms (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      information: (json['information'] as List? ?? []).map((dynamic d) => Information.fromJson(d as Map<String, dynamic>?)!).toList(),
      reference: Reference.fromJson(json['reference'] as Map<String, dynamic>?),
      applicableAddress: ApplicableAddress.fromJson(json['applicableAddress'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'information': information.map((e) => e.toJson()).toList(),
      'reference': reference?.toJson(),
      'applicableAddress': applicableAddress?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static HaulageTradingTerms? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return HaulageTradingTerms (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      information: xml.findElements('cbc:Information').map((XmlElement e) => Information.fromXml(e)!).toList(),
      reference: Reference.fromXml(xml.findElements('cbc:Reference').singleOrNull),
      applicableAddress: ApplicableAddress.fromXml(xml.findElements('cac:ApplicableAddress').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      ...information.map((Information e) => e.toXml()).toList(),
      reference?.toXml(),
      applicableAddress?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'HaulageTradingTerms',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

