import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// Numeric information that is assigned or is determined by calculation, counting, or sequencing. It does not require a unit of quantity or unit of measure.
class SequenceNumeric {

  final double value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  SequenceNumeric ({
    required this.value,
    this.format,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
      'format': format,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SequenceNumeric? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SequenceNumeric (
      value: double.tryParse(json['value'].toString()) ?? 0,
      format: json['format'] as String?,
    );
  }

  static SequenceNumeric? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return SequenceNumeric (
      value: null,
      format: null,
    );
  }

}

