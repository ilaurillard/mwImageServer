import 'dart:convert';
import '../../Etc/Util.dart';

// One calendar day according the Gregorian calendar.
class InstallmentDueDate {

  final XsdDate value; // (date)

  InstallmentDueDate ({
    required this.value,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  InstallmentDueDate fromJson(Map<String, dynamic> json) {
    return InstallmentDueDate (
    );
  }

}

