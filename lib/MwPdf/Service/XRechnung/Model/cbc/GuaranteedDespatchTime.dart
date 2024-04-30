import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class GuaranteedDespatchTime {

  final XsdTime value; // (time)

  GuaranteedDespatchTime ({
    required this.value,
  });

  static GuaranteedDespatchTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return GuaranteedDespatchTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static GuaranteedDespatchTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return GuaranteedDespatchTime (
      value: XsdTime.fromJson(xml.innerText)!,
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
        'GuaranteedDespatchTime',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

