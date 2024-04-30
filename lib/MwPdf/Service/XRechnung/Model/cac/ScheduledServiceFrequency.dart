import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/WeekDayCode.dart';
import '../ext/UBLExtensions.dart';

// A class to specify which day of the week a transport service is operational.
class ScheduledServiceFrequency {


  // A day of the week, expressed as code.
  final WeekDayCode weekDayCode;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  ScheduledServiceFrequency ({
    required this.weekDayCode,
    this.uBLExtensions,
  });

  static ScheduledServiceFrequency? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ScheduledServiceFrequency (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      weekDayCode: WeekDayCode.fromJson(json['weekDayCode'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'weekDayCode': weekDayCode.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ScheduledServiceFrequency? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ScheduledServiceFrequency (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      weekDayCode: WeekDayCode.fromXml(xml.findElements('cbc:WeekDayCode').singleOrNull)!,
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ScheduledServiceFrequency',
        'cac',
      ),
    );
  }
}

