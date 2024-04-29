import '../cac/TaxAmount.dart';
import '../cac/RoundingAmount.dart';
import '../cac/TaxEvidenceIndicator.dart';
import '../cac/TaxIncludedIndicator.dart';
import '../cac/TaxSubtotal.dart';

// A class to describe the total tax for a particular taxation scheme.
class TaxTotal {


  // The total tax amount for a particular taxation scheme, e.g., VAT; the sum of the tax subtotals for each tax category within the taxation scheme.
  final TaxAmount taxAmount;

  // The rounding amount (positive or negative) added to the calculated tax total to produce the rounded TaxAmount.
  final RoundingAmount? roundingAmount;

  // An indicator that this total is recognized as legal evidence for taxation purposes (true) or not (false).
  final TaxEvidenceIndicator? taxEvidenceIndicator;

  // An indicator that tax is included in the calculation (true) or not (false).
  final TaxIncludedIndicator? taxIncludedIndicator;

  // One of the subtotals the sum of which equals the total tax amount for a particular taxation scheme.
  final List<TaxSubtotal> taxSubtotal;

  TaxTotal ({
    required this.taxAmount,
    this.roundingAmount,
    this.taxEvidenceIndicator,
    this.taxIncludedIndicator,
    this.taxSubtotal = const [],
  });
}

