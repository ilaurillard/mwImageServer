// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class ActualDespatchDate {

  final XsdDate value; // (date)

  ActualDespatchDate ({
    required this.value,
  });

  static ActualDespatchDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ActualDespatchDate (
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

  static ActualDespatchDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ActualDespatchDate (
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
        'ActualDespatchDate',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

