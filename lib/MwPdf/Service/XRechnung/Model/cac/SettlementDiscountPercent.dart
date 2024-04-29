// Numeric information that is assigned or is determined by calculation, counting, or sequencing and is expressed as a percentage. It does not require a unit of quantity or unit of measure.
class SettlementDiscountPercent {

  final String value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  SettlementDiscountPercent ({
    required this.value,
    this.format,
  });
}

