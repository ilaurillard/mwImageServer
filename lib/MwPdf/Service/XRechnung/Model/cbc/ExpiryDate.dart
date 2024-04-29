import 'dart:convert';

// One calendar day according the Gregorian calendar.
class ExpiryDate {

  final String value; // (date)

  ExpiryDate ({
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

