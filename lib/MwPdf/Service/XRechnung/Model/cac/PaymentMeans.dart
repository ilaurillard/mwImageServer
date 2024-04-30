import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PaymentMeansCode.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/PaymentDueDate.dart';
import '../cbc/PaymentChannelCode.dart';
import '../cbc/InstructionID.dart';
import '../cbc/InstructionNote.dart';
import '../cbc/PaymentID.dart';
import '../cbc/ChargeBearerCode.dart';
import '../cbc/ServiceLevelCode.dart';
import '../cac/CardAccount.dart';
import '../cac/PayerFinancialAccount.dart';
import '../cac/PayeeFinancialAccount.dart';
import '../cac/CreditAccount.dart';
import '../cac/PaymentMandate.dart';
import '../cac/TradeFinancing.dart';
import '../cac/RemittanceDocumentDistribution.dart';

// A class to describe a means of payment.
class PaymentMeans {


  // A code signifying the type of this means of payment.
  final PaymentMeansCode paymentMeansCode;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // A code signifying which party or parties will assume the charges and fees associated with the payment using this payment means.
  final ChargeBearerCode? chargeBearerCode;

  // A code signifying an agreed service level for the type of payment associated with this payment means.
  final ServiceLevelCode? serviceLevelCode;

  // A credit card, debit card, or charge card account that constitutes this means of payment.
  final List<CardAccount> cardAccount;

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

  // A person or entity who shall receive the remittance advice information about the payment associated with this payment means.
  final List<RemittanceDocumentDistribution> remittanceDocumentDistribution;

  PaymentMeans ({
    required this.paymentMeansCode,
    this.uBLExtensions,
    this.iD,
    this.paymentDueDate,
    this.paymentChannelCode,
    this.instructionID,
    this.instructionNote = const [],
    this.paymentID = const [],
    this.chargeBearerCode,
    this.serviceLevelCode,
    this.cardAccount = const [],
    this.payerFinancialAccount,
    this.payeeFinancialAccount,
    this.creditAccount,
    this.paymentMandate,
    this.tradeFinancing,
    this.remittanceDocumentDistribution = const [],
  });

  static PaymentMeans? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PaymentMeans (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      paymentMeansCode: PaymentMeansCode.fromJson(json['paymentMeansCode'] as Map<String, dynamic>?)!,
      paymentDueDate: PaymentDueDate.fromJson(json['paymentDueDate'] as Map<String, dynamic>?),
      paymentChannelCode: PaymentChannelCode.fromJson(json['paymentChannelCode'] as Map<String, dynamic>?),
      instructionID: InstructionID.fromJson(json['instructionID'] as Map<String, dynamic>?),
      instructionNote: (json['instructionNote'] as List? ?? []).map((dynamic d) => InstructionNote.fromJson(d as Map<String, dynamic>?)!).toList(),
      paymentID: (json['paymentID'] as List? ?? []).map((dynamic d) => PaymentID.fromJson(d as Map<String, dynamic>?)!).toList(),
      chargeBearerCode: ChargeBearerCode.fromJson(json['chargeBearerCode'] as Map<String, dynamic>?),
      serviceLevelCode: ServiceLevelCode.fromJson(json['serviceLevelCode'] as Map<String, dynamic>?),
      cardAccount: (json['cardAccount'] as List? ?? []).map((dynamic d) => CardAccount.fromJson(d as Map<String, dynamic>?)!).toList(),
      payerFinancialAccount: PayerFinancialAccount.fromJson(json['payerFinancialAccount'] as Map<String, dynamic>?),
      payeeFinancialAccount: PayeeFinancialAccount.fromJson(json['payeeFinancialAccount'] as Map<String, dynamic>?),
      creditAccount: CreditAccount.fromJson(json['creditAccount'] as Map<String, dynamic>?),
      paymentMandate: PaymentMandate.fromJson(json['paymentMandate'] as Map<String, dynamic>?),
      tradeFinancing: TradeFinancing.fromJson(json['tradeFinancing'] as Map<String, dynamic>?),
      remittanceDocumentDistribution: (json['remittanceDocumentDistribution'] as List? ?? []).map((dynamic d) => RemittanceDocumentDistribution.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'paymentMeansCode': paymentMeansCode.toJson(),
      'paymentDueDate': paymentDueDate?.toJson(),
      'paymentChannelCode': paymentChannelCode?.toJson(),
      'instructionID': instructionID?.toJson(),
      'instructionNote': instructionNote.map((e) => e.toJson()).toList(),
      'paymentID': paymentID.map((e) => e.toJson()).toList(),
      'chargeBearerCode': chargeBearerCode?.toJson(),
      'serviceLevelCode': serviceLevelCode?.toJson(),
      'cardAccount': cardAccount.map((e) => e.toJson()).toList(),
      'payerFinancialAccount': payerFinancialAccount?.toJson(),
      'payeeFinancialAccount': payeeFinancialAccount?.toJson(),
      'creditAccount': creditAccount?.toJson(),
      'paymentMandate': paymentMandate?.toJson(),
      'tradeFinancing': tradeFinancing?.toJson(),
      'remittanceDocumentDistribution': remittanceDocumentDistribution.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PaymentMeans? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PaymentMeans (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      paymentMeansCode: PaymentMeansCode.fromXml(xml.findElements('cbc:PaymentMeansCode').singleOrNull)!,
      paymentDueDate: PaymentDueDate.fromXml(xml.findElements('cbc:PaymentDueDate').singleOrNull),
      paymentChannelCode: PaymentChannelCode.fromXml(xml.findElements('cbc:PaymentChannelCode').singleOrNull),
      instructionID: InstructionID.fromXml(xml.findElements('cbc:InstructionID').singleOrNull),
      instructionNote: xml.findElements('cbc:InstructionNote').map((XmlElement e) => InstructionNote.fromXml(e)!).toList(),
      paymentID: xml.findElements('cbc:PaymentID').map((XmlElement e) => PaymentID.fromXml(e)!).toList(),
      chargeBearerCode: ChargeBearerCode.fromXml(xml.findElements('cbc:ChargeBearerCode').singleOrNull),
      serviceLevelCode: ServiceLevelCode.fromXml(xml.findElements('cbc:ServiceLevelCode').singleOrNull),
      cardAccount: xml.findElements('cac:CardAccount').map((XmlElement e) => CardAccount.fromXml(e)!).toList(),
      payerFinancialAccount: PayerFinancialAccount.fromXml(xml.findElements('cac:PayerFinancialAccount').singleOrNull),
      payeeFinancialAccount: PayeeFinancialAccount.fromXml(xml.findElements('cac:PayeeFinancialAccount').singleOrNull),
      creditAccount: CreditAccount.fromXml(xml.findElements('cac:CreditAccount').singleOrNull),
      paymentMandate: PaymentMandate.fromXml(xml.findElements('cac:PaymentMandate').singleOrNull),
      tradeFinancing: TradeFinancing.fromXml(xml.findElements('cac:TradeFinancing').singleOrNull),
      remittanceDocumentDistribution: xml.findElements('cac:RemittanceDocumentDistribution').map((XmlElement e) => RemittanceDocumentDistribution.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      paymentMeansCode.toXml(),
      paymentDueDate?.toXml(),
      paymentChannelCode?.toXml(),
      instructionID?.toXml(),
      ...instructionNote.map((InstructionNote e) => e.toXml()).toList(),
      ...paymentID.map((PaymentID e) => e.toXml()).toList(),
      chargeBearerCode?.toXml(),
      serviceLevelCode?.toXml(),
      ...cardAccount.map((CardAccount e) => e.toXml()).toList(),
      payerFinancialAccount?.toXml(),
      payeeFinancialAccount?.toXml(),
      creditAccount?.toXml(),
      paymentMandate?.toXml(),
      tradeFinancing?.toXml(),
      ...remittanceDocumentDistribution.map((RemittanceDocumentDistribution e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PaymentMeans',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

