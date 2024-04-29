import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// One calendar day according the Gregorian calendar.
class GuaranteedDespatchDate {

  final XsdDate value; // (date)

  GuaranteedDespatchDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static GuaranteedDespatchDate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return GuaranteedDespatchDate (
      value: XsdDate.fromJson(json['value'] as String?)!,
    );
  }

  static GuaranteedDespatchDate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return GuaranteedDespatchDate (
      value: null,
    );
  }

}

