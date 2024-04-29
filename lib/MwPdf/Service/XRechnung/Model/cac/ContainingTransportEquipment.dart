import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/ReferencedConsignmentID.dart';
import '../cbc/TransportEquipmentTypeCode.dart';
import '../cbc/ProviderTypeCode.dart';
import '../cbc/OwnerTypeCode.dart';
import '../cbc/SizeTypeCode.dart';
import '../cbc/DispositionCode.dart';
import '../cbc/FullnessIndicationCode.dart';
import '../cbc/RefrigerationOnIndicator.dart';
import '../cbc/Information.dart';
import '../cbc/ReturnabilityIndicator.dart';
import '../cbc/LegalStatusIndicator.dart';
import '../cbc/AirFlowPercent.dart';
import '../cbc/HumidityPercent.dart';
import '../cbc/AnimalFoodApprovedIndicator.dart';
import '../cbc/HumanFoodApprovedIndicator.dart';
import '../cbc/DangerousGoodsApprovedIndicator.dart';
import '../cbc/RefrigeratedIndicator.dart';
import '../cbc/Characteristics.dart';
import '../cbc/DamageRemarks.dart';
import '../cbc/Description.dart';
import '../cbc/SpecialTransportRequirements.dart';
import '../cbc/GrossWeightMeasure.dart';
import '../cbc/GrossVolumeMeasure.dart';
import '../cbc/TareWeightMeasure.dart';
import '../cbc/TrackingDeviceCode.dart';
import '../cbc/PowerIndicator.dart';
import '../cbc/TraceID.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/TransportEquipmentSeal.dart';
import '../cac/MinimumTemperature.dart';
import '../cac/MaximumTemperature.dart';
import '../cac/ProviderParty.dart';
import '../cac/LoadingProofParty.dart';
import '../cac/SupplierParty.dart';
import '../cac/OwnerParty.dart';
import '../cac/OperatingParty.dart';
import '../cac/LoadingLocation.dart';
import '../cac/UnloadingLocation.dart';
import '../cac/StorageLocation.dart';
import '../cac/PositioningTransportEvent.dart';
import '../cac/QuarantineTransportEvent.dart';
import '../cac/DeliveryTransportEvent.dart';
import '../cac/PickupTransportEvent.dart';
import '../cac/HandlingTransportEvent.dart';
import '../cac/LoadingTransportEvent.dart';
import '../cac/TransportEvent.dart';
import '../cac/ApplicableTransportMeans.dart';
import '../cac/HaulageTradingTerms.dart';
import '../cac/HazardousGoodsTransit.dart';
import '../cac/PackagedTransportHandlingUnit.dart';
import '../cac/ServiceAllowanceCharge.dart';
import '../cac/FreightAllowanceCharge.dart';
import '../cac/AttachedTransportEquipment.dart';
import '../cac/Delivery.dart';
import '../cac/Pickup.dart';
import '../cac/Despatch.dart';
import '../cac/ShipmentDocumentReference.dart';
import '../cac/ContainedInTransportEquipment.dart';
import '../cac/Package.dart';
import '../cac/GoodsItem.dart';

// A class to describe a piece of equipment used to transport goods.
class ContainingTransportEquipment {


  // An identifier for this piece of transport equipment.
  final ID? iD;

  // An identifier for the consignment contained by this piece of transport equipment.
  final List<ReferencedConsignmentID> referencedConsignmentID;

  // A code signifying the type of this piece of transport equipment.
  final TransportEquipmentTypeCode? transportEquipmentTypeCode;

  // A code signifying the type of provider of this piece of transport equipment.
  final ProviderTypeCode? providerTypeCode;

  // A code signifying the type of owner of this piece of transport equipment.
  final OwnerTypeCode? ownerTypeCode;

  // A code signifying the size and type of this piece of piece of transport equipment. When the piece of transport equipment is a shipping container, it is recommended to use ContainerSizeTypeCode for validation.
  final SizeTypeCode? sizeTypeCode;

  // A code signifying the current disposition of this piece of transport equipment.
  final DispositionCode? dispositionCode;

  // A code signifying whether this piece of transport equipment is full, partially full, or empty.
  final FullnessIndicationCode? fullnessIndicationCode;

  // An indicator that this piece of transport equipment's refrigeration is on (true) or off (false).
  final RefrigerationOnIndicator? refrigerationOnIndicator;

  // Additional information about this piece of transport equipment.
  final List<Information> information;

  // An indicator that this piece of transport equipment is returnable (true) or not (false).
  final ReturnabilityIndicator? returnabilityIndicator;

  // An indication of the legal status of this piece of transport equipment with respect to the Container Convention Code.
  final LegalStatusIndicator? legalStatusIndicator;

  // The percent of the airflow within this piece of transport equipment.
  final AirFlowPercent? airFlowPercent;

  // The percent humidity within this piece of transport equipment.
  final HumidityPercent? humidityPercent;

  // An indicator that this piece of transport equipment is approved for animal food (true) or not (false).
  final AnimalFoodApprovedIndicator? animalFoodApprovedIndicator;

  // An indicator that this piece of transport equipment is approved for human food (true) or not (false).
  final HumanFoodApprovedIndicator? humanFoodApprovedIndicator;

  // An indicator that this piece of transport equipment is approved for dangerous goods (true) or not (false).
  final DangerousGoodsApprovedIndicator? dangerousGoodsApprovedIndicator;

  // An indicator that this piece of transport equipment is refrigerated (true) or not (false).
  final RefrigeratedIndicator? refrigeratedIndicator;

  // Characteristics of this piece of transport equipment.
  final Characteristics? characteristics;

  // Damage associated with this piece of transport equipment.
  final List<DamageRemarks> damageRemarks;

  // Text describing this piece of transport equipment.
  final List<Description> description;

  // Special transport requirements expressed as text.
  final List<SpecialTransportRequirements> specialTransportRequirements;

  // The gross weight of this piece of transport equipment.
  final GrossWeightMeasure? grossWeightMeasure;

  // The gross volume of this piece of transport equipment.
  final GrossVolumeMeasure? grossVolumeMeasure;

  // The weight of this piece of transport equipment when empty.
  final TareWeightMeasure? tareWeightMeasure;

  // A code signifying the tracking device for this piece of transport equipment.
  final TrackingDeviceCode? trackingDeviceCode;

  // An indicator that this piece of transport equipment can supply power (true) or not (false).
  final PowerIndicator? powerIndicator;

  // An identifier for use in tracing this piece of transport equipment, such as the EPC number used in RFID.
  final TraceID? traceID;

  // A measurable dimension (length, mass, weight, or volume) of this piece of transport equipment.
  final List<MeasurementDimension> measurementDimension;

  // A seal securing the door of a piece of transport equipment.
  final List<TransportEquipmentSeal> transportEquipmentSeal;

  // In the case of a refrigeration unit, the minimum allowable operating temperature for this container.
  final MinimumTemperature? minimumTemperature;

  // In the case of a refrigeration unit, the maximum allowable operating temperature for this container.
  final MaximumTemperature? maximumTemperature;

  // The party providing this piece of transport equipment.
  final ProviderParty? providerParty;

  // The authorized party responsible for certifying that the goods were loaded into this piece of transport equipment.
  final LoadingProofParty? loadingProofParty;

  // The party that supplies this piece of transport equipment.
  final SupplierParty? supplierParty;

  // The party that owns this piece of transport equipment.
  final OwnerParty? ownerParty;

  // The party that operates this piece of transport equipment.
  final OperatingParty? operatingParty;

  // The location where this piece of transport equipment is loaded.
  final LoadingLocation? loadingLocation;

  // The location where this piece of transport equipment is unloaded.
  final UnloadingLocation? unloadingLocation;

  // The location where this piece of transport equipment is being stored.
  final StorageLocation? storageLocation;

  // A positioning of this piece of transport equipment.
  final List<PositioningTransportEvent> positioningTransportEvent;

  // A quarantine of this piece of transport equipment.
  final List<QuarantineTransportEvent> quarantineTransportEvent;

  // A delivery of this piece of transport equipment.
  final List<DeliveryTransportEvent> deliveryTransportEvent;

  // A pickup of this piece of transport equipment.
  final List<PickupTransportEvent> pickupTransportEvent;

  // A handling of this piece of transport equipment.
  final List<HandlingTransportEvent> handlingTransportEvent;

  // A loading of this piece of transport equipment.
  final List<LoadingTransportEvent> loadingTransportEvent;

  // A transport event associated with this piece of transport equipment.
  final List<TransportEvent> transportEvent;

  // The applicable transport means associated with this piece of transport equipment.
  final ApplicableTransportMeans? applicableTransportMeans;

  // A set of haulage trading terms associated with this piece of transport equipment.
  final List<HaulageTradingTerms> haulageTradingTerms;

  // Transit-related information regarding a type of hazardous goods contained in this piece of transport equipment.
  final List<HazardousGoodsTransit> hazardousGoodsTransit;

  // A packaged transport handling unit associated with this piece of transport equipment.
  final List<PackagedTransportHandlingUnit> packagedTransportHandlingUnit;

  // A service allowance charge associated with this piece of transport equipment.
  final List<ServiceAllowanceCharge> serviceAllowanceCharge;

  // A freight allowance charge associated with this piece of transport equipment.
  final List<FreightAllowanceCharge> freightAllowanceCharge;

  // A piece of transport equipment attached to this piece of transport equipment.
  final List<AttachedTransportEquipment> attachedTransportEquipment;

  // The delivery of this piece of transport equipment.
  final Delivery? delivery;

  // The pickup of this piece of transport equipment.
  final Pickup? pickup;

  // The despatch of this piece of transport equipment.
  final Despatch? despatch;

  // A reference to a shipping document associated with this piece of transport equipment.
  final List<ShipmentDocumentReference> shipmentDocumentReference;

  // A piece of transport equipment contained in this piece of transport equipment.
  final List<ContainedInTransportEquipment> containedInTransportEquipment;

  // A package contained in this piece of transport equipment.
  final List<Package> package;

  // A goods item contained in this piece of transport equipment.
  final List<GoodsItem> goodsItem;

  ContainingTransportEquipment ({
    this.iD,
    this.referencedConsignmentID = const [],
    this.transportEquipmentTypeCode,
    this.providerTypeCode,
    this.ownerTypeCode,
    this.sizeTypeCode,
    this.dispositionCode,
    this.fullnessIndicationCode,
    this.refrigerationOnIndicator,
    this.information = const [],
    this.returnabilityIndicator,
    this.legalStatusIndicator,
    this.airFlowPercent,
    this.humidityPercent,
    this.animalFoodApprovedIndicator,
    this.humanFoodApprovedIndicator,
    this.dangerousGoodsApprovedIndicator,
    this.refrigeratedIndicator,
    this.characteristics,
    this.damageRemarks = const [],
    this.description = const [],
    this.specialTransportRequirements = const [],
    this.grossWeightMeasure,
    this.grossVolumeMeasure,
    this.tareWeightMeasure,
    this.trackingDeviceCode,
    this.powerIndicator,
    this.traceID,
    this.measurementDimension = const [],
    this.transportEquipmentSeal = const [],
    this.minimumTemperature,
    this.maximumTemperature,
    this.providerParty,
    this.loadingProofParty,
    this.supplierParty,
    this.ownerParty,
    this.operatingParty,
    this.loadingLocation,
    this.unloadingLocation,
    this.storageLocation,
    this.positioningTransportEvent = const [],
    this.quarantineTransportEvent = const [],
    this.deliveryTransportEvent = const [],
    this.pickupTransportEvent = const [],
    this.handlingTransportEvent = const [],
    this.loadingTransportEvent = const [],
    this.transportEvent = const [],
    this.applicableTransportMeans,
    this.haulageTradingTerms = const [],
    this.hazardousGoodsTransit = const [],
    this.packagedTransportHandlingUnit = const [],
    this.serviceAllowanceCharge = const [],
    this.freightAllowanceCharge = const [],
    this.attachedTransportEquipment = const [],
    this.delivery,
    this.pickup,
    this.despatch,
    this.shipmentDocumentReference = const [],
    this.containedInTransportEquipment = const [],
    this.package = const [],
    this.goodsItem = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'referencedConsignmentID': referencedConsignmentID.map((e) => e.toJson()).toList(),
      'transportEquipmentTypeCode': transportEquipmentTypeCode?.toJson(),
      'providerTypeCode': providerTypeCode?.toJson(),
      'ownerTypeCode': ownerTypeCode?.toJson(),
      'sizeTypeCode': sizeTypeCode?.toJson(),
      'dispositionCode': dispositionCode?.toJson(),
      'fullnessIndicationCode': fullnessIndicationCode?.toJson(),
      'refrigerationOnIndicator': refrigerationOnIndicator?.toJson(),
      'information': information.map((e) => e.toJson()).toList(),
      'returnabilityIndicator': returnabilityIndicator?.toJson(),
      'legalStatusIndicator': legalStatusIndicator?.toJson(),
      'airFlowPercent': airFlowPercent?.toJson(),
      'humidityPercent': humidityPercent?.toJson(),
      'animalFoodApprovedIndicator': animalFoodApprovedIndicator?.toJson(),
      'humanFoodApprovedIndicator': humanFoodApprovedIndicator?.toJson(),
      'dangerousGoodsApprovedIndicator': dangerousGoodsApprovedIndicator?.toJson(),
      'refrigeratedIndicator': refrigeratedIndicator?.toJson(),
      'characteristics': characteristics?.toJson(),
      'damageRemarks': damageRemarks.map((e) => e.toJson()).toList(),
      'description': description.map((e) => e.toJson()).toList(),
      'specialTransportRequirements': specialTransportRequirements.map((e) => e.toJson()).toList(),
      'grossWeightMeasure': grossWeightMeasure?.toJson(),
      'grossVolumeMeasure': grossVolumeMeasure?.toJson(),
      'tareWeightMeasure': tareWeightMeasure?.toJson(),
      'trackingDeviceCode': trackingDeviceCode?.toJson(),
      'powerIndicator': powerIndicator?.toJson(),
      'traceID': traceID?.toJson(),
      'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
      'transportEquipmentSeal': transportEquipmentSeal.map((e) => e.toJson()).toList(),
      'minimumTemperature': minimumTemperature?.toJson(),
      'maximumTemperature': maximumTemperature?.toJson(),
      'providerParty': providerParty?.toJson(),
      'loadingProofParty': loadingProofParty?.toJson(),
      'supplierParty': supplierParty?.toJson(),
      'ownerParty': ownerParty?.toJson(),
      'operatingParty': operatingParty?.toJson(),
      'loadingLocation': loadingLocation?.toJson(),
      'unloadingLocation': unloadingLocation?.toJson(),
      'storageLocation': storageLocation?.toJson(),
      'positioningTransportEvent': positioningTransportEvent.map((e) => e.toJson()).toList(),
      'quarantineTransportEvent': quarantineTransportEvent.map((e) => e.toJson()).toList(),
      'deliveryTransportEvent': deliveryTransportEvent.map((e) => e.toJson()).toList(),
      'pickupTransportEvent': pickupTransportEvent.map((e) => e.toJson()).toList(),
      'handlingTransportEvent': handlingTransportEvent.map((e) => e.toJson()).toList(),
      'loadingTransportEvent': loadingTransportEvent.map((e) => e.toJson()).toList(),
      'transportEvent': transportEvent.map((e) => e.toJson()).toList(),
      'applicableTransportMeans': applicableTransportMeans?.toJson(),
      'haulageTradingTerms': haulageTradingTerms.map((e) => e.toJson()).toList(),
      'hazardousGoodsTransit': hazardousGoodsTransit.map((e) => e.toJson()).toList(),
      'packagedTransportHandlingUnit': packagedTransportHandlingUnit.map((e) => e.toJson()).toList(),
      'serviceAllowanceCharge': serviceAllowanceCharge.map((e) => e.toJson()).toList(),
      'freightAllowanceCharge': freightAllowanceCharge.map((e) => e.toJson()).toList(),
      'attachedTransportEquipment': attachedTransportEquipment.map((e) => e.toJson()).toList(),
      'delivery': delivery?.toJson(),
      'pickup': pickup?.toJson(),
      'despatch': despatch?.toJson(),
      'shipmentDocumentReference': shipmentDocumentReference.map((e) => e.toJson()).toList(),
      'containedInTransportEquipment': containedInTransportEquipment.map((e) => e.toJson()).toList(),
      'package': package.map((e) => e.toJson()).toList(),
      'goodsItem': goodsItem.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ContainingTransportEquipment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ContainingTransportEquipment (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      referencedConsignmentID: (json['referencedConsignmentID'] as List? ?? []).map((dynamic d) => ReferencedConsignmentID.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportEquipmentTypeCode: TransportEquipmentTypeCode.fromJson(json['transportEquipmentTypeCode'] as Map<String, dynamic>?),
      providerTypeCode: ProviderTypeCode.fromJson(json['providerTypeCode'] as Map<String, dynamic>?),
      ownerTypeCode: OwnerTypeCode.fromJson(json['ownerTypeCode'] as Map<String, dynamic>?),
      sizeTypeCode: SizeTypeCode.fromJson(json['sizeTypeCode'] as Map<String, dynamic>?),
      dispositionCode: DispositionCode.fromJson(json['dispositionCode'] as Map<String, dynamic>?),
      fullnessIndicationCode: FullnessIndicationCode.fromJson(json['fullnessIndicationCode'] as Map<String, dynamic>?),
      refrigerationOnIndicator: RefrigerationOnIndicator.fromJson(json['refrigerationOnIndicator'] as Map<String, dynamic>?),
      information: (json['information'] as List? ?? []).map((dynamic d) => Information.fromJson(d as Map<String, dynamic>?)!).toList(),
      returnabilityIndicator: ReturnabilityIndicator.fromJson(json['returnabilityIndicator'] as Map<String, dynamic>?),
      legalStatusIndicator: LegalStatusIndicator.fromJson(json['legalStatusIndicator'] as Map<String, dynamic>?),
      airFlowPercent: AirFlowPercent.fromJson(json['airFlowPercent'] as Map<String, dynamic>?),
      humidityPercent: HumidityPercent.fromJson(json['humidityPercent'] as Map<String, dynamic>?),
      animalFoodApprovedIndicator: AnimalFoodApprovedIndicator.fromJson(json['animalFoodApprovedIndicator'] as Map<String, dynamic>?),
      humanFoodApprovedIndicator: HumanFoodApprovedIndicator.fromJson(json['humanFoodApprovedIndicator'] as Map<String, dynamic>?),
      dangerousGoodsApprovedIndicator: DangerousGoodsApprovedIndicator.fromJson(json['dangerousGoodsApprovedIndicator'] as Map<String, dynamic>?),
      refrigeratedIndicator: RefrigeratedIndicator.fromJson(json['refrigeratedIndicator'] as Map<String, dynamic>?),
      characteristics: Characteristics.fromJson(json['characteristics'] as Map<String, dynamic>?),
      damageRemarks: (json['damageRemarks'] as List? ?? []).map((dynamic d) => DamageRemarks.fromJson(d as Map<String, dynamic>?)!).toList(),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      specialTransportRequirements: (json['specialTransportRequirements'] as List? ?? []).map((dynamic d) => SpecialTransportRequirements.fromJson(d as Map<String, dynamic>?)!).toList(),
      grossWeightMeasure: GrossWeightMeasure.fromJson(json['grossWeightMeasure'] as Map<String, dynamic>?),
      grossVolumeMeasure: GrossVolumeMeasure.fromJson(json['grossVolumeMeasure'] as Map<String, dynamic>?),
      tareWeightMeasure: TareWeightMeasure.fromJson(json['tareWeightMeasure'] as Map<String, dynamic>?),
      trackingDeviceCode: TrackingDeviceCode.fromJson(json['trackingDeviceCode'] as Map<String, dynamic>?),
      powerIndicator: PowerIndicator.fromJson(json['powerIndicator'] as Map<String, dynamic>?),
      traceID: TraceID.fromJson(json['traceID'] as Map<String, dynamic>?),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportEquipmentSeal: (json['transportEquipmentSeal'] as List? ?? []).map((dynamic d) => TransportEquipmentSeal.fromJson(d as Map<String, dynamic>?)!).toList(),
      minimumTemperature: MinimumTemperature.fromJson(json['minimumTemperature'] as Map<String, dynamic>?),
      maximumTemperature: MaximumTemperature.fromJson(json['maximumTemperature'] as Map<String, dynamic>?),
      providerParty: ProviderParty.fromJson(json['providerParty'] as Map<String, dynamic>?),
      loadingProofParty: LoadingProofParty.fromJson(json['loadingProofParty'] as Map<String, dynamic>?),
      supplierParty: SupplierParty.fromJson(json['supplierParty'] as Map<String, dynamic>?),
      ownerParty: OwnerParty.fromJson(json['ownerParty'] as Map<String, dynamic>?),
      operatingParty: OperatingParty.fromJson(json['operatingParty'] as Map<String, dynamic>?),
      loadingLocation: LoadingLocation.fromJson(json['loadingLocation'] as Map<String, dynamic>?),
      unloadingLocation: UnloadingLocation.fromJson(json['unloadingLocation'] as Map<String, dynamic>?),
      storageLocation: StorageLocation.fromJson(json['storageLocation'] as Map<String, dynamic>?),
      positioningTransportEvent: (json['positioningTransportEvent'] as List? ?? []).map((dynamic d) => PositioningTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      quarantineTransportEvent: (json['quarantineTransportEvent'] as List? ?? []).map((dynamic d) => QuarantineTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      deliveryTransportEvent: (json['deliveryTransportEvent'] as List? ?? []).map((dynamic d) => DeliveryTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      pickupTransportEvent: (json['pickupTransportEvent'] as List? ?? []).map((dynamic d) => PickupTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      handlingTransportEvent: (json['handlingTransportEvent'] as List? ?? []).map((dynamic d) => HandlingTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      loadingTransportEvent: (json['loadingTransportEvent'] as List? ?? []).map((dynamic d) => LoadingTransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportEvent: (json['transportEvent'] as List? ?? []).map((dynamic d) => TransportEvent.fromJson(d as Map<String, dynamic>?)!).toList(),
      applicableTransportMeans: ApplicableTransportMeans.fromJson(json['applicableTransportMeans'] as Map<String, dynamic>?),
      haulageTradingTerms: (json['haulageTradingTerms'] as List? ?? []).map((dynamic d) => HaulageTradingTerms.fromJson(d as Map<String, dynamic>?)!).toList(),
      hazardousGoodsTransit: (json['hazardousGoodsTransit'] as List? ?? []).map((dynamic d) => HazardousGoodsTransit.fromJson(d as Map<String, dynamic>?)!).toList(),
      packagedTransportHandlingUnit: (json['packagedTransportHandlingUnit'] as List? ?? []).map((dynamic d) => PackagedTransportHandlingUnit.fromJson(d as Map<String, dynamic>?)!).toList(),
      serviceAllowanceCharge: (json['serviceAllowanceCharge'] as List? ?? []).map((dynamic d) => ServiceAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      freightAllowanceCharge: (json['freightAllowanceCharge'] as List? ?? []).map((dynamic d) => FreightAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      attachedTransportEquipment: (json['attachedTransportEquipment'] as List? ?? []).map((dynamic d) => AttachedTransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      delivery: Delivery.fromJson(json['delivery'] as Map<String, dynamic>?),
      pickup: Pickup.fromJson(json['pickup'] as Map<String, dynamic>?),
      despatch: Despatch.fromJson(json['despatch'] as Map<String, dynamic>?),
      shipmentDocumentReference: (json['shipmentDocumentReference'] as List? ?? []).map((dynamic d) => ShipmentDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      containedInTransportEquipment: (json['containedInTransportEquipment'] as List? ?? []).map((dynamic d) => ContainedInTransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      package: (json['package'] as List? ?? []).map((dynamic d) => Package.fromJson(d as Map<String, dynamic>?)!).toList(),
      goodsItem: (json['goodsItem'] as List? ?? []).map((dynamic d) => GoodsItem.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static ContainingTransportEquipment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ContainingTransportEquipment (
      iD: null,
      referencedConsignmentID: null,
      transportEquipmentTypeCode: null,
      providerTypeCode: null,
      ownerTypeCode: null,
      sizeTypeCode: null,
      dispositionCode: null,
      fullnessIndicationCode: null,
      refrigerationOnIndicator: null,
      information: null,
      returnabilityIndicator: null,
      legalStatusIndicator: null,
      airFlowPercent: null,
      humidityPercent: null,
      animalFoodApprovedIndicator: null,
      humanFoodApprovedIndicator: null,
      dangerousGoodsApprovedIndicator: null,
      refrigeratedIndicator: null,
      characteristics: null,
      damageRemarks: null,
      description: null,
      specialTransportRequirements: null,
      grossWeightMeasure: null,
      grossVolumeMeasure: null,
      tareWeightMeasure: null,
      trackingDeviceCode: null,
      powerIndicator: null,
      traceID: null,
      measurementDimension: null,
      transportEquipmentSeal: null,
      minimumTemperature: null,
      maximumTemperature: null,
      providerParty: null,
      loadingProofParty: null,
      supplierParty: null,
      ownerParty: null,
      operatingParty: null,
      loadingLocation: null,
      unloadingLocation: null,
      storageLocation: null,
      positioningTransportEvent: null,
      quarantineTransportEvent: null,
      deliveryTransportEvent: null,
      pickupTransportEvent: null,
      handlingTransportEvent: null,
      loadingTransportEvent: null,
      transportEvent: null,
      applicableTransportMeans: null,
      haulageTradingTerms: null,
      hazardousGoodsTransit: null,
      packagedTransportHandlingUnit: null,
      serviceAllowanceCharge: null,
      freightAllowanceCharge: null,
      attachedTransportEquipment: null,
      delivery: null,
      pickup: null,
      despatch: null,
      shipmentDocumentReference: null,
      containedInTransportEquipment: null,
      package: null,
      goodsItem: null,
    );
  }

}

