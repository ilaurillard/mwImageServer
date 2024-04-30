import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/ActionCode.dart';
import '../cbc/Description.dart';
import '../cac/DocumentReference.dart';

// A class to describe purchasing, sales, or payment conditions.
class TransactionConditions {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for conditions of the transaction, typically purchase/sales conditions.
  final ID? iD;

  // A code signifying a type of action relating to sales or payment conditions.
  final ActionCode? actionCode;

  // Text describing the transaction conditions.
  final List<Description> description;

  // A document associated with these transaction conditions.
  final List<DocumentReference> documentReference;

  TransactionConditions ({
    this.uBLExtensions,
    this.iD,
    this.actionCode,
    this.description = const [],
    this.documentReference = const [],
  });

  static TransactionConditions? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransactionConditions (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      actionCode: ActionCode.fromJson(json['actionCode'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'actionCode': actionCode?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TransactionConditions? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TransactionConditions (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      actionCode: ActionCode.fromXml(xml.findElements('cbc:ActionCode').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      actionCode?.toXml(),
      ...description.map((Description e) => e.toXml()).toList(),
      ...documentReference.map((DocumentReference e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TransactionConditions',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

