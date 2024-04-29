import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/TransportEmergencyCardCode.dart';
import '../cbc/PackingCriteriaCode.dart';
import '../cbc/HazardousRegulationCode.dart';
import '../cbc/InhalationToxicityZoneCode.dart';
import '../cbc/TransportAuthorizationCode.dart';
import '../cac/MaximumTemperature.dart';
import '../cac/MinimumTemperature.dart';

// A class to describe hazardous goods in transit.
class HazardousGoodsTransit {


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

  // The maximum temperature at which the hazardous goods can safely be transported.
  final MaximumTemperature? maximumTemperature;

  // The minimum temperature at which the hazardous goods can safely be transported.
  final MinimumTemperature? minimumTemperature;

  HazardousGoodsTransit ({
    this.transportEmergencyCardCode,
    this.packingCriteriaCode,
    this.hazardousRegulationCode,
    this.inhalationToxicityZoneCode,
    this.transportAuthorizationCode,
    this.maximumTemperature,
    this.minimumTemperature,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'transportEmergencyCardCode': transportEmergencyCardCode?.toJson(),
     'packingCriteriaCode': packingCriteriaCode?.toJson(),
     'hazardousRegulationCode': hazardousRegulationCode?.toJson(),
     'inhalationToxicityZoneCode': inhalationToxicityZoneCode?.toJson(),
     'transportAuthorizationCode': transportAuthorizationCode?.toJson(),
     'maximumTemperature': maximumTemperature?.toJson(),
     'minimumTemperature': minimumTemperature?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  HazardousGoodsTransit fromJson(Map<String, dynamic> json) {
    return HazardousGoodsTransit (
    );
  }

}

