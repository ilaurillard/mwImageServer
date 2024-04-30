import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Amount.dart';
import '../cac/AllowanceCharge.dart';

// A class to define a reference to a transaction line in a billing document.
class BillingReferenceLine {


  // An identifier for this transaction line in a billing document.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The monetary amount of the transaction line, including any allowances and charges but excluding taxes.
  final Amount? amount;

  // An allowance or charge applicable to the transaction line.
  final List<AllowanceCharge> allowanceCharge;

  BillingReferenceLine ({
    required this.iD,
    this.uBLExtensions,
    this.amount,
    this.allowanceCharge = const [],
  });

  static BillingReferenceLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return BillingReferenceLine (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?),
      allowanceCharge: (json['allowanceCharge'] as List? ?? []).map((dynamic d) => AllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'amount': amount?.toJson(),
      'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static BillingReferenceLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return BillingReferenceLine (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      amount: Amount.fromXml(xml.findElements('cbc:Amount').singleOrNull),
      allowanceCharge: xml.findElements('cac:AllowanceCharge').map((XmlElement e) => AllowanceCharge.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      amount?.toXml(),
      ...allowanceCharge.map((AllowanceCharge e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'BillingReferenceLine',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

