import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/ShippingPriorityLevelCode.dart';
import '../cbc/HandlingCode.dart';
import '../cbc/HandlingInstructions.dart';
import '../cbc/Information.dart';
import '../cbc/GrossWeightMeasure.dart';
import '../cbc/NetWeightMeasure.dart';
import '../cbc/NetNetWeightMeasure.dart';
import '../cbc/GrossVolumeMeasure.dart';
import '../cbc/NetVolumeMeasure.dart';
import '../cbc/TotalGoodsItemQuantity.dart';
import '../cbc/TotalTransportHandlingUnitQuantity.dart';
import '../cbc/InsuranceValueAmount.dart';
import '../cbc/DeclaredCustomsValueAmount.dart';
import '../cbc/DeclaredForCarriageValueAmount.dart';
import '../cbc/DeclaredStatisticsValueAmount.dart';
import '../cbc/FreeOnBoardValueAmount.dart';
import '../cbc/SpecialInstructions.dart';
import '../cbc/DeliveryInstructions.dart';
import '../cbc/SplitConsignmentIndicator.dart';
import '../cbc/ConsignmentQuantity.dart';
import '../cac/Consignment.dart';
import '../cac/GoodsItem.dart';
import '../cac/ShipmentStage.dart';
import '../cac/Delivery.dart';
import '../cac/TransportHandlingUnit.dart';
import '../cac/ReturnAddress.dart';
import '../cac/OriginAddress.dart';
import '../cac/FirstArrivalPortLocation.dart';
import '../cac/LastExitPortLocation.dart';
import '../cac/ExportCountry.dart';
import '../cac/FreightAllowanceCharge.dart';

// A class defining an identifiable collection of one or more goods items to be transported between the seller party and the buyer party. This information may be defined within a commercial contract. A shipment can be transported in different consignments (e.g., split for logistical purposes).
class ReferencedShipment {


  // An identifier for this shipment.
  final ID iD;

  // A code signifying the priority or level of service required for this shipment.
  final ShippingPriorityLevelCode? shippingPriorityLevelCode;

  // The handling required for this shipment, expressed as a code.
  final HandlingCode? handlingCode;

  // The handling required for this shipment, expressed as text.
  final List<HandlingInstructions> handlingInstructions;

  // Free-form text pertinent to this shipment, conveying information that is not contained explicitly in other structures.
  final List<Information> information;

  // The total gross weight of a shipment; the weight of the goods plus packaging plus transport equipment.
  final GrossWeightMeasure? grossWeightMeasure;

  // The net weight of this shipment, excluding packaging.
  final NetWeightMeasure? netWeightMeasure;

  // The total net weight of this shipment, excluding packaging and transport equipment.
  final NetNetWeightMeasure? netNetWeightMeasure;

  // The total volume of the goods in this shipment, including packaging.
  final GrossVolumeMeasure? grossVolumeMeasure;

  // The total volume of the goods in this shipment, excluding packaging and transport equipment.
  final NetVolumeMeasure? netVolumeMeasure;

  // The total number of goods items in this shipment.
  final TotalGoodsItemQuantity? totalGoodsItemQuantity;

  // The number of pieces of transport handling equipment (pallets, boxes, cases, etc.) in this shipment.
  final TotalTransportHandlingUnitQuantity? totalTransportHandlingUnitQuantity;

  // The amount covered by insurance for this shipment.
  final InsuranceValueAmount? insuranceValueAmount;

  // The total declared value for customs purposes of those goods in this shipment that are subject to the same customs procedure and have the same tariff/statistical heading, country information, and duty regime.
  final DeclaredCustomsValueAmount? declaredCustomsValueAmount;

  // The value of this shipment, declared by the shipper or his agent solely for the purpose of varying the carrier's level of liability from that provided in the contract of carriage, in case of loss or damage to goods or delayed delivery.
  final DeclaredForCarriageValueAmount? declaredForCarriageValueAmount;

  // The value, declared for statistical purposes, of those goods in this shipment that have the same statistical heading.
  final DeclaredStatisticsValueAmount? declaredStatisticsValueAmount;

  // The monetary amount that has to be or has been paid as calculated under the applicable trade delivery.
  final FreeOnBoardValueAmount? freeOnBoardValueAmount;

  // Special instructions relating to this shipment.
  final List<SpecialInstructions> specialInstructions;

  // Delivery instructions relating to this shipment.
  final List<DeliveryInstructions> deliveryInstructions;

  // An indicator that the consignment has been split in transit (true) or not (false).
  final SplitConsignmentIndicator? splitConsignmentIndicator;

  // The total number of consignments within this shipment.
  final ConsignmentQuantity? consignmentQuantity;

  // A consignment covering this shipment.
  final List<Consignment> consignment;

  // A goods item included in this shipment.
  final List<GoodsItem> goodsItem;

  // A stage in the transport movement of this shipment.
  final List<ShipmentStage> shipmentStage;

  // The delivery of this shipment.
  final Delivery? delivery;

  // A transport handling unit associated with this shipment.
  final List<TransportHandlingUnit> transportHandlingUnit;

  // The address to which a shipment should be returned.
  final ReturnAddress? returnAddress;

  // The region in which the goods have been produced or manufactured, according to criteria laid down for the purposes of application of the customs tariff, or of quantitative restrictions, or of any other measure related to trade.
  final OriginAddress? originAddress;

  // The first arrival location of a shipment. This would be a port for sea, an airport for air, a terminal for rail, or a border post for land crossing.
  final FirstArrivalPortLocation? firstArrivalPortLocation;

  // The final exporting location for a shipment. This would be a port for sea, an airport for air, a terminal for rail, or a border post for land crossing.
  final LastExitPortLocation? lastExitPortLocation;

  // The country from which the goods were originally exported, without any commercial transaction taking place in intermediate countries.
  final ExportCountry? exportCountry;

  // A cost incurred by the shipper in moving goods, by whatever means, from one place to another under the terms of the contract of carriage. In addition to transport costs, this may include such elements as packing, documentation, loading, unloading, and insurance to the extent that they relate to the freight costs.
  final List<FreightAllowanceCharge> freightAllowanceCharge;

  ReferencedShipment ({
    required this.iD,
    this.shippingPriorityLevelCode,
    this.handlingCode,
    this.handlingInstructions = const [],
    this.information = const [],
    this.grossWeightMeasure,
    this.netWeightMeasure,
    this.netNetWeightMeasure,
    this.grossVolumeMeasure,
    this.netVolumeMeasure,
    this.totalGoodsItemQuantity,
    this.totalTransportHandlingUnitQuantity,
    this.insuranceValueAmount,
    this.declaredCustomsValueAmount,
    this.declaredForCarriageValueAmount,
    this.declaredStatisticsValueAmount,
    this.freeOnBoardValueAmount,
    this.specialInstructions = const [],
    this.deliveryInstructions = const [],
    this.splitConsignmentIndicator,
    this.consignmentQuantity,
    this.consignment = const [],
    this.goodsItem = const [],
    this.shipmentStage = const [],
    this.delivery,
    this.transportHandlingUnit = const [],
    this.returnAddress,
    this.originAddress,
    this.firstArrivalPortLocation,
    this.lastExitPortLocation,
    this.exportCountry,
    this.freightAllowanceCharge = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'shippingPriorityLevelCode': shippingPriorityLevelCode?.toJson(),
      'handlingCode': handlingCode?.toJson(),
      'handlingInstructions': handlingInstructions.map((e) => e.toJson()).toList(),
      'information': information.map((e) => e.toJson()).toList(),
      'grossWeightMeasure': grossWeightMeasure?.toJson(),
      'netWeightMeasure': netWeightMeasure?.toJson(),
      'netNetWeightMeasure': netNetWeightMeasure?.toJson(),
      'grossVolumeMeasure': grossVolumeMeasure?.toJson(),
      'netVolumeMeasure': netVolumeMeasure?.toJson(),
      'totalGoodsItemQuantity': totalGoodsItemQuantity?.toJson(),
      'totalTransportHandlingUnitQuantity': totalTransportHandlingUnitQuantity?.toJson(),
      'insuranceValueAmount': insuranceValueAmount?.toJson(),
      'declaredCustomsValueAmount': declaredCustomsValueAmount?.toJson(),
      'declaredForCarriageValueAmount': declaredForCarriageValueAmount?.toJson(),
      'declaredStatisticsValueAmount': declaredStatisticsValueAmount?.toJson(),
      'freeOnBoardValueAmount': freeOnBoardValueAmount?.toJson(),
      'specialInstructions': specialInstructions.map((e) => e.toJson()).toList(),
      'deliveryInstructions': deliveryInstructions.map((e) => e.toJson()).toList(),
      'splitConsignmentIndicator': splitConsignmentIndicator?.toJson(),
      'consignmentQuantity': consignmentQuantity?.toJson(),
      'consignment': consignment.map((e) => e.toJson()).toList(),
      'goodsItem': goodsItem.map((e) => e.toJson()).toList(),
      'shipmentStage': shipmentStage.map((e) => e.toJson()).toList(),
      'delivery': delivery?.toJson(),
      'transportHandlingUnit': transportHandlingUnit.map((e) => e.toJson()).toList(),
      'returnAddress': returnAddress?.toJson(),
      'originAddress': originAddress?.toJson(),
      'firstArrivalPortLocation': firstArrivalPortLocation?.toJson(),
      'lastExitPortLocation': lastExitPortLocation?.toJson(),
      'exportCountry': exportCountry?.toJson(),
      'freightAllowanceCharge': freightAllowanceCharge.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ReferencedShipment? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ReferencedShipment (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      shippingPriorityLevelCode: ShippingPriorityLevelCode.fromJson(json['shippingPriorityLevelCode'] as Map<String, dynamic>?),
      handlingCode: HandlingCode.fromJson(json['handlingCode'] as Map<String, dynamic>?),
      handlingInstructions: (json['handlingInstructions'] as List? ?? []).map((dynamic d) => HandlingInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      information: (json['information'] as List? ?? []).map((dynamic d) => Information.fromJson(d as Map<String, dynamic>?)!).toList(),
      grossWeightMeasure: GrossWeightMeasure.fromJson(json['grossWeightMeasure'] as Map<String, dynamic>?),
      netWeightMeasure: NetWeightMeasure.fromJson(json['netWeightMeasure'] as Map<String, dynamic>?),
      netNetWeightMeasure: NetNetWeightMeasure.fromJson(json['netNetWeightMeasure'] as Map<String, dynamic>?),
      grossVolumeMeasure: GrossVolumeMeasure.fromJson(json['grossVolumeMeasure'] as Map<String, dynamic>?),
      netVolumeMeasure: NetVolumeMeasure.fromJson(json['netVolumeMeasure'] as Map<String, dynamic>?),
      totalGoodsItemQuantity: TotalGoodsItemQuantity.fromJson(json['totalGoodsItemQuantity'] as Map<String, dynamic>?),
      totalTransportHandlingUnitQuantity: TotalTransportHandlingUnitQuantity.fromJson(json['totalTransportHandlingUnitQuantity'] as Map<String, dynamic>?),
      insuranceValueAmount: InsuranceValueAmount.fromJson(json['insuranceValueAmount'] as Map<String, dynamic>?),
      declaredCustomsValueAmount: DeclaredCustomsValueAmount.fromJson(json['declaredCustomsValueAmount'] as Map<String, dynamic>?),
      declaredForCarriageValueAmount: DeclaredForCarriageValueAmount.fromJson(json['declaredForCarriageValueAmount'] as Map<String, dynamic>?),
      declaredStatisticsValueAmount: DeclaredStatisticsValueAmount.fromJson(json['declaredStatisticsValueAmount'] as Map<String, dynamic>?),
      freeOnBoardValueAmount: FreeOnBoardValueAmount.fromJson(json['freeOnBoardValueAmount'] as Map<String, dynamic>?),
      specialInstructions: (json['specialInstructions'] as List? ?? []).map((dynamic d) => SpecialInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      deliveryInstructions: (json['deliveryInstructions'] as List? ?? []).map((dynamic d) => DeliveryInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      splitConsignmentIndicator: SplitConsignmentIndicator.fromJson(json['splitConsignmentIndicator'] as Map<String, dynamic>?),
      consignmentQuantity: ConsignmentQuantity.fromJson(json['consignmentQuantity'] as Map<String, dynamic>?),
      consignment: (json['consignment'] as List? ?? []).map((dynamic d) => Consignment.fromJson(d as Map<String, dynamic>?)!).toList(),
      goodsItem: (json['goodsItem'] as List? ?? []).map((dynamic d) => GoodsItem.fromJson(d as Map<String, dynamic>?)!).toList(),
      shipmentStage: (json['shipmentStage'] as List? ?? []).map((dynamic d) => ShipmentStage.fromJson(d as Map<String, dynamic>?)!).toList(),
      delivery: Delivery.fromJson(json['delivery'] as Map<String, dynamic>?),
      transportHandlingUnit: (json['transportHandlingUnit'] as List? ?? []).map((dynamic d) => TransportHandlingUnit.fromJson(d as Map<String, dynamic>?)!).toList(),
      returnAddress: ReturnAddress.fromJson(json['returnAddress'] as Map<String, dynamic>?),
      originAddress: OriginAddress.fromJson(json['originAddress'] as Map<String, dynamic>?),
      firstArrivalPortLocation: FirstArrivalPortLocation.fromJson(json['firstArrivalPortLocation'] as Map<String, dynamic>?),
      lastExitPortLocation: LastExitPortLocation.fromJson(json['lastExitPortLocation'] as Map<String, dynamic>?),
      exportCountry: ExportCountry.fromJson(json['exportCountry'] as Map<String, dynamic>?),
      freightAllowanceCharge: (json['freightAllowanceCharge'] as List? ?? []).map((dynamic d) => FreightAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static ReferencedShipment? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ReferencedShipment (
      iD: null,
      shippingPriorityLevelCode: null,
      handlingCode: null,
      handlingInstructions: null,
      information: null,
      grossWeightMeasure: null,
      netWeightMeasure: null,
      netNetWeightMeasure: null,
      grossVolumeMeasure: null,
      netVolumeMeasure: null,
      totalGoodsItemQuantity: null,
      totalTransportHandlingUnitQuantity: null,
      insuranceValueAmount: null,
      declaredCustomsValueAmount: null,
      declaredForCarriageValueAmount: null,
      declaredStatisticsValueAmount: null,
      freeOnBoardValueAmount: null,
      specialInstructions: null,
      deliveryInstructions: null,
      splitConsignmentIndicator: null,
      consignmentQuantity: null,
      consignment: null,
      goodsItem: null,
      shipmentStage: null,
      delivery: null,
      transportHandlingUnit: null,
      returnAddress: null,
      originAddress: null,
      firstArrivalPortLocation: null,
      lastExitPortLocation: null,
      exportCountry: null,
      freightAllowanceCharge: null,
    );
  }

}

