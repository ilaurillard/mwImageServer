import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PriceAmount.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/BaseQuantity.dart';
import '../cbc/PriceChangeReason.dart';
import '../cbc/PriceTypeCode.dart';
import '../cbc/PriceType.dart';
import '../cbc/OrderableUnitFactorRate.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/PriceList.dart';
import '../cac/AllowanceCharge.dart';
import '../cac/PricingExchangeRate.dart';

// A class to describe a price, expressed in a data structure containing multiple properties (compare with UnstructuredPrice).
class AlternativeCurrencyPrice {


  // The amount of the price.
  final PriceAmount priceAmount;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The quantity at which this price applies.
  final BaseQuantity? baseQuantity;

  // A reason for a price change.
  final List<PriceChangeReason> priceChangeReason;

  // The type of price, expressed as a code.
  final PriceTypeCode? priceTypeCode;

  // The type of price, expressed as text.
  final PriceType? priceType;

  // The factor by which the base price unit can be converted to the orderable unit.
  final OrderableUnitFactorRate? orderableUnitFactorRate;

  // A period during which this price is valid.
  final List<ValidityPeriod> validityPeriod;

  // Information about a price list applicable to this price.
  final PriceList? priceList;

  // An allowance or charge associated with this price.
  final List<AllowanceCharge> allowanceCharge;

  // The exchange rate applicable to this price, if it differs from the exchange rate applicable to the document as a whole.
  final PricingExchangeRate? pricingExchangeRate;

  // The price expressed in an alternative currency
  final List<AlternativeCurrencyPrice> alternativeCurrencyPrice;

  AlternativeCurrencyPrice ({
    required this.priceAmount,
    this.uBLExtensions,
    this.baseQuantity,
    this.priceChangeReason = const [],
    this.priceTypeCode,
    this.priceType,
    this.orderableUnitFactorRate,
    this.validityPeriod = const [],
    this.priceList,
    this.allowanceCharge = const [],
    this.pricingExchangeRate,
    this.alternativeCurrencyPrice = const [],
  });

  static AlternativeCurrencyPrice? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AlternativeCurrencyPrice (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      priceAmount: PriceAmount.fromJson(json['priceAmount'] as Map<String, dynamic>?)!,
      baseQuantity: BaseQuantity.fromJson(json['baseQuantity'] as Map<String, dynamic>?),
      priceChangeReason: (json['priceChangeReason'] as List? ?? []).map((dynamic d) => PriceChangeReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      priceTypeCode: PriceTypeCode.fromJson(json['priceTypeCode'] as Map<String, dynamic>?),
      priceType: PriceType.fromJson(json['priceType'] as Map<String, dynamic>?),
      orderableUnitFactorRate: OrderableUnitFactorRate.fromJson(json['orderableUnitFactorRate'] as Map<String, dynamic>?),
      validityPeriod: (json['validityPeriod'] as List? ?? []).map((dynamic d) => ValidityPeriod.fromJson(d as Map<String, dynamic>?)!).toList(),
      priceList: PriceList.fromJson(json['priceList'] as Map<String, dynamic>?),
      allowanceCharge: (json['allowanceCharge'] as List? ?? []).map((dynamic d) => AllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      pricingExchangeRate: PricingExchangeRate.fromJson(json['pricingExchangeRate'] as Map<String, dynamic>?),
      alternativeCurrencyPrice: (json['alternativeCurrencyPrice'] as List? ?? []).map((dynamic d) => AlternativeCurrencyPrice.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'priceAmount': priceAmount.toJson(),
      'baseQuantity': baseQuantity?.toJson(),
      'priceChangeReason': priceChangeReason.map((e) => e.toJson()).toList(),
      'priceTypeCode': priceTypeCode?.toJson(),
      'priceType': priceType?.toJson(),
      'orderableUnitFactorRate': orderableUnitFactorRate?.toJson(),
      'validityPeriod': validityPeriod.map((e) => e.toJson()).toList(),
      'priceList': priceList?.toJson(),
      'allowanceCharge': allowanceCharge.map((e) => e.toJson()).toList(),
      'pricingExchangeRate': pricingExchangeRate?.toJson(),
      'alternativeCurrencyPrice': alternativeCurrencyPrice.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AlternativeCurrencyPrice? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AlternativeCurrencyPrice (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      priceAmount: PriceAmount.fromXml(xml.findElements('cbc:PriceAmount').singleOrNull)!,
      baseQuantity: BaseQuantity.fromXml(xml.findElements('cbc:BaseQuantity').singleOrNull),
      priceChangeReason: xml.findElements('cbc:PriceChangeReason').map((XmlElement e) => PriceChangeReason.fromXml(e)!).toList(),
      priceTypeCode: PriceTypeCode.fromXml(xml.findElements('cbc:PriceTypeCode').singleOrNull),
      priceType: PriceType.fromXml(xml.findElements('cbc:PriceType').singleOrNull),
      orderableUnitFactorRate: OrderableUnitFactorRate.fromXml(xml.findElements('cbc:OrderableUnitFactorRate').singleOrNull),
      validityPeriod: xml.findElements('cac:ValidityPeriod').map((XmlElement e) => ValidityPeriod.fromXml(e)!).toList(),
      priceList: PriceList.fromXml(xml.findElements('cac:PriceList').singleOrNull),
      allowanceCharge: xml.findElements('cac:AllowanceCharge').map((XmlElement e) => AllowanceCharge.fromXml(e)!).toList(),
      pricingExchangeRate: PricingExchangeRate.fromXml(xml.findElements('cac:PricingExchangeRate').singleOrNull),
      alternativeCurrencyPrice: xml.findElements('cac:AlternativeCurrencyPrice').map((XmlElement e) => AlternativeCurrencyPrice.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      priceAmount.toXml(),
      baseQuantity?.toXml(),
      ...priceChangeReason.map((PriceChangeReason e) => e.toXml()).toList(),
      priceTypeCode?.toXml(),
      priceType?.toXml(),
      orderableUnitFactorRate?.toXml(),
      ...validityPeriod.map((ValidityPeriod e) => e.toXml()).toList(),
      priceList?.toXml(),
      ...allowanceCharge.map((AllowanceCharge e) => e.toXml()).toList(),
      pricingExchangeRate?.toXml(),
      ...alternativeCurrencyPrice.map((AlternativeCurrencyPrice e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'AlternativeCurrencyPrice',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

