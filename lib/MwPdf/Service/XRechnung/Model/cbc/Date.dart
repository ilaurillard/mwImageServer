import 'dart:convert';

// One calendar day according the Gregorian calendar.
class Date {

  final String value; // (date)

  Date ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

