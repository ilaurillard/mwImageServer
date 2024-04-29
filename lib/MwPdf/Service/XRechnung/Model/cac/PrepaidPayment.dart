import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
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

  static PrepaidPayment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PrepaidPayment (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      paidAmount: PaidAmount.fromJson(json['paidAmount'] as Map<String, dynamic>?),
      receivedDate: ReceivedDate.fromJson(json['receivedDate'] as Map<String, dynamic>?),
      paidDate: PaidDate.fromJson(json['paidDate'] as Map<String, dynamic>?),
      paidTime: PaidTime.fromJson(json['paidTime'] as Map<String, dynamic>?),
      instructionID: InstructionID.fromJson(json['instructionID'] as Map<String, dynamic>?),
    );
  }

  static PrepaidPayment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PrepaidPayment (
      iD: null,
      paidAmount: null,
      receivedDate: null,
      paidDate: null,
      paidTime: null,
      instructionID: null,
    );
  }

}

