import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/SequenceNumberID.dart';
import '../cbc/Description.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/DeclaredCustomsValueAmount.dart';
import '../cbc/DeclaredForCarriageValueAmount.dart';
import '../cbc/DeclaredStatisticsValueAmount.dart';
import '../cbc/FreeOnBoardValueAmount.dart';
import '../cbc/InsuranceValueAmount.dart';
import '../cbc/ValueAmount.dart';
import '../cbc/GrossWeightMeasure.dart';
import '../cbc/NetWeightMeasure.dart';
import '../cbc/NetNetWeightMeasure.dart';
import '../cbc/ChargeableWeightMeasure.dart';
import '../cbc/GrossVolumeMeasure.dart';
import '../cbc/NetVolumeMeasure.dart';
import '../cbc/Quantity.dart';
import '../cbc/PreferenceCriterionCode.dart';
import '../cbc/RequiredCustomsID.dart';
import '../cbc/CustomsStatusCode.dart';
import '../cbc/CustomsTariffQuantity.dart';
import '../cbc/CustomsImportClassifiedIndicator.dart';
import '../cbc/ChargeableQuantity.dart';
import '../cbc/ReturnableQuantity.dart';
import '../cbc/TraceID.dart';
import '../cac/Item.dart';
import '../cac/GoodsItemContainer.dart';
import '../cac/FreightAllowanceCharge.dart';
import '../cac/InvoiceLine.dart';
import '../cac/Temperature.dart';
import '../cac/OriginAddress.dart';
import '../cac/Delivery.dart';
import '../cac/Pickup.dart';
import '../cac/Despatch.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/ContainingPackage.dart';
import '../cac/ShipmentDocumentReference.dart';
import '../cac/MinimumTemperature.dart';
import '../cac/MaximumTemperature.dart';

// A class to describe a separately identifiable quantity of goods of a single product type.
class ContainedGoodsItem {


  // An identifier for this goods item.
  final ID? iD;

  // A sequence number differentiating a specific goods item within a consignment.
  final SequenceNumberID? sequenceNumberID;

  // Text describing this goods item to identify it for customs, statistical, or transport purposes.
  final List<Description> description;

  // An indication that the transported goods item is subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // The total declared value for customs purposes of the goods item.
  final DeclaredCustomsValueAmount? declaredCustomsValueAmount;

  // The value of this goods item, declared by the shipper or his agent solely for the purpose of varying the carrier's level of liability from that provided in the contract of carriage, in case of loss or damage to goods or delayed delivery.
  final DeclaredForCarriageValueAmount? declaredForCarriageValueAmount;

  // The total declared value of all the goods items in the same consignment with this goods item that have the same statistical heading.
  final DeclaredStatisticsValueAmount? declaredStatisticsValueAmount;

  // The monetary amount that has to be or has been paid as calculated under the applicable trade delivery.
  final FreeOnBoardValueAmount? freeOnBoardValueAmount;

  // The amount covered by insurance for this goods item.
  final InsuranceValueAmount? insuranceValueAmount;

  // The amount on which a duty, tax, or fee will be assessed.
  final ValueAmount? valueAmount;

  // The weight of this goods item, including packing and packaging but excluding the carrier's equipment.
  final GrossWeightMeasure? grossWeightMeasure;

  // The weight of this goods item, excluding packing but including packaging that normally accompanies the goods.
  final NetWeightMeasure? netWeightMeasure;

  // The total weight of this goods item, excluding all packing and packaging.
  final NetNetWeightMeasure? netNetWeightMeasure;

  // The weight on which a charge is to be based.
  final ChargeableWeightMeasure? chargeableWeightMeasure;

  // The volume of this goods item, normally calculated by multiplying its maximum length, width, and height.
  final GrossVolumeMeasure? grossVolumeMeasure;

  // The volume contained by a goods item, excluding the volume of any packaging material.
  final NetVolumeMeasure? netVolumeMeasure;

  // The number of units making up this goods item.
  final Quantity? quantity;

  // A code signifying the treatment preference for this goods item according to international trading agreements.
  final PreferenceCriterionCode? preferenceCriterionCode;

  // An identifier for a set of tariff codes required to specify a type of goods for customs, transport, statistical, or other regulatory purposes.
  final RequiredCustomsID? requiredCustomsID;

  // A code assigned by customs to signify the status of this goods item.
  final CustomsStatusCode? customsStatusCode;

  // Quantity of the units in this goods item as required by customs for tariff, statistical, or fiscal purposes.
  final CustomsTariffQuantity? customsTariffQuantity;

  // An indicator that this goods item has been classified for import by customs (true) or not (false).
  final CustomsImportClassifiedIndicator? customsImportClassifiedIndicator;

  // The number of units in the goods item to which charges apply.
  final ChargeableQuantity? chargeableQuantity;

  // The number of units in the goods item that may be returned.
  final ReturnableQuantity? returnableQuantity;

  // An identifier for use in tracing this goods item, such as the EPC number used in RFID.
  final TraceID? traceID;

  // Product information relating to a goods item.
  final List<Item> item;

  // The transporting of a goods item in a unit of transport equipment (e.g., container).
  final List<GoodsItemContainer> goodsItemContainer;

  // A cost incurred by the shipper in moving goods, by whatever means, from one place to another under the terms of the contract of carriage. In addition to transport costs, this may include such elements as packing, documentation, loading, unloading, and insurance to the extent that they relate to the freight costs.
  final List<FreightAllowanceCharge> freightAllowanceCharge;

  // Information about an invoice line relating to this goods item.
  final List<InvoiceLine> invoiceLine;

  // The temperature of the goods item.
  final List<Temperature> temperature;

  // A goods item contained in this goods item.
  final List<ContainedGoodsItem> containedGoodsItem;

  // The region in which the goods have been produced or manufactured, according to criteria laid down for the purposes of application of the customs tariff, or of quantitative restrictions, or of any other measure related to trade.
  final OriginAddress? originAddress;

  // The delivery of this goods item.
  final Delivery? delivery;

  // The pickup of this goods item.
  final Pickup? pickup;

  // The despatch of this goods item.
  final Despatch? despatch;

  // A measurable dimension (length, mass, weight, or volume) of this goods item.
  final List<MeasurementDimension> measurementDimension;

  // A package containing this goods item.
  final List<ContainingPackage> containingPackage;

  // A reference to a shipping document associated with this goods item.
  final ShipmentDocumentReference? shipmentDocumentReference;

  // Information about minimum temperature.
  final MinimumTemperature? minimumTemperature;

  // Information about maximum temperature.
  final MaximumTemperature? maximumTemperature;

  ContainedGoodsItem ({
    this.iD,
    this.sequenceNumberID,
    this.description = const [],
    this.hazardousRiskIndicator,
    this.declaredCustomsValueAmount,
    this.declaredForCarriageValueAmount,
    this.declaredStatisticsValueAmount,
    this.freeOnBoardValueAmount,
    this.insuranceValueAmount,
    this.valueAmount,
    this.grossWeightMeasure,
    this.netWeightMeasure,
    this.netNetWeightMeasure,
    this.chargeableWeightMeasure,
    this.grossVolumeMeasure,
    this.netVolumeMeasure,
    this.quantity,
    this.preferenceCriterionCode,
    this.requiredCustomsID,
    this.customsStatusCode,
    this.customsTariffQuantity,
    this.customsImportClassifiedIndicator,
    this.chargeableQuantity,
    this.returnableQuantity,
    this.traceID,
    this.item = const [],
    this.goodsItemContainer = const [],
    this.freightAllowanceCharge = const [],
    this.invoiceLine = const [],
    this.temperature = const [],
    this.containedGoodsItem = const [],
    this.originAddress,
    this.delivery,
    this.pickup,
    this.despatch,
    this.measurementDimension = const [],
    this.containingPackage = const [],
    this.shipmentDocumentReference,
    this.minimumTemperature,
    this.maximumTemperature,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'sequenceNumberID': sequenceNumberID?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
      'declaredCustomsValueAmount': declaredCustomsValueAmount?.toJson(),
      'declaredForCarriageValueAmount': declaredForCarriageValueAmount?.toJson(),
      'declaredStatisticsValueAmount': declaredStatisticsValueAmount?.toJson(),
      'freeOnBoardValueAmount': freeOnBoardValueAmount?.toJson(),
      'insuranceValueAmount': insuranceValueAmount?.toJson(),
      'valueAmount': valueAmount?.toJson(),
      'grossWeightMeasure': grossWeightMeasure?.toJson(),
      'netWeightMeasure': netWeightMeasure?.toJson(),
      'netNetWeightMeasure': netNetWeightMeasure?.toJson(),
      'chargeableWeightMeasure': chargeableWeightMeasure?.toJson(),
      'grossVolumeMeasure': grossVolumeMeasure?.toJson(),
      'netVolumeMeasure': netVolumeMeasure?.toJson(),
      'quantity': quantity?.toJson(),
      'preferenceCriterionCode': preferenceCriterionCode?.toJson(),
      'requiredCustomsID': requiredCustomsID?.toJson(),
      'customsStatusCode': customsStatusCode?.toJson(),
      'customsTariffQuantity': customsTariffQuantity?.toJson(),
      'customsImportClassifiedIndicator': customsImportClassifiedIndicator?.toJson(),
      'chargeableQuantity': chargeableQuantity?.toJson(),
      'returnableQuantity': returnableQuantity?.toJson(),
      'traceID': traceID?.toJson(),
      'item': item.map((e) => e.toJson()).toList(),
      'goodsItemContainer': goodsItemContainer.map((e) => e.toJson()).toList(),
      'freightAllowanceCharge': freightAllowanceCharge.map((e) => e.toJson()).toList(),
      'invoiceLine': invoiceLine.map((e) => e.toJson()).toList(),
      'temperature': temperature.map((e) => e.toJson()).toList(),
      'containedGoodsItem': containedGoodsItem.map((e) => e.toJson()).toList(),
      'originAddress': originAddress?.toJson(),
      'delivery': delivery?.toJson(),
      'pickup': pickup?.toJson(),
      'despatch': despatch?.toJson(),
      'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
      'containingPackage': containingPackage.map((e) => e.toJson()).toList(),
      'shipmentDocumentReference': shipmentDocumentReference?.toJson(),
      'minimumTemperature': minimumTemperature?.toJson(),
      'maximumTemperature': maximumTemperature?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ContainedGoodsItem? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ContainedGoodsItem (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      sequenceNumberID: SequenceNumberID.fromJson(json['sequenceNumberID'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
      declaredCustomsValueAmount: DeclaredCustomsValueAmount.fromJson(json['declaredCustomsValueAmount'] as Map<String, dynamic>?),
      declaredForCarriageValueAmount: DeclaredForCarriageValueAmount.fromJson(json['declaredForCarriageValueAmount'] as Map<String, dynamic>?),
      declaredStatisticsValueAmount: DeclaredStatisticsValueAmount.fromJson(json['declaredStatisticsValueAmount'] as Map<String, dynamic>?),
      freeOnBoardValueAmount: FreeOnBoardValueAmount.fromJson(json['freeOnBoardValueAmount'] as Map<String, dynamic>?),
      insuranceValueAmount: InsuranceValueAmount.fromJson(json['insuranceValueAmount'] as Map<String, dynamic>?),
      valueAmount: ValueAmount.fromJson(json['valueAmount'] as Map<String, dynamic>?),
      grossWeightMeasure: GrossWeightMeasure.fromJson(json['grossWeightMeasure'] as Map<String, dynamic>?),
      netWeightMeasure: NetWeightMeasure.fromJson(json['netWeightMeasure'] as Map<String, dynamic>?),
      netNetWeightMeasure: NetNetWeightMeasure.fromJson(json['netNetWeightMeasure'] as Map<String, dynamic>?),
      chargeableWeightMeasure: ChargeableWeightMeasure.fromJson(json['chargeableWeightMeasure'] as Map<String, dynamic>?),
      grossVolumeMeasure: GrossVolumeMeasure.fromJson(json['grossVolumeMeasure'] as Map<String, dynamic>?),
      netVolumeMeasure: NetVolumeMeasure.fromJson(json['netVolumeMeasure'] as Map<String, dynamic>?),
      quantity: Quantity.fromJson(json['quantity'] as Map<String, dynamic>?),
      preferenceCriterionCode: PreferenceCriterionCode.fromJson(json['preferenceCriterionCode'] as Map<String, dynamic>?),
      requiredCustomsID: RequiredCustomsID.fromJson(json['requiredCustomsID'] as Map<String, dynamic>?),
      customsStatusCode: CustomsStatusCode.fromJson(json['customsStatusCode'] as Map<String, dynamic>?),
      customsTariffQuantity: CustomsTariffQuantity.fromJson(json['customsTariffQuantity'] as Map<String, dynamic>?),
      customsImportClassifiedIndicator: CustomsImportClassifiedIndicator.fromJson(json['customsImportClassifiedIndicator'] as Map<String, dynamic>?),
      chargeableQuantity: ChargeableQuantity.fromJson(json['chargeableQuantity'] as Map<String, dynamic>?),
      returnableQuantity: ReturnableQuantity.fromJson(json['returnableQuantity'] as Map<String, dynamic>?),
      traceID: TraceID.fromJson(json['traceID'] as Map<String, dynamic>?),
      item: (json['item'] as List? ?? []).map((dynamic d) => Item.fromJson(d as Map<String, dynamic>?)!).toList(),
      goodsItemContainer: (json['goodsItemContainer'] as List? ?? []).map((dynamic d) => GoodsItemContainer.fromJson(d as Map<String, dynamic>?)!).toList(),
      freightAllowanceCharge: (json['freightAllowanceCharge'] as List? ?? []).map((dynamic d) => FreightAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      invoiceLine: (json['invoiceLine'] as List? ?? []).map((dynamic d) => InvoiceLine.fromJson(d as Map<String, dynamic>?)!).toList(),
      temperature: (json['temperature'] as List? ?? []).map((dynamic d) => Temperature.fromJson(d as Map<String, dynamic>?)!).toList(),
      containedGoodsItem: (json['containedGoodsItem'] as List? ?? []).map((dynamic d) => ContainedGoodsItem.fromJson(d as Map<String, dynamic>?)!).toList(),
      originAddress: OriginAddress.fromJson(json['originAddress'] as Map<String, dynamic>?),
      delivery: Delivery.fromJson(json['delivery'] as Map<String, dynamic>?),
      pickup: Pickup.fromJson(json['pickup'] as Map<String, dynamic>?),
      despatch: Despatch.fromJson(json['despatch'] as Map<String, dynamic>?),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      containingPackage: (json['containingPackage'] as List? ?? []).map((dynamic d) => ContainingPackage.fromJson(d as Map<String, dynamic>?)!).toList(),
      shipmentDocumentReference: ShipmentDocumentReference.fromJson(json['shipmentDocumentReference'] as Map<String, dynamic>?),
      minimumTemperature: MinimumTemperature.fromJson(json['minimumTemperature'] as Map<String, dynamic>?),
      maximumTemperature: MaximumTemperature.fromJson(json['maximumTemperature'] as Map<String, dynamic>?),
    );
  }

  static ContainedGoodsItem? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ContainedGoodsItem (
      iD: null,
      sequenceNumberID: null,
      description: null,
      hazardousRiskIndicator: null,
      declaredCustomsValueAmount: null,
      declaredForCarriageValueAmount: null,
      declaredStatisticsValueAmount: null,
      freeOnBoardValueAmount: null,
      insuranceValueAmount: null,
      valueAmount: null,
      grossWeightMeasure: null,
      netWeightMeasure: null,
      netNetWeightMeasure: null,
      chargeableWeightMeasure: null,
      grossVolumeMeasure: null,
      netVolumeMeasure: null,
      quantity: null,
      preferenceCriterionCode: null,
      requiredCustomsID: null,
      customsStatusCode: null,
      customsTariffQuantity: null,
      customsImportClassifiedIndicator: null,
      chargeableQuantity: null,
      returnableQuantity: null,
      traceID: null,
      item: null,
      goodsItemContainer: null,
      freightAllowanceCharge: null,
      invoiceLine: null,
      temperature: null,
      containedGoodsItem: null,
      originAddress: null,
      delivery: null,
      pickup: null,
      despatch: null,
      measurementDimension: null,
      containingPackage: null,
      shipmentDocumentReference: null,
      minimumTemperature: null,
      maximumTemperature: null,
    );
  }

}

