// A counted number of non-monetary units, possibly including a fractional part.
class BaseQuantity {

  final String value; // (decimal)

  // The unit of the quantity
  final String? unitCode; // (normalizedString)

  // The quantity unit code list.
  final String? unitCodeListID; // (normalizedString)

  // The identification of the agency that maintains the quantity unit code list
  final String? unitCodeListAgencyID; // (normalizedString)

  // The name of the agency which maintains the quantity unit code list.
  final String? unitCodeListAgencyName; // (string)

  BaseQuantity ({
    required this.value,
    this.unitCode,
    this.unitCodeListID,
    this.unitCodeListAgencyID,
    this.unitCodeListAgencyName,
  });
}

