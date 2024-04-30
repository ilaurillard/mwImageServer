import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/TransportServiceCode.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/TariffClassCode.dart';
import '../cbc/Priority.dart';
import '../cbc/FreightRateClassCode.dart';
import '../cbc/TransportationServiceDescription.dart';
import '../cbc/TransportationServiceDetailsURI.dart';
import '../cbc/NominationDate.dart';
import '../cbc/NominationTime.dart';
import '../cbc/Name.dart';
import '../cbc/SequenceNumeric.dart';
import '../cac/TransportEquipment.dart';
import '../cac/SupportedTransportEquipment.dart';
import '../cac/UnsupportedTransportEquipment.dart';
import '../cac/CommodityClassification.dart';
import '../cac/SupportedCommodityClassification.dart';
import '../cac/UnsupportedCommodityClassification.dart';
import '../cac/TotalCapacityDimension.dart';
import '../cac/ShipmentStage.dart';
import '../cac/TransportEvent.dart';
import '../cac/ResponsibleTransportServiceProviderParty.dart';
import '../cac/EnvironmentalEmission.dart';
import '../cac/EstimatedDurationPeriod.dart';
import '../cac/ScheduledServiceFrequency.dart';

// A class to describe a transportation service.
class OriginalDespatchTransportationService {


  // A code signifying the extent of this transportation service (e.g., door-to-door, port-to-port).
  final TransportServiceCode transportServiceCode;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code signifying the tariff class applicable to this transportation service.
  final TariffClassCode? tariffClassCode;

  // The priority of this transportation service.
  final Priority? priority;

  // A code signifying the rate class for freight in this transportation service.
  final FreightRateClassCode? freightRateClassCode;

  // Text describing this transportation service.
  final List<TransportationServiceDescription> transportationServiceDescription;

  // The Uniform Resource Identifier (URI) of a document providing additional details regarding this transportation service.
  final TransportationServiceDetailsURI? transportationServiceDetailsURI;

  // In a transport contract, the deadline date by which this transportation service has to be booked. For example, if this service is scheduled for Wednesday 16 February 2011 at 10 a.m. CET, the nomination date might be Tuesday15 February 2011.
  final NominationDate? nominationDate;

  // In a transport contract, the deadline time by which this transportation service has to be booked. For example, if this service is scheduled for Wednesday 16 February 2011 at 10 a.m. CET, the nomination date might be Tuesday15 February 2011 and the nomination time 4 p.m. at the latest.
  final NominationTime? nominationTime;

  // The name of this transportation service.
  final Name? name;

  // A number indicating the order of this transportation service in a sequence of transportation services.
  final SequenceNumeric? sequenceNumeric;

  // A piece of transport equipment used in this transportation service.
  final List<TransportEquipment> transportEquipment;

  // A piece of transport equipment supported in this transportation service.
  final List<SupportedTransportEquipment> supportedTransportEquipment;

  // A piece of transport equipment that is not supported in this transportation service.
  final List<UnsupportedTransportEquipment> unsupportedTransportEquipment;

  // A classification of this transportation service.
  final List<CommodityClassification> commodityClassification;

  // A classification (e.g., general cargo) for commodities that can be handled in this transportation service.
  final List<SupportedCommodityClassification> supportedCommodityClassification;

  // A classification for commodities that cannot be handled in this transportation service.
  final List<UnsupportedCommodityClassification> unsupportedCommodityClassification;

  // The total capacity or volume available in this transportation service.
  final TotalCapacityDimension? totalCapacityDimension;

  // One of the stages of shipment in this transportation service.
  final List<ShipmentStage> shipmentStage;

  // One of the transport events taking place in this transportation service.
  final List<TransportEvent> transportEvent;

  // The transport service provider responsible for this transportation service.
  final ResponsibleTransportServiceProviderParty? responsibleTransportServiceProviderParty;

  // An environmental emission resulting from this transportation service.
  final List<EnvironmentalEmission> environmentalEmission;

  // The estimated duration of this transportation service.
  final EstimatedDurationPeriod? estimatedDurationPeriod;

  // A class to specify which day of the week a transport service is operational.
  final List<ScheduledServiceFrequency> scheduledServiceFrequency;

  OriginalDespatchTransportationService ({
    required this.transportServiceCode,
    this.uBLExtensions,
    this.tariffClassCode,
    this.priority,
    this.freightRateClassCode,
    this.transportationServiceDescription = const [],
    this.transportationServiceDetailsURI,
    this.nominationDate,
    this.nominationTime,
    this.name,
    this.sequenceNumeric,
    this.transportEquipment = const [],
    this.supportedTransportEquipment = const [],
    this.unsupportedTransportEquipment = const [],
    this.commodityClassification = const [],
    this.supportedCommodityClassification = const [],
    this.unsupportedCommodityClassification = const [],
    this.totalCapacityDimension,
    this.shipmentStage = const [],
    this.transportEvent = const [],
    this.responsibleTransportServiceProviderParty,
    this.environmentalEmission = const [],
    this.estimatedDurationPeriod,
    this.scheduledServiceFrequency = const [],
  });

  static OriginalDespatchTransportationService? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return OriginalDespatchTransportationService (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      transportServiceCode: TransportServiceCode.fromJson(json['transportServiceCode'] as Map<String, dynamic>?)!,
      tariffClassCode: TariffClassCode.fromJson(json['tariffClassCode'] as Map<String, dynamic>?),
      priority: Priority.fromJson(json['priority'] as Map<String, dynamic>?),
      freightRateClassCode: FreightRateClassCode.fromJson(json['freightRateClassCode'] as Map<String, dynamic>?),
      transportationServiceDescription: (json['transportationServiceDescription'] as List? ?? []).map((dynamic d) => TransportationServiceDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportationServiceDetailsURI: TransportationServiceDetailsURI.fromJson(json['transportationServiceDetailsURI'] as Map<String, dynamic>?),
      nominationDate: NominationDate.fromJson(json['nominationDate'] as Map<String, dynamic>?),
      nominationTime: NominationTime.fromJson(json['nominationTime'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      sequenceNumeric: SequenceNumeric.fromJson(json['sequenceNumeric'] as Map<String, dynamic>?),
      transportEquipment: (json['transportEquipment'] as List? ?? []).map((dynamic d) => TransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      supportedTransportEquipment: (json['supportedTransportEquipment'] as List? ?? []).map((dynamic d) => SupportedTransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      unsupportedTransportEquipment: (json['unsupportedTransportEquipment'] as List? ?? []).map((dynamic d) => UnsupportedTransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      commodityClassification: (json['commodityClassification'] as List? ?? []).map((dynamic d) => CommodityClassification.fromJson(d as Map<String, dynamic>?)!).toList(),
      supportedCommodityClassification: (json['supportedCommodityClassification'] as List? ?? []).map((dynamic d) => SupportedCommodityClassification.fromJson(d as Map<String, dynamic>?)!).toList(),
      unsupportedCommodityClassification: (json['unsupportedCommodityClassification'] as List? ?? []).map((dynamic d) => UnsupportedCommodityClassification.fromJson(d as Map<String, dynamic>?)!).toList(),
      totalCapacityDimension: TotalCapacityDimension.fromJson(json['totalCapacityDimension'] as Map<String, dynamic>?),
      shipmentStage: (json['shipmentStage'] as List? ?? []).map((dynamic d) => ShipmentStage.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportEvent: (json['transportEvent'] as List? ?? []).map((dynamic d) => TransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      responsibleTransportServiceProviderParty: ResponsibleTransportServiceProviderParty.fromJson(json['responsibleTransportServiceProviderParty'] as Map<String, dynamic>?),
      environmentalEmission: (json['environmentalEmission'] as List? ?? []).map((dynamic d) => EnvironmentalEmission.fromJson(d as Map<String, dynamic>?)!).toList(),
      estimatedDurationPeriod: EstimatedDurationPeriod.fromJson(json['estimatedDurationPeriod'] as Map<String, dynamic>?),
      scheduledServiceFrequency: (json['scheduledServiceFrequency'] as List? ?? []).map((dynamic d) => ScheduledServiceFrequency.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'transportServiceCode': transportServiceCode.toJson(),
      'tariffClassCode': tariffClassCode?.toJson(),
      'priority': priority?.toJson(),
      'freightRateClassCode': freightRateClassCode?.toJson(),
      'transportationServiceDescription': transportationServiceDescription.map((e) => e.toJson()).toList(),
      'transportationServiceDetailsURI': transportationServiceDetailsURI?.toJson(),
      'nominationDate': nominationDate?.toJson(),
      'nominationTime': nominationTime?.toJson(),
      'name': name?.toJson(),
      'sequenceNumeric': sequenceNumeric?.toJson(),
      'transportEquipment': transportEquipment.map((e) => e.toJson()).toList(),
      'supportedTransportEquipment': supportedTransportEquipment.map((e) => e.toJson()).toList(),
      'unsupportedTransportEquipment': unsupportedTransportEquipment.map((e) => e.toJson()).toList(),
      'commodityClassification': commodityClassification.map((e) => e.toJson()).toList(),
      'supportedCommodityClassification': supportedCommodityClassification.map((e) => e.toJson()).toList(),
      'unsupportedCommodityClassification': unsupportedCommodityClassification.map((e) => e.toJson()).toList(),
      'totalCapacityDimension': totalCapacityDimension?.toJson(),
      'shipmentStage': shipmentStage.map((e) => e.toJson()).toList(),
      'transportEvent': transportEvent.map((e) => e.toJson()).toList(),
      'responsibleTransportServiceProviderParty': responsibleTransportServiceProviderParty?.toJson(),
      'environmentalEmission': environmentalEmission.map((e) => e.toJson()).toList(),
      'estimatedDurationPeriod': estimatedDurationPeriod?.toJson(),
      'scheduledServiceFrequency': scheduledServiceFrequency.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static OriginalDespatchTransportationService? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return OriginalDespatchTransportationService (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      transportServiceCode: TransportServiceCode.fromXml(xml.findElements('cbc:TransportServiceCode').singleOrNull)!,
      tariffClassCode: TariffClassCode.fromXml(xml.findElements('cbc:TariffClassCode').singleOrNull),
      priority: Priority.fromXml(xml.findElements('cbc:Priority').singleOrNull),
      freightRateClassCode: FreightRateClassCode.fromXml(xml.findElements('cbc:FreightRateClassCode').singleOrNull),
      transportationServiceDescription: xml.findElements('cbc:TransportationServiceDescription').map((XmlElement e) => TransportationServiceDescription.fromXml(e)!).toList(),
      transportationServiceDetailsURI: TransportationServiceDetailsURI.fromXml(xml.findElements('cbc:TransportationServiceDetailsURI').singleOrNull),
      nominationDate: NominationDate.fromXml(xml.findElements('cbc:NominationDate').singleOrNull),
      nominationTime: NominationTime.fromXml(xml.findElements('cbc:NominationTime').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      sequenceNumeric: SequenceNumeric.fromXml(xml.findElements('cbc:SequenceNumeric').singleOrNull),
      transportEquipment: xml.findElements('cac:TransportEquipment').map((XmlElement e) => TransportEquipment.fromXml(e)!).toList(),
      supportedTransportEquipment: xml.findElements('cac:SupportedTransportEquipment').map((XmlElement e) => SupportedTransportEquipment.fromXml(e)!).toList(),
      unsupportedTransportEquipment: xml.findElements('cac:UnsupportedTransportEquipment').map((XmlElement e) => UnsupportedTransportEquipment.fromXml(e)!).toList(),
      commodityClassification: xml.findElements('cac:CommodityClassification').map((XmlElement e) => CommodityClassification.fromXml(e)!).toList(),
      supportedCommodityClassification: xml.findElements('cac:SupportedCommodityClassification').map((XmlElement e) => SupportedCommodityClassification.fromXml(e)!).toList(),
      unsupportedCommodityClassification: xml.findElements('cac:UnsupportedCommodityClassification').map((XmlElement e) => UnsupportedCommodityClassification.fromXml(e)!).toList(),
      totalCapacityDimension: TotalCapacityDimension.fromXml(xml.findElements('cac:TotalCapacityDimension').singleOrNull),
      shipmentStage: xml.findElements('cac:ShipmentStage').map((XmlElement e) => ShipmentStage.fromXml(e)!).toList(),
      transportEvent: xml.findElements('cac:TransportEvent').map((XmlElement e) => TransportEvent.fromXml(e)!).toList(),
      responsibleTransportServiceProviderParty: ResponsibleTransportServiceProviderParty.fromXml(xml.findElements('cac:ResponsibleTransportServiceProviderParty').singleOrNull),
      environmentalEmission: xml.findElements('cac:EnvironmentalEmission').map((XmlElement e) => EnvironmentalEmission.fromXml(e)!).toList(),
      estimatedDurationPeriod: EstimatedDurationPeriod.fromXml(xml.findElements('cac:EstimatedDurationPeriod').singleOrNull),
      scheduledServiceFrequency: xml.findElements('cac:ScheduledServiceFrequency').map((XmlElement e) => ScheduledServiceFrequency.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      transportServiceCode.toXml(),
      tariffClassCode?.toXml(),
      priority?.toXml(),
      freightRateClassCode?.toXml(),
      ...transportationServiceDescription.map((TransportationServiceDescription e) => e.toXml()).toList(),
      transportationServiceDetailsURI?.toXml(),
      nominationDate?.toXml(),
      nominationTime?.toXml(),
      name?.toXml(),
      sequenceNumeric?.toXml(),
      ...transportEquipment.map((TransportEquipment e) => e.toXml()).toList(),
      ...supportedTransportEquipment.map((SupportedTransportEquipment e) => e.toXml()).toList(),
      ...unsupportedTransportEquipment.map((UnsupportedTransportEquipment e) => e.toXml()).toList(),
      ...commodityClassification.map((CommodityClassification e) => e.toXml()).toList(),
      ...supportedCommodityClassification.map((SupportedCommodityClassification e) => e.toXml()).toList(),
      ...unsupportedCommodityClassification.map((UnsupportedCommodityClassification e) => e.toXml()).toList(),
      totalCapacityDimension?.toXml(),
      ...shipmentStage.map((ShipmentStage e) => e.toXml()).toList(),
      ...transportEvent.map((TransportEvent e) => e.toXml()).toList(),
      responsibleTransportServiceProviderParty?.toXml(),
      ...environmentalEmission.map((EnvironmentalEmission e) => e.toXml()).toList(),
      estimatedDurationPeriod?.toXml(),
      ...scheduledServiceFrequency.map((ScheduledServiceFrequency e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'OriginalDespatchTransportationService',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

