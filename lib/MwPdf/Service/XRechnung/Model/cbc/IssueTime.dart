import 'dart:convert';
import '../../Etc/Util.dart';

// An instance of time that occurs every day.
class IssueTime {

  final XsdTime value; // (time)

  IssueTime ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  IssueTime fromJson(Map<String, dynamic> json) {
    return IssueTime (
    );
  }

}

