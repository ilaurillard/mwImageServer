import 'dart:convert';
import '../../Etc/Util.dart';

// An instance of time that occurs every day.
class RequestedDespatchTime {

  final XsdTime value; // (time)

  RequestedDespatchTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  RequestedDespatchTime fromJson(Map<String, dynamic> json) {
    return RequestedDespatchTime (
    );
  }

}

