import 'dart:convert';
import '../../Etc/Util.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class OnCarriageIndicator {

  final bool value; // (boolean)

  OnCarriageIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  OnCarriageIndicator fromJson(Map<String, dynamic> json) {
    return OnCarriageIndicator (
    );
  }

}

