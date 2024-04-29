import '../cac/LineExtensionAmount.dart';
import '../cac/TaxExclusiveAmount.dart';
import '../cac/TaxInclusiveAmount.dart';
import '../cac/AllowanceTotalAmount.dart';
import '../cac/ChargeTotalAmount.dart';
import '../cac/PrepaidAmount.dart';
import '../cac/PayableRoundingAmount.dart';
import '../cac/PayableAmount.dart';
import '../cac/PayableAlternativeAmount.dart';

// A class to define a monetary total.
class LegalMonetaryTotal {


  // The amount of the monetary total to be paid.
  final PayableAmount payableAmount;

  // The monetary amount of an extended transaction line, net of tax and settlement discounts, but inclusive of any applicable rounding amount.
  final LineExtensionAmount? lineExtensionAmount;

  // The monetary amount of an extended transaction line, exclusive of taxes.
  final TaxExclusiveAmount? taxExclusiveAmount;

  // The monetary amount including taxes; the sum of payable amount and prepaid amount.
  final TaxInclusiveAmount? taxInclusiveAmount;

  // The total monetary amount of all allowances.
  final AllowanceTotalAmount? allowanceTotalAmount;

  // The total monetary amount of all charges.
  final ChargeTotalAmount? chargeTotalAmount;

  // The total prepaid monetary amount.
  final PrepaidAmount? prepaidAmount;

  // The rounding amount (positive or negative) added to produce the line extension amount.
  final PayableRoundingAmount? payableRoundingAmount;

  // The amount of the monetary total to be paid, expressed in an alternative currency.
  final PayableAlternativeAmount? payableAlternativeAmount;

  LegalMonetaryTotal ({
    required this.payableAmount,
    this.lineExtensionAmount,
    this.taxExclusiveAmount,
    this.taxInclusiveAmount,
    this.allowanceTotalAmount,
    this.chargeTotalAmount,
    this.prepaidAmount,
    this.payableRoundingAmount,
    this.payableAlternativeAmount,
  });
}

