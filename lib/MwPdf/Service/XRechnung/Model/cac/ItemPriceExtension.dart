// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Amount.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/TaxInclusiveAmount.dart';
import '../cac/TaxTotal.dart';

// A class to describe a price extension, calculated by multiplying the price per unit by the quantity of items.
class ItemPriceExtension {


  // The amount of this price extension.
  final Amount amount;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The amount of this price extension inclusive of all taxes.
  final TaxInclusiveAmount? taxInclusiveAmount;

  // A total amount of taxes of a particular kind applicable to this price extension.
  final List<TaxTotal> taxTotal;

  ItemPriceExtension ({
    required this.amount,
    this.uBLExtensions,
    this.taxInclusiveAmount,
    this.taxTotal = const [],
  });

  static ItemPriceExtension? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ItemPriceExtension (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?)!,
      taxInclusiveAmount: TaxInclusiveAmount.fromJson(json['taxInclusiveAmount'] as Map<String, dynamic>?),
      taxTotal: (json['taxTotal'] as List? ?? []).map((dynamic d) => TaxTotal.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'amount': amount.toJson(),
      'taxInclusiveAmount': taxInclusiveAmount?.toJson(),
      'taxTotal': taxTotal.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ItemPriceExtension? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ItemPriceExtension (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      amount: Amount.fromXml(xml.findElements('cbc:Amount').singleOrNull)!,
      taxInclusiveAmount: TaxInclusiveAmount.fromXml(xml.findElements('cbc:TaxInclusiveAmount').singleOrNull),
      taxTotal: xml.findElements('cac:TaxTotal').map((XmlElement e) => TaxTotal.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      amount.toXml(),
      taxInclusiveAmount?.toXml(),
      ...taxTotal.map((TaxTotal e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ItemPriceExtension',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

