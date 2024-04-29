import 'dart:convert';
import '../../Etc/Util.dart';

// A character string to identify and uniquely distinguish one instance of an object in an identification scheme from all other objects in the same scheme, together with relevant supplementary information.
class CV2ID {

  final String value; // (normalizedString)

  // The identification of the identification scheme.
  final String? schemeID; // (normalizedString)

  // The name of the identification scheme.
  final String? schemeName; // (string)

  // The identification of the agency that maintains the identification scheme.
  final String? schemeAgencyID; // (normalizedString)

  // The name of the agency that maintains the identification scheme.
  final String? schemeAgencyName; // (string)

  // The version of the identification scheme.
  final String? schemeVersionID; // (normalizedString)

  // The Uniform Resource Identifier that identifies where the identification scheme data is located.
  final String? schemeDataURI; // (anyURI)

  // The Uniform Resource Identifier that identifies where the identification scheme is located.
  final String? schemeURI; // (anyURI)

  CV2ID ({
    required this.value,
    this.schemeID,
    this.schemeName,
    this.schemeAgencyID,
    this.schemeAgencyName,
    this.schemeVersionID,
    this.schemeDataURI,
    this.schemeURI,
  }) {
    assert(value.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'schemeID': schemeID,
     'schemeName': schemeName,
     'schemeAgencyID': schemeAgencyID,
     'schemeAgencyName': schemeAgencyName,
     'schemeVersionID': schemeVersionID,
     'schemeDataURI': schemeDataURI,
     'schemeURI': schemeURI,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  CV2ID fromJson(Map<String, dynamic> json) {
    return CV2ID (
    );
  }

}

