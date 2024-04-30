import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A character string that constitutes the distinctive designation of a person, place, thing or concept.
class MiddleName {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  MiddleName ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  }) {
    assert(value.isNotEmpty);
  }

  static MiddleName? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MiddleName (
      value: json['value'] as String? ?? '',
      languageID: json['languageID'] as String?,
      languageLocaleID: json['languageLocaleID'] as String?,
    );
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

  static MiddleName? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return MiddleName (
      value: xml.innerText,
      languageID: xml.getAttribute('languageID'),
      languageLocaleID: xml.getAttribute('languageLocaleID'),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'MiddleName',
        'cbc',
      ),
    );
  }
}

