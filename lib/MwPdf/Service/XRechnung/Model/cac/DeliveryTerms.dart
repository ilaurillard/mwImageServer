import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/SpecialTerms.dart';
import '../cbc/LossRiskResponsibilityCode.dart';
import '../cbc/LossRisk.dart';
import '../cbc/Amount.dart';
import '../cac/DeliveryLocation.dart';
import '../cac/AllowanceCharge.dart';

// A class for describing the terms and conditions applying to the delivery of goods.
class DeliveryTerms {


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
    this.iD,
    this.specialTerms = const [],
    this.lossRiskResponsibilityCode,
    this.lossRisk = const [],
    this.amount,
    this.deliveryLocation,
    this.allowanceCharge,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

  static DeliveryTerms? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DeliveryTerms (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      specialTerms: (json['specialTerms'] as List? ?? []).map((dynamic d) => SpecialTerms.fromJson(d as Map<String, dynamic>?)!).toList(),
      lossRiskResponsibilityCode: LossRiskResponsibilityCode.fromJson(json['lossRiskResponsibilityCode'] as Map<String, dynamic>?),
      lossRisk: (json['lossRisk'] as List? ?? []).map((dynamic d) => LossRisk.fromJson(d as Map<String, dynamic>?)!).toList(),
      amount: Amount.fromJson(json['amount'] as Map<String, dynamic>?),
      deliveryLocation: DeliveryLocation.fromJson(json['deliveryLocation'] as Map<String, dynamic>?),
      allowanceCharge: AllowanceCharge.fromJson(json['allowanceCharge'] as Map<String, dynamic>?),
    );
  }

  static DeliveryTerms? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return DeliveryTerms (
      iD: null,
      specialTerms: null,
      lossRiskResponsibilityCode: null,
      lossRisk: null,
      amount: null,
      deliveryLocation: null,
      allowanceCharge: null,
    );
  }

}

