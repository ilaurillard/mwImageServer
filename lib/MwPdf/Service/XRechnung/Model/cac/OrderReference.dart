import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/SalesOrderID.dart';
import '../cbc/CopyIndicator.dart';
import '../cbc/UUID.dart';
import '../cbc/IssueDate.dart';
import '../cbc/IssueTime.dart';
import '../cbc/CustomerReference.dart';
import '../cbc/OrderTypeCode.dart';
import '../cac/DocumentReference.dart';

// A class to define a reference to an Order.
class OrderReference {


  // An identifier for this order reference, assigned by the buyer.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this order reference, assigned by the seller.
  final SalesOrderID? salesOrderID;

  // Indicates whether the referenced Order is a copy (true) or the original (false).
  final CopyIndicator? copyIndicator;

  // A universally unique identifier for this order reference.
  final UUID? uUID;

  // The date on which the referenced Order was issued.
  final IssueDate? issueDate;

  // The time at which the referenced Order was issued.
  final IssueTime? issueTime;

  // Text used for tagging purchasing card transactions.
  final CustomerReference? customerReference;

  // A code signifying the type of the referenced Order.
  final OrderTypeCode? orderTypeCode;

  // A document associated with this reference to an Order.
  final DocumentReference? documentReference;

  OrderReference ({
    required this.iD,
    this.uBLExtensions,
    this.salesOrderID,
    this.copyIndicator,
    this.uUID,
    this.issueDate,
    this.issueTime,
    this.customerReference,
    this.orderTypeCode,
    this.documentReference,
  });

  static OrderReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OrderReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      salesOrderID: SalesOrderID.fromJson(json['salesOrderID'] as Map<String, dynamic>?),
      copyIndicator: CopyIndicator.fromJson(json['copyIndicator'] as Map<String, dynamic>?),
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      issueDate: IssueDate.fromJson(json['issueDate'] as Map<String, dynamic>?),
      issueTime: IssueTime.fromJson(json['issueTime'] as Map<String, dynamic>?),
      customerReference: CustomerReference.fromJson(json['customerReference'] as Map<String, dynamic>?),
      orderTypeCode: OrderTypeCode.fromJson(json['orderTypeCode'] as Map<String, dynamic>?),
      documentReference: DocumentReference.fromJson(json['documentReference'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'salesOrderID': salesOrderID?.toJson(),
      'copyIndicator': copyIndicator?.toJson(),
      'uUID': uUID?.toJson(),
      'issueDate': issueDate?.toJson(),
      'issueTime': issueTime?.toJson(),
      'customerReference': customerReference?.toJson(),
      'orderTypeCode': orderTypeCode?.toJson(),
      'documentReference': documentReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OrderReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OrderReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      salesOrderID: SalesOrderID.fromXml(xml.findElements('cbc:SalesOrderID').singleOrNull),
      copyIndicator: CopyIndicator.fromXml(xml.findElements('cbc:CopyIndicator').singleOrNull),
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      issueDate: IssueDate.fromXml(xml.findElements('cbc:IssueDate').singleOrNull),
      issueTime: IssueTime.fromXml(xml.findElements('cbc:IssueTime').singleOrNull),
      customerReference: CustomerReference.fromXml(xml.findElements('cbc:CustomerReference').singleOrNull),
      orderTypeCode: OrderTypeCode.fromXml(xml.findElements('cbc:OrderTypeCode').singleOrNull),
      documentReference: DocumentReference.fromXml(xml.findElements('cac:DocumentReference').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      salesOrderID?.toXml(),
      copyIndicator?.toXml(),
      uUID?.toXml(),
      issueDate?.toXml(),
      issueTime?.toXml(),
      customerReference?.toXml(),
      orderTypeCode?.toXml(),
      documentReference?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OrderReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

