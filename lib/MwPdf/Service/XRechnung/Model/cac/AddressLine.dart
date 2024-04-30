import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Line.dart';
import '../ext/UBLExtensions.dart';

// A class to define an unstructured address line.
class AddressLine {


  // An address line expressed as unstructured text.
  final Line line;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  AddressLine ({
    required this.line,
    this.uBLExtensions,
  });

  static AddressLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AddressLine (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      line: Line.fromJson(json['line'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'line': line.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AddressLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AddressLine (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      line: Line.fromXml(xml.findElements('cbc:Line').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      line.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'AddressLine',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

