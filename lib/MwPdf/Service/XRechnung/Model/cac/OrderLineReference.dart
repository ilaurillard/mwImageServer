import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/LineID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/SalesOrderLineID.dart';
import '../cbc/UUID.dart';
import '../cbc/LineStatusCode.dart';
import '../cac/OrderReference.dart';

// A class to define a reference to an order line.
class OrderLineReference {


  // An identifier for the referenced order line, assigned by the buyer.
  final LineID lineID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.salesOrderLineID,
    this.uUID,
    this.lineStatusCode,
    this.orderReference,
  });

  static OrderLineReference? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OrderLineReference (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      lineID: LineID.fromJson(json['lineID'] as Map<String, dynamic>?)!,
      salesOrderLineID: SalesOrderLineID.fromJson(json['salesOrderLineID'] as Map<String, dynamic>?),
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      lineStatusCode: LineStatusCode.fromJson(json['lineStatusCode'] as Map<String, dynamic>?),
      orderReference: OrderReference.fromJson(json['orderReference'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'lineID': lineID.toJson(),
      'salesOrderLineID': salesOrderLineID?.toJson(),
      'uUID': uUID?.toJson(),
      'lineStatusCode': lineStatusCode?.toJson(),
      'orderReference': orderReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OrderLineReference? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OrderLineReference (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      lineID: LineID.fromXml(xml.findElements('cbc:LineID').singleOrNull)!,
      salesOrderLineID: SalesOrderLineID.fromXml(xml.findElements('cbc:SalesOrderLineID').singleOrNull),
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      lineStatusCode: LineStatusCode.fromXml(xml.findElements('cbc:LineStatusCode').singleOrNull),
      orderReference: OrderReference.fromXml(xml.findElements('cac:OrderReference').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      lineID.toXml(),
      salesOrderLineID?.toXml(),
      uUID?.toXml(),
      lineStatusCode?.toXml(),
      orderReference?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OrderLineReference',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

