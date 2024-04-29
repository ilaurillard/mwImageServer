import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/WeekDayCode.dart';

// A class to specify which day of the week a transport service is operational.
class ScheduledServiceFrequency {


  // A day of the week, expressed as code.
  final WeekDayCode weekDayCode;

  ScheduledServiceFrequency ({
    required this.weekDayCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'weekDayCode': weekDayCode.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ScheduledServiceFrequency? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ScheduledServiceFrequency (
      weekDayCode: WeekDayCode.fromJson(json['weekDayCode'] as Map<String, dynamic>?)!,
    );
  }

  static ScheduledServiceFrequency? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ScheduledServiceFrequency (
      weekDayCode: null,
    );
  }

}

