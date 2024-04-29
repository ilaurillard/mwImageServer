import 'dart:convert';
import '../../Etc/Util.dart';

// A list of two mutually exclusive Boolean values that express the only possible states of a property.
class LivestockIndicator {

  final bool value; // (boolean)

  LivestockIndicator ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  LivestockIndicator fromJson(Map<String, dynamic> json) {
    return LivestockIndicator (
    );
  }

}

