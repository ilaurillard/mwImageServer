import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/MandateTypeCode.dart';
import '../cbc/MaximumPaymentInstructionsNumeric.dart';
import '../cbc/MaximumPaidAmount.dart';
import '../cbc/SignatureID.dart';
import '../cac/PayerParty.dart';
import '../cac/PayerFinancialAccount.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/PaymentReversalPeriod.dart';
import '../cac/Clause.dart';

// A class to describe a payment mandate.
class PaymentMandate {


  // An identifier for this payment mandate.
  final ID? iD;

  // A code signifying the type of this payment mandate.
  final MandateTypeCode? mandateTypeCode;

  // The number of maximum payment instructions allowed within the validity period.
  final MaximumPaymentInstructionsNumeric? maximumPaymentInstructionsNumeric;

  // The maximum amount to be paid within a single instruction.
  final MaximumPaidAmount? maximumPaidAmount;

  // An identifier for a signature applied by a signatory party.
  final SignatureID? signatureID;

  // The payer party (if different from the debtor).
  final PayerParty? payerParty;

  // The payer's financial account.
  final PayerFinancialAccount? payerFinancialAccount;

  // The period during which this mandate is valid.
  final ValidityPeriod? validityPeriod;

  // The period of the reverse payment.
  final PaymentReversalPeriod? paymentReversalPeriod;

  // A clause applicable to this payment mandate.
  final List<Clause> clause;

  PaymentMandate ({
    this.iD,
    this.mandateTypeCode,
    this.maximumPaymentInstructionsNumeric,
    this.maximumPaidAmount,
    this.signatureID,
    this.payerParty,
    this.payerFinancialAccount,
    this.validityPeriod,
    this.paymentReversalPeriod,
    this.clause = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'mandateTypeCode': mandateTypeCode?.toJson(),
     'maximumPaymentInstructionsNumeric': maximumPaymentInstructionsNumeric?.toJson(),
     'maximumPaidAmount': maximumPaidAmount?.toJson(),
     'signatureID': signatureID?.toJson(),
     'payerParty': payerParty?.toJson(),
     'payerFinancialAccount': payerFinancialAccount?.toJson(),
     'validityPeriod': validityPeriod?.toJson(),
     'paymentReversalPeriod': paymentReversalPeriod?.toJson(),
     'clause': clause.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

