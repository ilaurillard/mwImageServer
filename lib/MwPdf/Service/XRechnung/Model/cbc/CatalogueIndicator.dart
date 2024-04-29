import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class CatalogueIndicator {

  final bool value; // (boolean)

  CatalogueIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CatalogueIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CatalogueIndicator (
      value: json['value'] as bool? ?? false,
    );
  }

  static CatalogueIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return CatalogueIndicator (
      value: null,
    );
  }

}

