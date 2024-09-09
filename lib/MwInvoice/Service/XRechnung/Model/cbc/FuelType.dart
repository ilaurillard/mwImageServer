// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A character string (i.e. a finite set of characters), generally in the form of words of a language.
class FuelType {

  final String value; // (string)

  // The identifier of the language used in the content component.
  final String? languageID; // (language)

  // The identification of the locale of the language.
  final String? languageLocaleID; // (normalizedString)

  FuelType ({
    required this.value,
    this.languageID,
    this.languageLocaleID,
  }) {
    if (value.isEmpty) { throw Exception('empty value given'); }
  }

  static FuelType? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FuelType (
      value: json['value'] as String? ?? '',
      languageID: json['languageID'] as String?,
      languageLocaleID: json['languageLocaleID'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
      'languageID': languageID?.toString(),
      'languageLocaleID': languageLocaleID?.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FuelType? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return FuelType (
      value: xml.innerText,
      languageID: xml.getAttribute('languageID'),
      languageLocaleID: xml.getAttribute('languageLocaleID'),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [

      languageID != null ? XmlAttribute(XmlName('languageID'), languageID.toString(),) : null,
      languageLocaleID != null ? XmlAttribute(XmlName('languageLocaleID'), languageLocaleID.toString(),) : null,

    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'FuelType',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

