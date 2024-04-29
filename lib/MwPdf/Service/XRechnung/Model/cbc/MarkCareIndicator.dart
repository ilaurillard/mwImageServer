import 'dart:convert';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class MarkCareIndicator {

  final String value; // (boolean)

  MarkCareIndicator ({
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

