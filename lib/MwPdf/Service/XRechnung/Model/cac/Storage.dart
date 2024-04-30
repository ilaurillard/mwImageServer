import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Name.dart';
import '../cbc/GateID.dart';
import '../cbc/AirFlowPercent.dart';
import '../cbc/HumidityPercent.dart';
import '../cbc/AnimalFoodApprovedIndicator.dart';
import '../cbc/HumanFoodApprovedIndicator.dart';
import '../cbc/DangerousGoodsApprovedIndicator.dart';
import '../cbc/RefrigeratedIndicator.dart';
import '../cbc/PowerIndicator.dart';
import '../cac/MinimumTemperature.dart';
import '../cac/MaximumTemperature.dart';
import '../cac/Certificate.dart';

// A class to describe a storage and storage requirements
class Storage {


  // An identifier for this storage.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The common name this storage
  final Name? name;

  // An identifier for the agreed gate to enter, deliver or pick up at this storage
  final GateID? gateID;

  // The percent of the airflow within this storage.
  final AirFlowPercent? airFlowPercent;

  // The percent humidity within this storage.
  final HumidityPercent? humidityPercent;

  // An indicator that this storage is approved for animal food (true) or not (false).
  final AnimalFoodApprovedIndicator? animalFoodApprovedIndicator;

  // An indicator that this storage is approved for human food (true) or not (false).
  final HumanFoodApprovedIndicator? humanFoodApprovedIndicator;

  // An indicator that this stroage is approved for dangerous goods (true) or not (false).
  final DangerousGoodsApprovedIndicator? dangerousGoodsApprovedIndicator;

  // An indicator that storage is refrigerated (true) or not (false).
  final RefrigeratedIndicator? refrigeratedIndicator;

  // An indicator that this storage can supply power (true) or not (false).
  final PowerIndicator? powerIndicator;

  // The minimum allowable operating temperature for this refriguated storage.
  final MinimumTemperature? minimumTemperature;

  // The maximum allowable operating temperature for this refriguated storage.
  final MaximumTemperature? maximumTemperature;

  // A certificate associated with this storage
  final List<Certificate> certificate;

  Storage ({
    required this.iD,
    this.uBLExtensions,
    this.name,
    this.gateID,
    this.airFlowPercent,
    this.humidityPercent,
    this.animalFoodApprovedIndicator,
    this.humanFoodApprovedIndicator,
    this.dangerousGoodsApprovedIndicator,
    this.refrigeratedIndicator,
    this.powerIndicator,
    this.minimumTemperature,
    this.maximumTemperature,
    this.certificate = const [],
  });

  static Storage? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Storage (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      gateID: GateID.fromJson(json['gateID'] as Map<String, dynamic>?),
      airFlowPercent: AirFlowPercent.fromJson(json['airFlowPercent'] as Map<String, dynamic>?),
      humidityPercent: HumidityPercent.fromJson(json['humidityPercent'] as Map<String, dynamic>?),
      animalFoodApprovedIndicator: AnimalFoodApprovedIndicator.fromJson(json['animalFoodApprovedIndicator'] as Map<String, dynamic>?),
      humanFoodApprovedIndicator: HumanFoodApprovedIndicator.fromJson(json['humanFoodApprovedIndicator'] as Map<String, dynamic>?),
      dangerousGoodsApprovedIndicator: DangerousGoodsApprovedIndicator.fromJson(json['dangerousGoodsApprovedIndicator'] as Map<String, dynamic>?),
      refrigeratedIndicator: RefrigeratedIndicator.fromJson(json['refrigeratedIndicator'] as Map<String, dynamic>?),
      powerIndicator: PowerIndicator.fromJson(json['powerIndicator'] as Map<String, dynamic>?),
      minimumTemperature: MinimumTemperature.fromJson(json['minimumTemperature'] as Map<String, dynamic>?),
      maximumTemperature: MaximumTemperature.fromJson(json['maximumTemperature'] as Map<String, dynamic>?),
      certificate: (json['certificate'] as List? ?? []).map((dynamic d) => Certificate.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'name': name?.toJson(),
      'gateID': gateID?.toJson(),
      'airFlowPercent': airFlowPercent?.toJson(),
      'humidityPercent': humidityPercent?.toJson(),
      'animalFoodApprovedIndicator': animalFoodApprovedIndicator?.toJson(),
      'humanFoodApprovedIndicator': humanFoodApprovedIndicator?.toJson(),
      'dangerousGoodsApprovedIndicator': dangerousGoodsApprovedIndicator?.toJson(),
      'refrigeratedIndicator': refrigeratedIndicator?.toJson(),
      'powerIndicator': powerIndicator?.toJson(),
      'minimumTemperature': minimumTemperature?.toJson(),
      'maximumTemperature': maximumTemperature?.toJson(),
      'certificate': certificate.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Storage? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Storage (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      gateID: GateID.fromXml(xml.findElements('cbc:GateID').singleOrNull),
      airFlowPercent: AirFlowPercent.fromXml(xml.findElements('cbc:AirFlowPercent').singleOrNull),
      humidityPercent: HumidityPercent.fromXml(xml.findElements('cbc:HumidityPercent').singleOrNull),
      animalFoodApprovedIndicator: AnimalFoodApprovedIndicator.fromXml(xml.findElements('cbc:AnimalFoodApprovedIndicator').singleOrNull),
      humanFoodApprovedIndicator: HumanFoodApprovedIndicator.fromXml(xml.findElements('cbc:HumanFoodApprovedIndicator').singleOrNull),
      dangerousGoodsApprovedIndicator: DangerousGoodsApprovedIndicator.fromXml(xml.findElements('cbc:DangerousGoodsApprovedIndicator').singleOrNull),
      refrigeratedIndicator: RefrigeratedIndicator.fromXml(xml.findElements('cbc:RefrigeratedIndicator').singleOrNull),
      powerIndicator: PowerIndicator.fromXml(xml.findElements('cbc:PowerIndicator').singleOrNull),
      minimumTemperature: MinimumTemperature.fromXml(xml.findElements('cac:MinimumTemperature').singleOrNull),
      maximumTemperature: MaximumTemperature.fromXml(xml.findElements('cac:MaximumTemperature').singleOrNull),
      certificate: xml.findElements('cac:Certificate').map((XmlElement e) => Certificate.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      name?.toXml(),
      gateID?.toXml(),
      airFlowPercent?.toXml(),
      humidityPercent?.toXml(),
      animalFoodApprovedIndicator?.toXml(),
      humanFoodApprovedIndicator?.toXml(),
      dangerousGoodsApprovedIndicator?.toXml(),
      refrigeratedIndicator?.toXml(),
      powerIndicator?.toXml(),
      minimumTemperature?.toXml(),
      maximumTemperature?.toXml(),
      ...certificate.map((Certificate e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'Storage',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

