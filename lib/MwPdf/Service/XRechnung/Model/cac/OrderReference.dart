import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
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
    this.salesOrderID,
    this.copyIndicator,
    this.uUID,
    this.issueDate,
    this.issueTime,
    this.customerReference,
    this.orderTypeCode,
    this.documentReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

  static OrderReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OrderReference (
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

  static OrderReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return OrderReference (
      iD: null,
      salesOrderID: null,
      copyIndicator: null,
      uUID: null,
      issueDate: null,
      issueTime: null,
      customerReference: null,
      orderTypeCode: null,
      documentReference: null,
    );
  }

}

