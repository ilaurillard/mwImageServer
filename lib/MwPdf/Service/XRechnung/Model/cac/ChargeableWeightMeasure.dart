// A numeric value determined by measuring an object using a specified unit of measure.
class ChargeableWeightMeasure {

  final String value; // (decimal)

  // The type of unit of measure.
  final String unitCode; // (normalizedString)

  // The version of the measure unit code list.
  final String? unitCodeListVersionID; // (normalizedString)

  ChargeableWeightMeasure ({
    required this.value,
    required this.unitCode,
    this.unitCodeListVersionID,
  });
}

