import 'dart:convert';
import '../../Etc/Util.dart';

// A character string that constitutes the distinctive designation of a person, place, thing or concept.
class TechnicalName {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  TechnicalName ({
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


  TechnicalName fromJson(Map<String, dynamic> json) {
    return TechnicalName (
    );
  }

}

