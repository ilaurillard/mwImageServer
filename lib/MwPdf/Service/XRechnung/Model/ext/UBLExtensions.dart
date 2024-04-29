import 'dart:convert';
import '../ext/UBLExtension.dart';

// A container for all extensions present in the document.
class UBLExtensions {


  // A single extension for private use.
  final List<UBLExtension> uBLExtension;

  UBLExtensions ({
    required this.uBLExtension,
  }) {
    assert(uBLExtension.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'uBLExtension': uBLExtension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

