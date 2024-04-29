import 'dart:convert';
import '../cbc/PaymentMeansCode.dart';
import '../cbc/ID.dart';
import '../cbc/PaymentDueDate.dart';
import '../cbc/PaymentChannelCode.dart';
import '../cbc/InstructionID.dart';
import '../cbc/InstructionNote.dart';
import '../cbc/PaymentID.dart';
import '../cac/CardAccount.dart';
import '../cac/PayerFinancialAccount.dart';
import '../cac/PayeeFinancialAccount.dart';
import '../cac/CreditAccount.dart';
import '../cac/PaymentMandate.dart';
import '../cac/TradeFinancing.dart';

// A class to describe a means of payment.
class PaymentMeans {


  // A code signifying the type of this means of payment.
  final PaymentMeansCode paymentMeansCode;

  // An identifier for this means of payment.
  final ID? iD;

  // The date on which payment is due for this means of payment.
  final PaymentDueDate? paymentDueDate;

  // A code signifying the payment channel for this means of payment.
  final PaymentChannelCode? paymentChannelCode;

  // An identifier for the payment instruction.
  final InstructionID? instructionID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<InstructionNote> instructionNote;

  // An identifier for a payment made using this means of payment.
  final List<PaymentID> paymentID;

  // A credit card, debit card, or charge card account that constitutes this means of payment.
  final CardAccount? cardAccount;

  // The payer's financial account.
  final PayerFinancialAccount? payerFinancialAccount;

  // The payee's financial account.
  final PayeeFinancialAccount? payeeFinancialAccount;

  // A credit account associated with this means of payment.
  final CreditAccount? creditAccount;

  // The payment mandate associated with this means of payment.
  final PaymentMandate? paymentMandate;

  // A trade finance agreement applicable to this means of payment.
  final TradeFinancing? tradeFinancing;

  PaymentMeans ({
    required this.paymentMeansCode,
    this.iD,
    this.paymentDueDate,
    this.paymentChannelCode,
    this.instructionID,
    this.instructionNote = const [],
    this.paymentID = const [],
    this.cardAccount,
    this.payerFinancialAccount,
    this.payeeFinancialAccount,
    this.creditAccount,
    this.paymentMandate,
    this.tradeFinancing,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'paymentMeansCode': paymentMeansCode.toJson(),
     'paymentDueDate': paymentDueDate?.toJson(),
     'paymentChannelCode': paymentChannelCode?.toJson(),
     'instructionID': instructionID?.toJson(),
     'instructionNote': instructionNote.map((e) => e.toJson()).toList(),
     'paymentID': paymentID.map((e) => e.toJson()).toList(),
     'cardAccount': cardAccount?.toJson(),
     'payerFinancialAccount': payerFinancialAccount?.toJson(),
     'payeeFinancialAccount': payeeFinancialAccount?.toJson(),
     'creditAccount': creditAccount?.toJson(),
     'paymentMandate': paymentMandate?.toJson(),
     'tradeFinancing': tradeFinancing?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

