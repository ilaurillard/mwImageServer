import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A character string (i.e. a finite set of characters), generally in the form of words of a language.
class BackorderReason {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  BackorderReason ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  }) {
    assert(value.isNotEmpty);
  }

  static BackorderReason? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return BackorderReason (
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

  static BackorderReason? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return BackorderReason (
      value: xml.innerText,
      languageID: xml.getAttribute('languageID'),
      languageLocaleID: xml.getAttribute('languageLocaleID'),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'BackorderReason',
        'cbc',
      ),
    );
  }
}

