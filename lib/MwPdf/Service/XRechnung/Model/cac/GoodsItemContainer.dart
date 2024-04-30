import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Quantity.dart';
import '../cac/TransportEquipment.dart';

// A class defining how goods items are split across transport equipment.
class GoodsItemContainer {


  // An identifier for this goods item container.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The number of goods items loaded into or onto one piece of transport equipment as a total consignment or part of a consignment.
  final Quantity? quantity;

  // A piece of transport equipment used to contain a single goods item.
  final List<TransportEquipment> transportEquipment;

  GoodsItemContainer ({
    required this.iD,
    this.uBLExtensions,
    this.quantity,
    this.transportEquipment = const [],
  });

  static GoodsItemContainer? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return GoodsItemContainer (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      quantity: Quantity.fromJson(json['quantity'] as Map<String, dynamic>?),
      transportEquipment: (json['transportEquipment'] as List? ?? []).map((dynamic d) => TransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'quantity': quantity?.toJson(),
      'transportEquipment': transportEquipment.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static GoodsItemContainer? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return GoodsItemContainer (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      quantity: Quantity.fromXml(xml.findElements('cbc:Quantity').singleOrNull),
      transportEquipment: xml.findElements('cac:TransportEquipment').map((XmlElement e) => TransportEquipment.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      quantity?.toXml(),
      ...transportEquipment.map((TransportEquipment e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'GoodsItemContainer',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

