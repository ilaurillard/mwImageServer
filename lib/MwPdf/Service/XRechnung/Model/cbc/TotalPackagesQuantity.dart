import 'dart:convert';

// A counted number of non-monetary units, possibly including a fractional part.
class TotalPackagesQuantity {

  final double value; // (decimal)

  // The unit of the quantity
  final String? unitCode; // (normalizedString)

  // The quantity unit code list.
  final String? unitCodeListID; // (normalizedString)

  // The identification of the agency that maintains the quantity unit code list
  final String? unitCodeListAgencyID; // (normalizedString)

  // The name of the agency which maintains the quantity unit code list.
  final String? unitCodeListAgencyName; // (string)

  TotalPackagesQuantity ({
    required this.value,
    this.unitCode,
    this.unitCodeListID,
    this.unitCodeListAgencyID,
    this.unitCodeListAgencyName,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'value': value,
     'unitCode': unitCode,
     'unitCodeListID': unitCodeListID,
     'unitCodeListAgencyID': unitCodeListAgencyID,
     'unitCodeListAgencyName': unitCodeListAgencyName,
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

