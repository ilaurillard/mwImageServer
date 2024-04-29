import 'dart:convert';

// One calendar day according the Gregorian calendar.
class EndDate {

  final String value; // (date)

  EndDate ({
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

