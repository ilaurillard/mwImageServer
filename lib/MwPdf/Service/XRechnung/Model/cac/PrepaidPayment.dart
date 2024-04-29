import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cbc/PaidAmount.dart';
import '../cbc/ReceivedDate.dart';
import '../cbc/PaidDate.dart';
import '../cbc/PaidTime.dart';
import '../cbc/InstructionID.dart';

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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'paidAmount': paidAmount?.toJson(),
     'receivedDate': receivedDate?.toJson(),
     'paidDate': paidDate?.toJson(),
     'paidTime': paidTime?.toJson(),
     'instructionID': instructionID?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  PrepaidPayment fromJson(Map<String, dynamic> json) {
    return PrepaidPayment (
    );
  }

}

