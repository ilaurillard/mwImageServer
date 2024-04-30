import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Description.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';

// A class to describe a security measure
class AppliedSecurityMeasure {


  // The description of this security measure
  final List<Description> description;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this security measure.
  final ID? iD;

  AppliedSecurityMeasure ({
    required this.description,
    this.uBLExtensions,
    this.iD,
  }) {
    assert(description.isNotEmpty);
  }

  static AppliedSecurityMeasure? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AppliedSecurityMeasure (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AppliedSecurityMeasure? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AppliedSecurityMeasure (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'AppliedSecurityMeasure',
        'cac',
      ),
    );
  }
}

