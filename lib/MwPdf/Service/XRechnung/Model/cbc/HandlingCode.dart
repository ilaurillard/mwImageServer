import 'dart:convert';
import '../../Etc/Util.dart';

// A character string (letters, figures, or symbols) that for brevity and/or language independence may be used to represent or replace a definitive value or text of an attribute, together with relevant supplementary information.
class HandlingCode {

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

  HandlingCode ({
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


  HandlingCode fromJson(Map<String, dynamic> json) {
    return HandlingCode (
    );
  }

}

