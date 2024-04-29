import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Line.dart';

// A class to define an unstructured address line.
class AddressLine {


  // An address line expressed as unstructured text.
  final Line line;

  AddressLine ({
    required this.line,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'line': line.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AddressLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AddressLine (
      line: Line.fromJson(json['line'] as Map<String, dynamic>?)!,
    );
  }

  static AddressLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return AddressLine (
      line: null,
    );
  }

}

