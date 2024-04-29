import '../cac/TaxableAmount.dart';
import '../cac/TaxAmount.dart';
import '../cac/CalculationSequenceNumeric.dart';
import '../cac/TransactionCurrencyTaxAmount.dart';
import '../cac/Percent.dart';
import '../cac/BaseUnitMeasure.dart';
import '../cac/PerUnitAmount.dart';
import '../cac/TierRange.dart';
import '../cac/TierRatePercent.dart';
import '../cac/TaxCategory.dart';

// A class to define the subtotal for a particular tax category within a particular taxation scheme, such as standard rate within VAT.
class TaxSubtotal {


  // The amount of this tax subtotal.
  final TaxAmount taxAmount;

  // The tax category applicable to this subtotal.
  final TaxCategory taxCategory;

  // The net amount to which the tax percent (rate) is applied to calculate the tax amount.
  final TaxableAmount? taxableAmount;

  // The number of this tax subtotal in the sequence of subtotals corresponding to the order in which multiple taxes are applied. If all taxes are applied to the same taxable amount (i.e., their order of application is inconsequential), then CalculationSequenceNumeric is 1 for all tax subtotals applied to a given amount.
  final CalculationSequenceNumeric? calculationSequenceNumeric;

  // The amount of this tax subtotal, expressed in the currency used for invoicing.
  final TransactionCurrencyTaxAmount? transactionCurrencyTaxAmount;

  // The tax rate of the tax category applied to this tax subtotal, expressed as a percentage.
  final Percent? percent;

  // The unit of measure on which the tax calculation is based
  final BaseUnitMeasure? baseUnitMeasure;

  // Where a tax is applied at a certain rate per unit, the rate per unit applied.
  final PerUnitAmount? perUnitAmount;

  // Where a tax is tiered, the range of taxable amounts that determines the rate of tax applicable to this tax subtotal.
  final TierRange? tierRange;

  // Where a tax is tiered, the tax rate that applies within a specified range of taxable amounts for this tax subtotal.
  final TierRatePercent? tierRatePercent;

  TaxSubtotal ({
    required this.taxAmount,
    required this.taxCategory,
    this.taxableAmount,
    this.calculationSequenceNumeric,
    this.transactionCurrencyTaxAmount,
    this.percent,
    this.baseUnitMeasure,
    this.perUnitAmount,
    this.tierRange,
    this.tierRatePercent,
  });
}

