import 'dart:convert';
import '../../Etc/Util.dart';

// An instance of time that occurs every day.
class GuaranteedDespatchTime {

  final XsdTime value; // (time)

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


  GuaranteedDespatchTime fromJson(Map<String, dynamic> json) {
    return GuaranteedDespatchTime (
    );
  }

}

