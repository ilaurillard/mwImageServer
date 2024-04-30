import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/PaidAmount.dart';
import '../cbc/ReceivedDate.dart';
import '../cbc/PaidDate.dart';
import '../cbc/PaidTime.dart';
import '../cbc/InstructionID.dart';

// A class to describe a payment.
class PrepaidPayment {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.iD,
    this.paidAmount,
    this.receivedDate,
    this.paidDate,
    this.paidTime,
    this.instructionID,
  });

  static PrepaidPayment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PrepaidPayment (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      paidAmount: PaidAmount.fromJson(json['paidAmount'] as Map<String, dynamic>?),
      receivedDate: ReceivedDate.fromJson(json['receivedDate'] as Map<String, dynamic>?),
      paidDate: PaidDate.fromJson(json['paidDate'] as Map<String, dynamic>?),
      paidTime: PaidTime.fromJson(json['paidTime'] as Map<String, dynamic>?),
      instructionID: InstructionID.fromJson(json['instructionID'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static PrepaidPayment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PrepaidPayment (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      paidAmount: PaidAmount.fromXml(xml.findElements('cbc:PaidAmount').singleOrNull),
      receivedDate: ReceivedDate.fromXml(xml.findElements('cbc:ReceivedDate').singleOrNull),
      paidDate: PaidDate.fromXml(xml.findElements('cbc:PaidDate').singleOrNull),
      paidTime: PaidTime.fromXml(xml.findElements('cbc:PaidTime').singleOrNull),
      instructionID: InstructionID.fromXml(xml.findElements('cbc:InstructionID').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      paidAmount?.toXml(),
      receivedDate?.toXml(),
      paidDate?.toXml(),
      paidTime?.toXml(),
      instructionID?.toXml(),

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

