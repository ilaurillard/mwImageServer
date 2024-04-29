import '../cac/ID.dart';
import '../cac/PaidAmount.dart';
import '../cac/ReceivedDate.dart';
import '../cac/PaidDate.dart';
import '../cac/PaidTime.dart';
import '../cac/InstructionID.dart';

// A class to describe a payment.
class PrepaidPayment {


  // An identifier for this payment.
  final ID? iD;

  // The amount of this payment.
  final PaidAmount? paidAmount;

  // The date on which this payment was received.
  final ReceivedDate? receivedDate;

  // The date on which this payment was made.
  final PaidDate? paidDate;

  // The time at which this payment was made.
  final PaidTime? paidTime;

  // An identifier for the payment instruction.
  final InstructionID? instructionID;

  PrepaidPayment ({
    this.iD,
    this.paidAmount,
    this.receivedDate,
    this.paidDate,
    this.paidTime,
    this.instructionID,
  });
}

