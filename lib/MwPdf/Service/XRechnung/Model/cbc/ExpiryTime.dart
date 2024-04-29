import 'dart:convert';
import '../../Etc/Util.dart';

// An instance of time that occurs every day.
class ExpiryTime {

  final XsdTime value; // (time)

  ExpiryTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ExpiryTime fromJson(Map<String, dynamic> json) {
    return ExpiryTime (
    );
  }

}

