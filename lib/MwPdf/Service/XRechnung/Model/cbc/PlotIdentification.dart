import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A character string (i.e. a finite set of characters), generally in the form of words of a language.
class PlotIdentification {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  PlotIdentification ({
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

  static PlotIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PlotIdentification (
      value: json['value'] as String? ?? '',
      languageID: json['languageID'] as String?,
      languageLocaleID: json['languageLocaleID'] as String?,
    );
  }

  static PlotIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PlotIdentification (
      value: null,
      languageID: null,
      languageLocaleID: null,
    );
  }

}

