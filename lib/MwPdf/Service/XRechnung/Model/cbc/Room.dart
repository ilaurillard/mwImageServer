import 'dart:convert';

// A character string (i.e. a finite set of characters), generally in the form of words of a language.
class Room {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  Room ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'languageID': languageID,
     'languageLocaleID': languageLocaleID,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

