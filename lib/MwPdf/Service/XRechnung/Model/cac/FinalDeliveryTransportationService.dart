import 'dart:convert';
import '../cbc/TransportServiceCode.dart';
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
class FinalDeliveryTransportationService {


  // A code signifying the extent of this transportation service (e.g., door-to-door, port-to-port).
  final TransportServiceCode transportServiceCode;

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

  FinalDeliveryTransportationService ({
    required this.transportServiceCode,
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

}

