import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/PriceAmount.dart';
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
class Price {


  // The amount of the price.
  final PriceAmount priceAmount;

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

  Price ({
    required this.priceAmount,
    this.baseQuantity,
    this.priceChangeReason = const [],
    this.priceTypeCode,
    this.priceType,
    this.orderableUnitFactorRate,
    this.validityPeriod = const [],
    this.priceList,
    this.allowanceCharge = const [],
    this.pricingExchangeRate,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Price? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Price (
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
    );
  }

  static Price? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Price (
      priceAmount: null,
      baseQuantity: null,
      priceChangeReason: null,
      priceTypeCode: null,
      priceType: null,
      orderableUnitFactorRate: null,
      validityPeriod: null,
      priceList: null,
      allowanceCharge: null,
      pricingExchangeRate: null,
    );
  }

}

