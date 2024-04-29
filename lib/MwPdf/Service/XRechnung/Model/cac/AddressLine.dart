import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/Line.dart';

// A class to define an unstructured address line.
class AddressLine {


  // An address line expressed as unstructured text.
  final Line line;

  AddressLine ({
    required this.line,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'line': line.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  AddressLine fromJson(Map<String, dynamic> json) {
    return AddressLine (
    );
  }

}

