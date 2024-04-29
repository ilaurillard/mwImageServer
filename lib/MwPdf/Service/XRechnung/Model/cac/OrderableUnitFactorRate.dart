// A numeric expression of a rate that is assigned or is determined by calculation, counting, or sequencing. It does not require a unit of quantity or unit of measure.
class OrderableUnitFactorRate {

  final String value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  OrderableUnitFactorRate ({
    required this.value,
    this.format,
  });
}

