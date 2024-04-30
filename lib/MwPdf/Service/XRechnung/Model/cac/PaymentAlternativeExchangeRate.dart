import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/SourceCurrencyCode.dart';
import '../cbc/TargetCurrencyCode.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/SourceCurrencyBaseRate.dart';
import '../cbc/TargetCurrencyBaseRate.dart';
import '../cbc/ExchangeMarketID.dart';
import '../cbc/CalculationRate.dart';
import '../cbc/MathematicOperatorCode.dart';
import '../cbc/Date.dart';
import '../cac/ForeignExchangeContract.dart';

// A class to define an exchange rate.
class PaymentAlternativeExchangeRate {


  // The reference currency for this exchange rate; the currency from which the exchange is being made.
  final SourceCurrencyCode sourceCurrencyCode;

  // The target currency for this exchange rate; the currency to which the exchange is being made.
  final TargetCurrencyCode targetCurrencyCode;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // In the case of a source currency with denominations of small value, the unit base.
  final SourceCurrencyBaseRate? sourceCurrencyBaseRate;

  // In the case of a target currency with denominations of small value, the unit base.
  final TargetCurrencyBaseRate? targetCurrencyBaseRate;

  // An identifier for the currency exchange market used as the source of this exchange rate.
  final ExchangeMarketID? exchangeMarketID;

  // The factor applied to the source currency to calculate the target currency.
  final CalculationRate? calculationRate;

  // A code signifying whether the calculation rate is a multiplier or a divisor.
  final MathematicOperatorCode? mathematicOperatorCode;

  // The date on which the exchange rate was established.
  final Date? date;

  // A contract for foreign exchange.
  final ForeignExchangeContract? foreignExchangeContract;

  PaymentAlternativeExchangeRate ({
    required this.sourceCurrencyCode,
    required this.targetCurrencyCode,
    this.uBLExtensions,
    this.sourceCurrencyBaseRate,
    this.targetCurrencyBaseRate,
    this.exchangeMarketID,
    this.calculationRate,
    this.mathematicOperatorCode,
    this.date,
    this.foreignExchangeContract,
  });

  static PaymentAlternativeExchangeRate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PaymentAlternativeExchangeRate (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      sourceCurrencyCode: SourceCurrencyCode.fromJson(json['sourceCurrencyCode'] as Map<String, dynamic>?)!,
      sourceCurrencyBaseRate: SourceCurrencyBaseRate.fromJson(json['sourceCurrencyBaseRate'] as Map<String, dynamic>?),
      targetCurrencyCode: TargetCurrencyCode.fromJson(json['targetCurrencyCode'] as Map<String, dynamic>?)!,
      targetCurrencyBaseRate: TargetCurrencyBaseRate.fromJson(json['targetCurrencyBaseRate'] as Map<String, dynamic>?),
      exchangeMarketID: ExchangeMarketID.fromJson(json['exchangeMarketID'] as Map<String, dynamic>?),
      calculationRate: CalculationRate.fromJson(json['calculationRate'] as Map<String, dynamic>?),
      mathematicOperatorCode: MathematicOperatorCode.fromJson(json['mathematicOperatorCode'] as Map<String, dynamic>?),
      date: Date.fromJson(json['date'] as Map<String, dynamic>?),
      foreignExchangeContract: ForeignExchangeContract.fromJson(json['foreignExchangeContract'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'sourceCurrencyCode': sourceCurrencyCode.toJson(),
      'sourceCurrencyBaseRate': sourceCurrencyBaseRate?.toJson(),
      'targetCurrencyCode': targetCurrencyCode.toJson(),
      'targetCurrencyBaseRate': targetCurrencyBaseRate?.toJson(),
      'exchangeMarketID': exchangeMarketID?.toJson(),
      'calculationRate': calculationRate?.toJson(),
      'mathematicOperatorCode': mathematicOperatorCode?.toJson(),
      'date': date?.toJson(),
      'foreignExchangeContract': foreignExchangeContract?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PaymentAlternativeExchangeRate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PaymentAlternativeExchangeRate (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      sourceCurrencyCode: SourceCurrencyCode.fromXml(xml.findElements('cbc:SourceCurrencyCode').singleOrNull)!,
      sourceCurrencyBaseRate: SourceCurrencyBaseRate.fromXml(xml.findElements('cbc:SourceCurrencyBaseRate').singleOrNull),
      targetCurrencyCode: TargetCurrencyCode.fromXml(xml.findElements('cbc:TargetCurrencyCode').singleOrNull)!,
      targetCurrencyBaseRate: TargetCurrencyBaseRate.fromXml(xml.findElements('cbc:TargetCurrencyBaseRate').singleOrNull),
      exchangeMarketID: ExchangeMarketID.fromXml(xml.findElements('cbc:ExchangeMarketID').singleOrNull),
      calculationRate: CalculationRate.fromXml(xml.findElements('cbc:CalculationRate').singleOrNull),
      mathematicOperatorCode: MathematicOperatorCode.fromXml(xml.findElements('cbc:MathematicOperatorCode').singleOrNull),
      date: Date.fromXml(xml.findElements('cbc:Date').singleOrNull),
      foreignExchangeContract: ForeignExchangeContract.fromXml(xml.findElements('cac:ForeignExchangeContract').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'PaymentAlternativeExchangeRate',
        'cac',
      ),
    );
  }
}

