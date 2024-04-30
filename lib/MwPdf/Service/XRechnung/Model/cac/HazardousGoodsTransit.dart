import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/TransportEmergencyCardCode.dart';
import '../cbc/PackingCriteriaCode.dart';
import '../cbc/HazardousRegulationCode.dart';
import '../cbc/InhalationToxicityZoneCode.dart';
import '../cbc/TransportAuthorizationCode.dart';
import '../cbc/TransitDescription.dart';
import '../cac/MaximumTemperature.dart';
import '../cac/MinimumTemperature.dart';

// A class to describe hazardous goods in transit.
class HazardousGoodsTransit {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for a transport emergency card describing the actions to be taken in an emergency in transporting the hazardous goods. It may be the identity number of a hazardous emergency response plan assigned by the appropriate authority.
  final TransportEmergencyCardCode? transportEmergencyCardCode;

  // A code signifying the packaging requirement for transportation of the hazardous goods as assigned by IATA, IMDB, ADR, RID etc.
  final PackingCriteriaCode? packingCriteriaCode;

  // A code signifying the set of legal regulations governing the transportation of the hazardous goods.
  final HazardousRegulationCode? hazardousRegulationCode;

  // A code signifying the Inhalation Toxicity Hazard Zone for the hazardous goods, as defined by the US Department of Transportation.
  final InhalationToxicityZoneCode? inhalationToxicityZoneCode;

  // A code signifying authorization for the transportation of hazardous cargo.
  final TransportAuthorizationCode? transportAuthorizationCode;

  // A textual description of this hazardous goods transit.
  final List<TransitDescription> transitDescription;

  // The maximum temperature at which the hazardous goods can safely be transported.
  final MaximumTemperature? maximumTemperature;

  // The minimum temperature at which the hazardous goods can safely be transported.
  final MinimumTemperature? minimumTemperature;

  HazardousGoodsTransit ({
    this.uBLExtensions,
    this.transportEmergencyCardCode,
    this.packingCriteriaCode,
    this.hazardousRegulationCode,
    this.inhalationToxicityZoneCode,
    this.transportAuthorizationCode,
    this.transitDescription = const [],
    this.maximumTemperature,
    this.minimumTemperature,
  });

  static HazardousGoodsTransit? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return HazardousGoodsTransit (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      transportEmergencyCardCode: TransportEmergencyCardCode.fromJson(json['transportEmergencyCardCode'] as Map<String, dynamic>?),
      packingCriteriaCode: PackingCriteriaCode.fromJson(json['packingCriteriaCode'] as Map<String, dynamic>?),
      hazardousRegulationCode: HazardousRegulationCode.fromJson(json['hazardousRegulationCode'] as Map<String, dynamic>?),
      inhalationToxicityZoneCode: InhalationToxicityZoneCode.fromJson(json['inhalationToxicityZoneCode'] as Map<String, dynamic>?),
      transportAuthorizationCode: TransportAuthorizationCode.fromJson(json['transportAuthorizationCode'] as Map<String, dynamic>?),
      transitDescription: (json['transitDescription'] as List? ?? []).map((dynamic d) => TransitDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      maximumTemperature: MaximumTemperature.fromJson(json['maximumTemperature'] as Map<String, dynamic>?),
      minimumTemperature: MinimumTemperature.fromJson(json['minimumTemperature'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'transportEmergencyCardCode': transportEmergencyCardCode?.toJson(),
      'packingCriteriaCode': packingCriteriaCode?.toJson(),
      'hazardousRegulationCode': hazardousRegulationCode?.toJson(),
      'inhalationToxicityZoneCode': inhalationToxicityZoneCode?.toJson(),
      'transportAuthorizationCode': transportAuthorizationCode?.toJson(),
      'transitDescription': transitDescription.map((e) => e.toJson()).toList(),
      'maximumTemperature': maximumTemperature?.toJson(),
      'minimumTemperature': minimumTemperature?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static HazardousGoodsTransit? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return HazardousGoodsTransit (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      transportEmergencyCardCode: TransportEmergencyCardCode.fromXml(xml.findElements('cbc:TransportEmergencyCardCode').singleOrNull),
      packingCriteriaCode: PackingCriteriaCode.fromXml(xml.findElements('cbc:PackingCriteriaCode').singleOrNull),
      hazardousRegulationCode: HazardousRegulationCode.fromXml(xml.findElements('cbc:HazardousRegulationCode').singleOrNull),
      inhalationToxicityZoneCode: InhalationToxicityZoneCode.fromXml(xml.findElements('cbc:InhalationToxicityZoneCode').singleOrNull),
      transportAuthorizationCode: TransportAuthorizationCode.fromXml(xml.findElements('cbc:TransportAuthorizationCode').singleOrNull),
      transitDescription: xml.findElements('cbc:TransitDescription').map((XmlElement e) => TransitDescription.fromXml(e)!).toList(),
      maximumTemperature: MaximumTemperature.fromXml(xml.findElements('cac:MaximumTemperature').singleOrNull),
      minimumTemperature: MinimumTemperature.fromXml(xml.findElements('cac:MinimumTemperature').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'HazardousGoodsTransit',
        'cac',
      ),
    );
  }
}

