import 'dart:convert';

// An instance of time that occurs every day.
class GuaranteedDespatchTime {

  final String value; // (time)

  GuaranteedDespatchTime ({
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

