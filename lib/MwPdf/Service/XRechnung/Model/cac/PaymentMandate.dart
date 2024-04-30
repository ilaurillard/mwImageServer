import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
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

  static PaymentMandate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PaymentMandate (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      mandateTypeCode: MandateTypeCode.fromJson(json['mandateTypeCode'] as Map<String, dynamic>?),
      maximumPaymentInstructionsNumeric: MaximumPaymentInstructionsNumeric.fromJson(json['maximumPaymentInstructionsNumeric'] as Map<String, dynamic>?),
      maximumPaidAmount: MaximumPaidAmount.fromJson(json['maximumPaidAmount'] as Map<String, dynamic>?),
      signatureID: SignatureID.fromJson(json['signatureID'] as Map<String, dynamic>?),
      payerParty: PayerParty.fromJson(json['payerParty'] as Map<String, dynamic>?),
      payerFinancialAccount: PayerFinancialAccount.fromJson(json['payerFinancialAccount'] as Map<String, dynamic>?),
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
      paymentReversalPeriod: PaymentReversalPeriod.fromJson(json['paymentReversalPeriod'] as Map<String, dynamic>?),
      clause: (json['clause'] as List? ?? []).map((dynamic d) => Clause.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static PaymentMandate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PaymentMandate (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      mandateTypeCode: MandateTypeCode.fromXml(xml.findElements('cbc:MandateTypeCode').singleOrNull),
      maximumPaymentInstructionsNumeric: MaximumPaymentInstructionsNumeric.fromXml(xml.findElements('cbc:MaximumPaymentInstructionsNumeric').singleOrNull),
      maximumPaidAmount: MaximumPaidAmount.fromXml(xml.findElements('cbc:MaximumPaidAmount').singleOrNull),
      signatureID: SignatureID.fromXml(xml.findElements('cbc:SignatureID').singleOrNull),
      payerParty: PayerParty.fromXml(xml.findElements('cac:PayerParty').singleOrNull),
      payerFinancialAccount: PayerFinancialAccount.fromXml(xml.findElements('cac:PayerFinancialAccount').singleOrNull),
      validityPeriod: ValidityPeriod.fromXml(xml.findElements('cac:ValidityPeriod').singleOrNull),
      paymentReversalPeriod: PaymentReversalPeriod.fromXml(xml.findElements('cac:PaymentReversalPeriod').singleOrNull),
      clause: xml.findElements('cac:Clause').map((XmlElement e) => Clause.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      mandateTypeCode?.toXml(),
      maximumPaymentInstructionsNumeric?.toXml(),
      maximumPaidAmount?.toXml(),
      signatureID?.toXml(),
      payerParty?.toXml(),
      payerFinancialAccount?.toXml(),
      validityPeriod?.toXml(),
      paymentReversalPeriod?.toXml(),
      ...clause.map((Clause e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PaymentMandate',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

