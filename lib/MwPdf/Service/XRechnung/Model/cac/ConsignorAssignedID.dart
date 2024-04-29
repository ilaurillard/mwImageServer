// A character string to identify and uniquely distinguish one instance of an object in an identification scheme from all other objects in the same scheme, together with relevant supplementary information.
class ConsignorAssignedID {

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

  ConsignorAssignedID ({
    required this.value,
    this.schemeID,
    this.schemeName,
    this.schemeAgencyID,
    this.schemeAgencyName,
    this.schemeVersionID,
    this.schemeDataURI,
    this.schemeURI,
  });
}

