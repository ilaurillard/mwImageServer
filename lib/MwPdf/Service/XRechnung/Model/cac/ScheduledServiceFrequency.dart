import 'dart:convert';
import '../../Etc/Util.dart';
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


  ScheduledServiceFrequency fromJson(Map<String, dynamic> json) {
    return ScheduledServiceFrequency (
    );
  }

}

