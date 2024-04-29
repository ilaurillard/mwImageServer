import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/LineID.dart';
import '../cbc/SalesOrderLineID.dart';
import '../cbc/UUID.dart';
import '../cbc/LineStatusCode.dart';
import '../cac/OrderReference.dart';

// A class to define a reference to an order line.
class OrderLineReference {


  // An identifier for the referenced order line, assigned by the buyer.
  final LineID lineID;

  // An identifier for the referenced order line, assigned by the seller.
  final SalesOrderLineID? salesOrderLineID;

  // A universally unique identifier for this order line reference.
  final UUID? uUID;

  // A code signifying the status of the referenced order line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // A reference to the Order containing the referenced order line.
  final OrderReference? orderReference;

  OrderLineReference ({
    required this.lineID,
    this.salesOrderLineID,
    this.uUID,
    this.lineStatusCode,
    this.orderReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'lineID': lineID.toJson(),
      'salesOrderLineID': salesOrderLineID?.toJson(),
      'uUID': uUID?.toJson(),
      'lineStatusCode': lineStatusCode?.toJson(),
      'orderReference': orderReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OrderLineReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OrderLineReference (
      lineID: LineID.fromJson(json['lineID'] as Map<String, dynamic>?)!,
      salesOrderLineID: SalesOrderLineID.fromJson(json['salesOrderLineID'] as Map<String, dynamic>?),
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      lineStatusCode: LineStatusCode.fromJson(json['lineStatusCode'] as Map<String, dynamic>?),
      orderReference: OrderReference.fromJson(json['orderReference'] as Map<String, dynamic>?),
    );
  }

  static OrderLineReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return OrderLineReference (
      lineID: null,
      salesOrderLineID: null,
      uUID: null,
      lineStatusCode: null,
      orderReference: null,
    );
  }

}

