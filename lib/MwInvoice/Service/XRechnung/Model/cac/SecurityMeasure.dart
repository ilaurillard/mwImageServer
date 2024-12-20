// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Description.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';

// A class to describe a security measure
class SecurityMeasure {


  // The description of this security measure
  final List<Description> description;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this security measure.
  final ID? iD;

  SecurityMeasure ({
    required this.description,
    this.uBLExtensions,
    this.iD,
  }) {
    if (description.isEmpty) { throw Exception('empty description given'); }
  }

  static SecurityMeasure? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SecurityMeasure (
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

  static SecurityMeasure? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SecurityMeasure (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      ...description.map((Description e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SecurityMeasure',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

