import 'dart:convert';
import '../../Etc/Util.dart';

// One calendar day according the Gregorian calendar.
class ValidationDate {

  final XsdDate value; // (date)

  ValidationDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ValidationDate fromJson(Map<String, dynamic> json) {
    return ValidationDate (
    );
  }

}

