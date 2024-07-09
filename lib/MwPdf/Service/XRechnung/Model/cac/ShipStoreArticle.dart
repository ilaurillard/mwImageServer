// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Name.dart';
import '../cbc/Quantity.dart';
import '../cbc/OfficialUse.dart';
import '../cac/Stowage.dart';

// An article in the ship's stores during a shipment stage.
class ShipStoreArticle {


  // An indentifier for this ship store article.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A name for this ship store article.
  final Name? name;

  // The quantity of this ship store article.
  final Quantity? quantity;

  // A text describing the official use of this ship store article.
  final List<OfficialUse> officialUse;

  // The stowage or location on board of this ship store article.
  final Stowage? stowage;

  ShipStoreArticle ({
    required this.iD,
    this.uBLExtensions,
    this.name,
    this.quantity,
    this.officialUse = const [],
    this.stowage,
  });

  static ShipStoreArticle? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ShipStoreArticle (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      quantity: Quantity.fromJson(json['quantity'] as Map<String, dynamic>?),
      officialUse: (json['officialUse'] as List? ?? []).map((dynamic d) => OfficialUse.fromJson(d as Map<String, dynamic>?)!).toList(),
      stowage: Stowage.fromJson(json['stowage'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'name': name?.toJson(),
      'quantity': quantity?.toJson(),
      'officialUse': officialUse.map((e) => e.toJson()).toList(),
      'stowage': stowage?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ShipStoreArticle? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ShipStoreArticle (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      quantity: Quantity.fromXml(xml.findElements('cbc:Quantity').singleOrNull),
      officialUse: xml.findElements('cbc:OfficialUse').map((XmlElement e) => OfficialUse.fromXml(e)!).toList(),
      stowage: Stowage.fromXml(xml.findElements('cac:Stowage').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      name?.toXml(),
      quantity?.toXml(),
      ...officialUse.map((OfficialUse e) => e.toXml()),
      stowage?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ShipStoreArticle',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

