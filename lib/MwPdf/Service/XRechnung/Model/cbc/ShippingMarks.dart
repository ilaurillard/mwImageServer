import 'dart:convert';
import '../../Etc/Util.dart';

// A character string (i.e. a finite set of characters), generally in the form of words of a language.
class ShippingMarks {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  ShippingMarks ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  }) {
    assert(value.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'languageID': languageID,
     'languageLocaleID': languageLocaleID,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ShippingMarks fromJson(Map<String, dynamic> json) {
    return ShippingMarks (
    );
  }

}

