import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtension.dart';

// A container for all extensions present in the document.
class UBLExtensions {


  // A single extension for private use.
  final List<UBLExtension> uBLExtension;

  UBLExtensions ({
    required this.uBLExtension,
  }) {
    assert(uBLExtension.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtension': uBLExtension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static UBLExtensions? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return UBLExtensions (
      uBLExtension: (json['uBLExtension'] as List? ?? []).map((dynamic d) => UBLExtension.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static UBLExtensions? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return UBLExtensions (
      uBLExtension: null,
    );
  }

}

