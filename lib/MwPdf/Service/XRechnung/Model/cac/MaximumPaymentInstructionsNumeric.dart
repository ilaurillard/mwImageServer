// Numeric information that is assigned or is determined by calculation, counting, or sequencing. It does not require a unit of quantity or unit of measure.
class MaximumPaymentInstructionsNumeric {

  final String value; // (decimal)

  // Whether the number is an integer, decimal, real number or percentage.
  final String? format; // (string)

  MaximumPaymentInstructionsNumeric ({
    required this.value,
    this.format,
  });
}

