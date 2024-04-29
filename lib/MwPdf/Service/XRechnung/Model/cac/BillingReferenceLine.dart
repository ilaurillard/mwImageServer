import '../cac/ID.dart';
import '../cac/Amount.dart';
import '../cac/AllowanceCharge.dart';

// A class to define a reference to a transaction line in a billing document.
class BillingReferenceLine {


  // An identifier for this transaction line in a billing document.
  final ID iD;

  // The monetary amount of the transaction line, including any allowances and charges but excluding taxes.
  final Amount? amount;

  // An allowance or charge applicable to the transaction line.
  final List<AllowanceCharge> allowanceCharge;

  BillingReferenceLine ({
    required this.iD,
    this.amount,
    this.allowanceCharge = const [],
  });
}

