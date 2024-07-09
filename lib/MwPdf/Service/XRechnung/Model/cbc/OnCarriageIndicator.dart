// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class OnCarriageIndicator {

  final bool value; // (boolean)

  OnCarriageIndicator ({
    required this.value,
  });

  static OnCarriageIndicator? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OnCarriageIndicator (
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

  static OnCarriageIndicator? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OnCarriageIndicator (
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
        'OnCarriageIndicator',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

