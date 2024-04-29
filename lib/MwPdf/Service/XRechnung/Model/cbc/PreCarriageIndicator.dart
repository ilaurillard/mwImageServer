import 'dart:convert';
import '../../Etc/Util.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class PreCarriageIndicator {

  final bool value; // (boolean)

  PreCarriageIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  PreCarriageIndicator fromJson(Map<String, dynamic> json) {
    return PreCarriageIndicator (
    );
  }

}

