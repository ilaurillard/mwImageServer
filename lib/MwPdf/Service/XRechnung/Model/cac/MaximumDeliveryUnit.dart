// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/BatchQuantity.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ConsumerUnitQuantity.dart';
import '../cbc/HazardousRiskIndicator.dart';

// A class to describe a delivery unit.
class MaximumDeliveryUnit {


  // The quantity of ordered Items that constitutes a batch for delivery purposes.
  final BatchQuantity batchQuantity;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The quantity of units in the Delivery Unit expressed in the units used by the consumer.
  final ConsumerUnitQuantity? consumerUnitQuantity;

  // An indication that the transported goods are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  MaximumDeliveryUnit ({
    required this.batchQuantity,
    this.uBLExtensions,
    this.consumerUnitQuantity,
    this.hazardousRiskIndicator,
  });

  static MaximumDeliveryUnit? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MaximumDeliveryUnit (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      batchQuantity: BatchQuantity.fromJson(json['batchQuantity'] as Map<String, dynamic>?)!,
      consumerUnitQuantity: ConsumerUnitQuantity.fromJson(json['consumerUnitQuantity'] as Map<String, dynamic>?),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'batchQuantity': batchQuantity.toJson(),
      'consumerUnitQuantity': consumerUnitQuantity?.toJson(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MaximumDeliveryUnit? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return MaximumDeliveryUnit (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      batchQuantity: BatchQuantity.fromXml(xml.findElements('cbc:BatchQuantity').singleOrNull)!,
      consumerUnitQuantity: ConsumerUnitQuantity.fromXml(xml.findElements('cbc:ConsumerUnitQuantity').singleOrNull),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      batchQuantity.toXml(),
      consumerUnitQuantity?.toXml(),
      hazardousRiskIndicator?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'MaximumDeliveryUnit',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

