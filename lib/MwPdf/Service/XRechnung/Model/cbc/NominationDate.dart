import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class NominationDate {

  final XsdDate value; // (date)

  NominationDate ({
    required this.value,
  });

  static NominationDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return NominationDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static NominationDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return NominationDate (
      value: XsdDate.fromJson(xml.innerText)!,
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
        'NominationDate',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

