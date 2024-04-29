import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  static PaymentMeans? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PaymentMeans (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      paymentMeansCode: PaymentMeansCode.fromJson(json['paymentMeansCode'] as Map<String, dynamic>?)!,
      paymentDueDate: PaymentDueDate.fromJson(json['paymentDueDate'] as Map<String, dynamic>?),
      paymentChannelCode: PaymentChannelCode.fromJson(json['paymentChannelCode'] as Map<String, dynamic>?),
      instructionID: InstructionID.fromJson(json['instructionID'] as Map<String, dynamic>?),
      instructionNote: (json['instructionNote'] as List? ?? []).map((dynamic d) => InstructionNote.fromJson(d as Map<String, dynamic>?)!).toList(),
      paymentID: (json['paymentID'] as List? ?? []).map((dynamic d) => PaymentID.fromJson(d as Map<String, dynamic>?)!).toList(),
      cardAccount: CardAccount.fromJson(json['cardAccount'] as Map<String, dynamic>?),
      payerFinancialAccount: PayerFinancialAccount.fromJson(json['payerFinancialAccount'] as Map<String, dynamic>?),
      payeeFinancialAccount: PayeeFinancialAccount.fromJson(json['payeeFinancialAccount'] as Map<String, dynamic>?),
      creditAccount: CreditAccount.fromJson(json['creditAccount'] as Map<String, dynamic>?),
      paymentMandate: PaymentMandate.fromJson(json['paymentMandate'] as Map<String, dynamic>?),
      tradeFinancing: TradeFinancing.fromJson(json['tradeFinancing'] as Map<String, dynamic>?),
    );
  }

  static PaymentMeans? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PaymentMeans (
      iD: null,
      paymentMeansCode: null,
      paymentDueDate: null,
      paymentChannelCode: null,
      instructionID: null,
      instructionNote: null,
      paymentID: null,
      cardAccount: null,
      payerFinancialAccount: null,
      payeeFinancialAccount: null,
      creditAccount: null,
      paymentMandate: null,
      tradeFinancing: null,
    );
  }

}

