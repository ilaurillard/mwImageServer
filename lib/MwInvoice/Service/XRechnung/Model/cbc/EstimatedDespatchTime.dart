// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// An instance of time that occurs every day.
class EstimatedDespatchTime {

  final XsdTime value; // (time)

  EstimatedDespatchTime ({
    required this.value,
  });

  static EstimatedDespatchTime? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return EstimatedDespatchTime (
      value: XsdTime.fromJson(json['value'] as String?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static EstimatedDespatchTime? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return EstimatedDespatchTime (
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
        'EstimatedDespatchTime',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

