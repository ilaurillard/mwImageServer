import 'dart:convert';
import '../../Etc/Util.dart';

// An instance of time that occurs every day.
class ReferenceTime {

  final XsdTime value; // (time)

  ReferenceTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ReferenceTime fromJson(Map<String, dynamic> json) {
    return ReferenceTime (
    );
  }

}

