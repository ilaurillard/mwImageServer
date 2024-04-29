import 'dart:convert';
import '../../Etc/Util.dart';

// One calendar day according the Gregorian calendar.
class LatestPickupDate {

  final XsdDate value; // (date)

  LatestPickupDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  LatestPickupDate fromJson(Map<String, dynamic> json) {
    return LatestPickupDate (
    );
  }

}

