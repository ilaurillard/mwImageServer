// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/PaidAmount.dart';
import '../cbc/PaidCashAmount.dart';
import '../cbc/CashChangeAmount.dart';
import '../cbc/ReceivedDate.dart';
import '../cbc/PaidDate.dart';
import '../cbc/PaidTime.dart';
import '../cbc/InstructionID.dart';
import '../cbc/MerchantID.dart';
import '../cbc/AuthorizationID.dart';
import '../cbc/TransactionID.dart';
import '../cbc/PaymentTerminalID.dart';
import '../cac/ExchangeRate.dart';

// A class to describe a payment.
class PrepaidPayment {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this payment.
  final ID? iD;

  // The amount of this payment.
  final PaidAmount? paidAmount;

  // The amount given by the customer in cash or cash equivalents, if different from the payable amount. The Paid Amount = Paid Cash Amount - Cash Change Amount.
  final PaidCashAmount? paidCashAmount;

  // The change returned to the customer when the paid cash amount is more than the payable amount.
  final CashChangeAmount? cashChangeAmount;

  // The date on which this payment was received.
  final ReceivedDate? receivedDate;

  // The date on which this payment was made.
  final PaidDate? paidDate;

  // The time at which this payment was made.
  final PaidTime? paidTime;

  // An identifier for the payment instruction.
  final InstructionID? instructionID;

  // An identifier for the merchant who handled the payment.
  final MerchantID? merchantID;

  // The authorization identifier for this payment.
  final AuthorizationID? authorizationID;

  // The transaction identifier for this payment.
  final TransactionID? transactionID;

  // An identifier for the payment terminal used for this payment.
  final PaymentTerminalID? paymentTerminalID;

  // The exchange rate applicable to this payment, if the payment currency differs from the document currency.
  final ExchangeRate? exchangeRate;

  PrepaidPayment ({
    this.uBLExtensions,
    this.iD,
    this.paidAmount,
    this.paidCashAmount,
    this.cashChangeAmount,
    this.receivedDate,
    this.paidDate,
    this.paidTime,
    this.instructionID,
    this.merchantID,
    this.authorizationID,
    this.transactionID,
    this.paymentTerminalID,
    this.exchangeRate,
  });

  static PrepaidPayment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PrepaidPayment (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      paidAmount: PaidAmount.fromJson(json['paidAmount'] as Map<String, dynamic>?),
      paidCashAmount: PaidCashAmount.fromJson(json['paidCashAmount'] as Map<String, dynamic>?),
      cashChangeAmount: CashChangeAmount.fromJson(json['cashChangeAmount'] as Map<String, dynamic>?),
      receivedDate: ReceivedDate.fromJson(json['receivedDate'] as Map<String, dynamic>?),
      paidDate: PaidDate.fromJson(json['paidDate'] as Map<String, dynamic>?),
      paidTime: PaidTime.fromJson(json['paidTime'] as Map<String, dynamic>?),
      instructionID: InstructionID.fromJson(json['instructionID'] as Map<String, dynamic>?),
      merchantID: MerchantID.fromJson(json['merchantID'] as Map<String, dynamic>?),
      authorizationID: AuthorizationID.fromJson(json['authorizationID'] as Map<String, dynamic>?),
      transactionID: TransactionID.fromJson(json['transactionID'] as Map<String, dynamic>?),
      paymentTerminalID: PaymentTerminalID.fromJson(json['paymentTerminalID'] as Map<String, dynamic>?),
      exchangeRate: ExchangeRate.fromJson(json['exchangeRate'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'paidAmount': paidAmount?.toJson(),
      'paidCashAmount': paidCashAmount?.toJson(),
      'cashChangeAmount': cashChangeAmount?.toJson(),
      'receivedDate': receivedDate?.toJson(),
      'paidDate': paidDate?.toJson(),
      'paidTime': paidTime?.toJson(),
      'instructionID': instructionID?.toJson(),
      'merchantID': merchantID?.toJson(),
      'authorizationID': authorizationID?.toJson(),
      'transactionID': transactionID?.toJson(),
      'paymentTerminalID': paymentTerminalID?.toJson(),
      'exchangeRate': exchangeRate?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PrepaidPayment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PrepaidPayment (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      paidAmount: PaidAmount.fromXml(xml.findElements('cbc:PaidAmount').singleOrNull),
      paidCashAmount: PaidCashAmount.fromXml(xml.findElements('cbc:PaidCashAmount').singleOrNull),
      cashChangeAmount: CashChangeAmount.fromXml(xml.findElements('cbc:CashChangeAmount').singleOrNull),
      receivedDate: ReceivedDate.fromXml(xml.findElements('cbc:ReceivedDate').singleOrNull),
      paidDate: PaidDate.fromXml(xml.findElements('cbc:PaidDate').singleOrNull),
      paidTime: PaidTime.fromXml(xml.findElements('cbc:PaidTime').singleOrNull),
      instructionID: InstructionID.fromXml(xml.findElements('cbc:InstructionID').singleOrNull),
      merchantID: MerchantID.fromXml(xml.findElements('cbc:MerchantID').singleOrNull),
      authorizationID: AuthorizationID.fromXml(xml.findElements('cbc:AuthorizationID').singleOrNull),
      transactionID: TransactionID.fromXml(xml.findElements('cbc:TransactionID').singleOrNull),
      paymentTerminalID: PaymentTerminalID.fromXml(xml.findElements('cbc:PaymentTerminalID').singleOrNull),
      exchangeRate: ExchangeRate.fromXml(xml.findElements('cac:ExchangeRate').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      paidAmount?.toXml(),
      paidCashAmount?.toXml(),
      cashChangeAmount?.toXml(),
      receivedDate?.toXml(),
      paidDate?.toXml(),
      paidTime?.toXml(),
      instructionID?.toXml(),
      merchantID?.toXml(),
      authorizationID?.toXml(),
      transactionID?.toXml(),
      paymentTerminalID?.toXml(),
      exchangeRate?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PrepaidPayment',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

