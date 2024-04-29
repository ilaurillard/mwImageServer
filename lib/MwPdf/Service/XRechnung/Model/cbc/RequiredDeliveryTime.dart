import 'dart:convert';
import '../../Etc/Util.dart';

// An instance of time that occurs every day.
class RequiredDeliveryTime {

  final XsdTime value; // (time)

  RequiredDeliveryTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  RequiredDeliveryTime fromJson(Map<String, dynamic> json) {
    return RequiredDeliveryTime (
    );
  }

}

