import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class StillIllIndicator {

  final bool value; // (boolean)

  StillIllIndicator ({
    required this.value,
  });

  static StillIllIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return StillIllIndicator (
      value: json['value'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static StillIllIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return StillIllIndicator (
      value: xml.innerText as bool? ?? false,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'StillIllIndicator',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}
