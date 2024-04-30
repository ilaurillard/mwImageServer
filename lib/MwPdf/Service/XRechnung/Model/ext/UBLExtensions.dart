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

  static UBLExtensions? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return UBLExtensions (
      uBLExtension: (json['uBLExtension'] as List? ?? []).map((dynamic d) => UBLExtension.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtension': uBLExtension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static UBLExtensions? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return UBLExtensions (
      uBLExtension: xml.findElements('ext:UBLExtension').map((XmlElement e) => UBLExtension.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'UBLExtensions',
        'ext',
      ),
    );
  }
}

