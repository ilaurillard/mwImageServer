import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/SpecialTerms.dart';
import '../cbc/LossRiskResponsibilityCode.dart';
import '../cbc/LossRisk.dart';
import '../cbc/Amount.dart';
import '../cac/DeliveryLocation.dart';
import '../cac/AllowanceCharge.dart';

// A class for describing the terms and conditions applying to the delivery of goods.
class DeliveryTerms {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this description of delivery terms.
  final ID? iD;

  // A description of any terms or conditions relating to the delivery items.
  final List<SpecialTerms> specialTerms;

  // A code that identifies one of various responsibilities for loss risk in the execution of the delivery.
  final LossRiskResponsibilityCode? lossRiskResponsibilityCode;

  // A description of responsibility for risk of loss in execution of the delivery, expressed as text.
  final List<LossRisk> lossRisk;

  // The monetary amount covered by these delivery terms.
  final Amount? amount;

  // The location for the contracted delivery.
  final DeliveryLocation? deliveryLocation;

  // An allowance or charge covered by these delivery terms.
  final AllowanceCharge? allowanceCharge;

  DeliveryTerms ({
    this.uBLExtensions,
    this.iD,
    this.specialTerms = const [],
    this.lossRiskResponsibilityCode,
    this.lossRisk = const [],
    this.amount,
    this.deliveryLocation,
    this.allowanceCharge,
  });

  static DeliveryTerms? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DeliveryTerms (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      specialTerms: (json['specialTerms'] as List? ?? []).map((dynamic d) => SpecialTerms.fromJson(d as Map<String, dynamic>?)!).toList(),
      lossRiskResponsibilityCode: LossRiskResponsibilityCode.fromJson(json['lossRiskResponsibilityCode'] as Map<String, dynamic>?),
      lossRisk: (json['lossRisk'] as List? ?? []).map((dynamic d) => LossRisk.fromJson(d as Map<String, dynamic>?)!).toList(),
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?),
      deliveryLocation: DeliveryLocation.fromJson(json['deliveryLocation'] as Map<String, dynamic>?),
      allowanceCharge: AllowanceCharge.fromJson(json['allowanceCharge'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'specialTerms': specialTerms.map((e) => e.toJson()).toList(),
      'lossRiskResponsibilityCode': lossRiskResponsibilityCode?.toJson(),
      'lossRisk': lossRisk.map((e) => e.toJson()).toList(),
      'amount': amount?.toJson(),
      'deliveryLocation': deliveryLocation?.toJson(),
      'allowanceCharge': allowanceCharge?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DeliveryTerms? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DeliveryTerms (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      specialTerms: xml.findElements('cbc:SpecialTerms').map((XmlElement e) => SpecialTerms.fromXml(e)!).toList(),
      lossRiskResponsibilityCode: LossRiskResponsibilityCode.fromXml(xml.findElements('cbc:LossRiskResponsibilityCode').singleOrNull),
      lossRisk: xml.findElements('cbc:LossRisk').map((XmlElement e) => LossRisk.fromXml(e)!).toList(),
      amount: Amount.fromXml(xml.findElements('cbc:Amount').singleOrNull),
      deliveryLocation: DeliveryLocation.fromXml(xml.findElements('cac:DeliveryLocation').singleOrNull),
      allowanceCharge: AllowanceCharge.fromXml(xml.findElements('cac:AllowanceCharge').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      ...specialTerms.map((SpecialTerms e) => e.toXml()).toList(),
      lossRiskResponsibilityCode?.toXml(),
      ...lossRisk.map((LossRisk e) => e.toXml()).toList(),
      amount?.toXml(),
      deliveryLocation?.toXml(),
      allowanceCharge?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DeliveryTerms',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

