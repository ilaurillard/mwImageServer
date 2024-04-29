import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Amount.dart';
import '../cac/AllowanceCharge.dart';

// A class to define a reference to a transaction line in a billing document.
class BillingReferenceLine {


  // An identifier for this transaction line in a billing document.
  final ID iD;

  // The monetary amount of the transaction line, including any allowances and charges but excluding taxes.
  final Amount? amount;

  // An allowance or charge applicable to the transaction line.
  final List<AllowanceCharge> allowanceCharge;

  BillingReferenceLine ({
    required this.iD,
    this.amount,
    this.allowanceCharge = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'amount': amount?.toJson(),
      'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static BillingReferenceLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return BillingReferenceLine (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?),
      allowanceCharge: (json['allowanceCharge'] as List? ?? []).map((dynamic d) => AllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static BillingReferenceLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return BillingReferenceLine (
      iD: null,
      amount: null,
      allowanceCharge: null,
    );
  }

}

