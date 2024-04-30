import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/PaymentMeansID.dart';
import '../cbc/PrepaidPaymentReferenceID.dart';
import '../cbc/Note.dart';
import '../cbc/ReferenceEventCode.dart';
import '../cbc/SettlementDiscountPercent.dart';
import '../cbc/PenaltySurchargePercent.dart';
import '../cbc/PaymentPercent.dart';
import '../cbc/Amount.dart';
import '../cbc/SettlementDiscountAmount.dart';
import '../cbc/PenaltyAmount.dart';
import '../cbc/PaymentTermsDetailsURI.dart';
import '../cbc/PaymentDueDate.dart';
import '../cbc/InstallmentDueDate.dart';
import '../cbc/InvoicingPartyReference.dart';
import '../cac/SettlementPeriod.dart';
import '../cac/PenaltyPeriod.dart';
import '../cac/ExchangeRate.dart';
import '../cac/ValidityPeriod.dart';

// A class to describe a set of payment terms.
class DisbursementPaymentTerms {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this set of payment terms.
  final ID? iD;

  // An identifier for a means of payment associated with these payment terms.
  final List<PaymentMeansID> paymentMeansID;

  // An identifier for a reference to a prepaid payment.
  final PrepaidPaymentReferenceID? prepaidPaymentReferenceID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // A code signifying the event during which these terms are offered.
  final ReferenceEventCode? referenceEventCode;

  // The percentage for the settlement discount that is offered for payment under these payment terms.
  final SettlementDiscountPercent? settlementDiscountPercent;

  // The penalty for payment after the settlement period, expressed as a percentage of the payment.
  final PenaltySurchargePercent? penaltySurchargePercent;

  // The part of a payment, expressed as a percent, relevant for these payment terms.
  final PaymentPercent? paymentPercent;

  // The monetary amount covered by these payment terms.
  final Amount? amount;

  // The amount of a settlement discount offered for payment under these payment terms.
  final SettlementDiscountAmount? settlementDiscountAmount;

  // The monetary amount of the penalty for payment after the settlement period.
  final PenaltyAmount? penaltyAmount;

  // The Uniform Resource Identifier (URI) of a document providing additional details regarding these payment terms.
  final PaymentTermsDetailsURI? paymentTermsDetailsURI;

  // The due date for these payment terms.
  final PaymentDueDate? paymentDueDate;

  // The due date for an installment payment for these payment terms.
  final InstallmentDueDate? installmentDueDate;

  // A reference to the payment terms used by the invoicing party. This may have been requested of the payer by the payee to accompany its remittance.
  final InvoicingPartyReference? invoicingPartyReference;

  // The period during which settlement may occur.
  final SettlementPeriod? settlementPeriod;

  // The period during which penalties may apply.
  final PenaltyPeriod? penaltyPeriod;

  // The currency exchange rate for purposes of these payment terms.
  final ExchangeRate? exchangeRate;

  // The period during which these payment terms are valid.
  final ValidityPeriod? validityPeriod;

  DisbursementPaymentTerms ({
    this.uBLExtensions,
    this.iD,
    this.paymentMeansID = const [],
    this.prepaidPaymentReferenceID,
    this.note = const [],
    this.referenceEventCode,
    this.settlementDiscountPercent,
    this.penaltySurchargePercent,
    this.paymentPercent,
    this.amount,
    this.settlementDiscountAmount,
    this.penaltyAmount,
    this.paymentTermsDetailsURI,
    this.paymentDueDate,
    this.installmentDueDate,
    this.invoicingPartyReference,
    this.settlementPeriod,
    this.penaltyPeriod,
    this.exchangeRate,
    this.validityPeriod,
  });

  static DisbursementPaymentTerms? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DisbursementPaymentTerms (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      paymentMeansID: (json['paymentMeansID'] as List? ?? []).map((dynamic d) => PaymentMeansID.fromJson(d as Map<String, dynamic>?)!).toList(),
      prepaidPaymentReferenceID: PrepaidPaymentReferenceID.fromJson(json['prepaidPaymentReferenceID'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      referenceEventCode: ReferenceEventCode.fromJson(json['referenceEventCode'] as Map<String, dynamic>?),
      settlementDiscountPercent: SettlementDiscountPercent.fromJson(json['settlementDiscountPercent'] as Map<String, dynamic>?),
      penaltySurchargePercent: PenaltySurchargePercent.fromJson(json['penaltySurchargePercent'] as Map<String, dynamic>?),
      paymentPercent: PaymentPercent.fromJson(json['paymentPercent'] as Map<String, dynamic>?),
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?),
      settlementDiscountAmount: SettlementDiscountAmount.fromJson(json['settlementDiscountAmount'] as Map<String, dynamic>?),
      penaltyAmount: PenaltyAmount.fromJson(json['penaltyAmount'] as Map<String, dynamic>?),
      paymentTermsDetailsURI: PaymentTermsDetailsURI.fromJson(json['paymentTermsDetailsURI'] as Map<String, dynamic>?),
      paymentDueDate: PaymentDueDate.fromJson(json['paymentDueDate'] as Map<String, dynamic>?),
      installmentDueDate: InstallmentDueDate.fromJson(json['installmentDueDate'] as Map<String, dynamic>?),
      invoicingPartyReference: InvoicingPartyReference.fromJson(json['invoicingPartyReference'] as Map<String, dynamic>?),
      settlementPeriod: SettlementPeriod.fromJson(json['settlementPeriod'] as Map<String, dynamic>?),
      penaltyPeriod: PenaltyPeriod.fromJson(json['penaltyPeriod'] as Map<String, dynamic>?),
      exchangeRate: ExchangeRate.fromJson(json['exchangeRate'] as Map<String, dynamic>?),
      validityPeriod: ValidityPeriod.fromJson(json['validityPeriod'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'paymentMeansID': paymentMeansID.map((e) => e.toJson()).toList(),
      'prepaidPaymentReferenceID': prepaidPaymentReferenceID?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'referenceEventCode': referenceEventCode?.toJson(),
      'settlementDiscountPercent': settlementDiscountPercent?.toJson(),
      'penaltySurchargePercent': penaltySurchargePercent?.toJson(),
      'paymentPercent': paymentPercent?.toJson(),
      'amount': amount?.toJson(),
      'settlementDiscountAmount': settlementDiscountAmount?.toJson(),
      'penaltyAmount': penaltyAmount?.toJson(),
      'paymentTermsDetailsURI': paymentTermsDetailsURI?.toJson(),
      'paymentDueDate': paymentDueDate?.toJson(),
      'installmentDueDate': installmentDueDate?.toJson(),
      'invoicingPartyReference': invoicingPartyReference?.toJson(),
      'settlementPeriod': settlementPeriod?.toJson(),
      'penaltyPeriod': penaltyPeriod?.toJson(),
      'exchangeRate': exchangeRate?.toJson(),
      'validityPeriod': validityPeriod?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DisbursementPaymentTerms? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DisbursementPaymentTerms (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      paymentMeansID: xml.findElements('cbc:PaymentMeansID').map((XmlElement e) => PaymentMeansID.fromXml(e)!).toList(),
      prepaidPaymentReferenceID: PrepaidPaymentReferenceID.fromXml(xml.findElements('cbc:PrepaidPaymentReferenceID').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      referenceEventCode: ReferenceEventCode.fromXml(xml.findElements('cbc:ReferenceEventCode').singleOrNull),
      settlementDiscountPercent: SettlementDiscountPercent.fromXml(xml.findElements('cbc:SettlementDiscountPercent').singleOrNull),
      penaltySurchargePercent: PenaltySurchargePercent.fromXml(xml.findElements('cbc:PenaltySurchargePercent').singleOrNull),
      paymentPercent: PaymentPercent.fromXml(xml.findElements('cbc:PaymentPercent').singleOrNull),
      amount: Amount.fromXml(xml.findElements('cbc:Amount').singleOrNull),
      settlementDiscountAmount: SettlementDiscountAmount.fromXml(xml.findElements('cbc:SettlementDiscountAmount').singleOrNull),
      penaltyAmount: PenaltyAmount.fromXml(xml.findElements('cbc:PenaltyAmount').singleOrNull),
      paymentTermsDetailsURI: PaymentTermsDetailsURI.fromXml(xml.findElements('cbc:PaymentTermsDetailsURI').singleOrNull),
      paymentDueDate: PaymentDueDate.fromXml(xml.findElements('cbc:PaymentDueDate').singleOrNull),
      installmentDueDate: InstallmentDueDate.fromXml(xml.findElements('cbc:InstallmentDueDate').singleOrNull),
      invoicingPartyReference: InvoicingPartyReference.fromXml(xml.findElements('cbc:InvoicingPartyReference').singleOrNull),
      settlementPeriod: SettlementPeriod.fromXml(xml.findElements('cac:SettlementPeriod').singleOrNull),
      penaltyPeriod: PenaltyPeriod.fromXml(xml.findElements('cac:PenaltyPeriod').singleOrNull),
      exchangeRate: ExchangeRate.fromXml(xml.findElements('cac:ExchangeRate').singleOrNull),
      validityPeriod: ValidityPeriod.fromXml(xml.findElements('cac:ValidityPeriod').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      ...paymentMeansID.map((PaymentMeansID e) => e.toXml()).toList(),
      prepaidPaymentReferenceID?.toXml(),
      ...note.map((Note e) => e.toXml()).toList(),
      referenceEventCode?.toXml(),
      settlementDiscountPercent?.toXml(),
      penaltySurchargePercent?.toXml(),
      paymentPercent?.toXml(),
      amount?.toXml(),
      settlementDiscountAmount?.toXml(),
      penaltyAmount?.toXml(),
      paymentTermsDetailsURI?.toXml(),
      paymentDueDate?.toXml(),
      installmentDueDate?.toXml(),
      invoicingPartyReference?.toXml(),
      settlementPeriod?.toXml(),
      penaltyPeriod?.toXml(),
      exchangeRate?.toXml(),
      validityPeriod?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DisbursementPaymentTerms',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

