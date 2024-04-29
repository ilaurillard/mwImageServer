import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/BatchQuantity.dart';
import '../cbc/ConsumerUnitQuantity.dart';
import '../cbc/HazardousRiskIndicator.dart';

// A class to describe a delivery unit.
class DeliveryUnit {


  // The quantity of ordered Items that constitutes a batch for delivery purposes.
  final BatchQuantity batchQuantity;

  // The quantity of units in the Delivery Unit expressed in the units used by the consumer.
  final ConsumerUnitQuantity? consumerUnitQuantity;

  // An indication that the transported goods are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  DeliveryUnit ({
    required this.batchQuantity,
    this.consumerUnitQuantity,
    this.hazardousRiskIndicator,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'batchQuantity': batchQuantity.toJson(),
      'consumerUnitQuantity': consumerUnitQuantity?.toJson(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DeliveryUnit? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DeliveryUnit (
      batchQuantity: BatchQuantity.fromJson(json['batchQuantity'] as Map<String, dynamic>?)!,
      consumerUnitQuantity: ConsumerUnitQuantity.fromJson(json['consumerUnitQuantity'] as Map<String, dynamic>?),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
    );
  }

  static DeliveryUnit? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return DeliveryUnit (
      batchQuantity: null,
      consumerUnitQuantity: null,
      hazardousRiskIndicator: null,
    );
  }

}

