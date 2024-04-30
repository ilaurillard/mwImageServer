import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A character string (letters, figures, or symbols) that for brevity and/or language independence may be used to represent or replace a definitive value or text of an attribute, together with relevant supplementary information.
class CardTypeCode {

  final String value; // (normalizedString)

  // The identification of a list of codes.
  final String? listID; // (normalizedString)

  // An agency that maintains one or more lists of codes.
  final String? listAgencyID; // (normalizedString)

  // The name of the agency that maintains the list of codes.
  final String? listAgencyName; // (string)

  // The name of a list of codes.
  final String? listName; // (string)

  // The version of the list of codes.
  final String? listVersionID; // (normalizedString)

  // The textual equivalent of the code content component.
  final String? name; // (string)

  // The identifier of the language used in the code name.
  final String? languageID; // (language)

  // The Uniform Resource Identifier that identifies where the code list is located.
  final String? listURI; // (anyURI)

  // The Uniform Resource Identifier that identifies where the code list scheme is located.
  final String? listSchemeURI; // (anyURI)

  CardTypeCode ({
    required this.value,
    this.listID,
    this.listAgencyID,
    this.listAgencyName,
    this.listName,
    this.listVersionID,
    this.name,
    this.languageID,
    this.listURI,
    this.listSchemeURI,
  }) {
    assert(value.isNotEmpty);
  }

  static CardTypeCode? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CardTypeCode (
      value: json['value'] as String? ?? '',
      listID: json['listID'] as String?,
      listAgencyID: json['listAgencyID'] as String?,
      listAgencyName: json['listAgencyName'] as String?,
      listName: json['listName'] as String?,
      listVersionID: json['listVersionID'] as String?,
      name: json['name'] as String?,
      languageID: json['languageID'] as String?,
      listURI: json['listURI'] as String?,
      listSchemeURI: json['listSchemeURI'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value,
      'listID': listID,
      'listAgencyID': listAgencyID,
      'listAgencyName': listAgencyName,
      'listName': listName,
      'listVersionID': listVersionID,
      'name': name,
      'languageID': languageID,
      'listURI': listURI,
      'listSchemeURI': listSchemeURI,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CardTypeCode? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CardTypeCode (
      value: xml.innerText,
      listID: xml.getAttribute('listID'),
      listAgencyID: xml.getAttribute('listAgencyID'),
      listAgencyName: xml.getAttribute('listAgencyName'),
      listName: xml.getAttribute('listName'),
      listVersionID: xml.getAttribute('listVersionID'),
      name: xml.getAttribute('name'),
      languageID: xml.getAttribute('languageID'),
      listURI: xml.getAttribute('listURI'),
      listSchemeURI: xml.getAttribute('listSchemeURI'),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'CardTypeCode',
        'cbc',
      ),
    );
  }
}

