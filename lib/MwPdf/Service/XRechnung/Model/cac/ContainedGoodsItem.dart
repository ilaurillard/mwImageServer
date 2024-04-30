import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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
import '../cbc/CustomsProcedureCode.dart';
import '../cbc/CustomsTariffQuantity.dart';
import '../cbc/CustomsImportClassifiedIndicator.dart';
import '../cbc/ChargeableQuantity.dart';
import '../cbc/ReturnableQuantity.dart';
import '../cbc/TraceID.dart';
import '../cac/Item.dart';
import '../cac/GoodsItemContainer.dart';
import '../cac/FreightAllowanceCharge.dart';
import '../cac/InvoiceLine.dart';
import '../cac/OrderLineReference.dart';
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


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // A code assigned by customs to signifying the customs procedure applied to this Goods Item.
  final CustomsProcedureCode? customsProcedureCode;

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

  // A reference to an order line associated with this goods item.
  final List<OrderLineReference> orderLineReference;

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
    this.uBLExtensions,
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
    this.customsProcedureCode,
    this.customsTariffQuantity,
    this.customsImportClassifiedIndicator,
    this.chargeableQuantity,
    this.returnableQuantity,
    this.traceID,
    this.item = const [],
    this.goodsItemContainer = const [],
    this.freightAllowanceCharge = const [],
    this.invoiceLine = const [],
    this.orderLineReference = const [],
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

  static ContainedGoodsItem? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ContainedGoodsItem (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
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
      customsProcedureCode: CustomsProcedureCode.fromJson(json['customsProcedureCode'] as Map<String, dynamic>?),
      customsTariffQuantity: CustomsTariffQuantity.fromJson(json['customsTariffQuantity'] as Map<String, dynamic>?),
      customsImportClassifiedIndicator: CustomsImportClassifiedIndicator.fromJson(json['customsImportClassifiedIndicator'] as Map<String, dynamic>?),
      chargeableQuantity: ChargeableQuantity.fromJson(json['chargeableQuantity'] as Map<String, dynamic>?),
      returnableQuantity: ReturnableQuantity.fromJson(json['returnableQuantity'] as Map<String, dynamic>?),
      traceID: TraceID.fromJson(json['traceID'] as Map<String, dynamic>?),
      item: (json['item'] as List? ?? []).map((dynamic d) => Item.fromJson(d as Map<String, dynamic>?)!).toList(),
      goodsItemContainer: (json['goodsItemContainer'] as List? ?? []).map((dynamic d) => GoodsItemContainer.fromJson(d as Map<String, dynamic>?)!).toList(),
      freightAllowanceCharge: (json['freightAllowanceCharge'] as List? ?? []).map((dynamic d) => FreightAllowanceCharge.fromJson(d as Map<String, dynamic>?)!).toList(),
      invoiceLine: (json['invoiceLine'] as List? ?? []).map((dynamic d) => InvoiceLine.fromJson(d as Map<String, dynamic>?)!).toList(),
      orderLineReference: (json['orderLineReference'] as List? ?? []).map((dynamic d) => OrderLineReference.fromJson(d as Map<String, dynamic>?)!).toList(),
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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
      'customsProcedureCode': customsProcedureCode?.toJson(),
      'customsTariffQuantity': customsTariffQuantity?.toJson(),
      'customsImportClassifiedIndicator': customsImportClassifiedIndicator?.toJson(),
      'chargeableQuantity': chargeableQuantity?.toJson(),
      'returnableQuantity': returnableQuantity?.toJson(),
      'traceID': traceID?.toJson(),
      'item': item.map((e) => e.toJson()).toList(),
      'goodsItemContainer': goodsItemContainer.map((e) => e.toJson()).toList(),
      'freightAllowanceCharge': freightAllowanceCharge.map((e) => e.toJson()).toList(),
      'invoiceLine': invoiceLine.map((e) => e.toJson()).toList(),
      'orderLineReference': orderLineReference.map((e) => e.toJson()).toList(),
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

  static ContainedGoodsItem? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ContainedGoodsItem (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      sequenceNumberID: SequenceNumberID.fromXml(xml.findElements('cbc:SequenceNumberID').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
      declaredCustomsValueAmount: DeclaredCustomsValueAmount.fromXml(xml.findElements('cbc:DeclaredCustomsValueAmount').singleOrNull),
      declaredForCarriageValueAmount: DeclaredForCarriageValueAmount.fromXml(xml.findElements('cbc:DeclaredForCarriageValueAmount').singleOrNull),
      declaredStatisticsValueAmount: DeclaredStatisticsValueAmount.fromXml(xml.findElements('cbc:DeclaredStatisticsValueAmount').singleOrNull),
      freeOnBoardValueAmount: FreeOnBoardValueAmount.fromXml(xml.findElements('cbc:FreeOnBoardValueAmount').singleOrNull),
      insuranceValueAmount: InsuranceValueAmount.fromXml(xml.findElements('cbc:InsuranceValueAmount').singleOrNull),
      valueAmount: ValueAmount.fromXml(xml.findElements('cbc:ValueAmount').singleOrNull),
      grossWeightMeasure: GrossWeightMeasure.fromXml(xml.findElements('cbc:GrossWeightMeasure').singleOrNull),
      netWeightMeasure: NetWeightMeasure.fromXml(xml.findElements('cbc:NetWeightMeasure').singleOrNull),
      netNetWeightMeasure: NetNetWeightMeasure.fromXml(xml.findElements('cbc:NetNetWeightMeasure').singleOrNull),
      chargeableWeightMeasure: ChargeableWeightMeasure.fromXml(xml.findElements('cbc:ChargeableWeightMeasure').singleOrNull),
      grossVolumeMeasure: GrossVolumeMeasure.fromXml(xml.findElements('cbc:GrossVolumeMeasure').singleOrNull),
      netVolumeMeasure: NetVolumeMeasure.fromXml(xml.findElements('cbc:NetVolumeMeasure').singleOrNull),
      quantity: Quantity.fromXml(xml.findElements('cbc:Quantity').singleOrNull),
      preferenceCriterionCode: PreferenceCriterionCode.fromXml(xml.findElements('cbc:PreferenceCriterionCode').singleOrNull),
      requiredCustomsID: RequiredCustomsID.fromXml(xml.findElements('cbc:RequiredCustomsID').singleOrNull),
      customsStatusCode: CustomsStatusCode.fromXml(xml.findElements('cbc:CustomsStatusCode').singleOrNull),
      customsProcedureCode: CustomsProcedureCode.fromXml(xml.findElements('cbc:CustomsProcedureCode').singleOrNull),
      customsTariffQuantity: CustomsTariffQuantity.fromXml(xml.findElements('cbc:CustomsTariffQuantity').singleOrNull),
      customsImportClassifiedIndicator: CustomsImportClassifiedIndicator.fromXml(xml.findElements('cbc:CustomsImportClassifiedIndicator').singleOrNull),
      chargeableQuantity: ChargeableQuantity.fromXml(xml.findElements('cbc:ChargeableQuantity').singleOrNull),
      returnableQuantity: ReturnableQuantity.fromXml(xml.findElements('cbc:ReturnableQuantity').singleOrNull),
      traceID: TraceID.fromXml(xml.findElements('cbc:TraceID').singleOrNull),
      item: xml.findElements('cac:Item').map((XmlElement e) => Item.fromXml(e)!).toList(),
      goodsItemContainer: xml.findElements('cac:GoodsItemContainer').map((XmlElement e) => GoodsItemContainer.fromXml(e)!).toList(),
      freightAllowanceCharge: xml.findElements('cac:FreightAllowanceCharge').map((XmlElement e) => FreightAllowanceCharge.fromXml(e)!).toList(),
      invoiceLine: xml.findElements('cac:InvoiceLine').map((XmlElement e) => InvoiceLine.fromXml(e)!).toList(),
      orderLineReference: xml.findElements('cac:OrderLineReference').map((XmlElement e) => OrderLineReference.fromXml(e)!).toList(),
      temperature: xml.findElements('cac:Temperature').map((XmlElement e) => Temperature.fromXml(e)!).toList(),
      containedGoodsItem: xml.findElements('cac:ContainedGoodsItem').map((XmlElement e) => ContainedGoodsItem.fromXml(e)!).toList(),
      originAddress: OriginAddress.fromXml(xml.findElements('cac:OriginAddress').singleOrNull),
      delivery: Delivery.fromXml(xml.findElements('cac:Delivery').singleOrNull),
      pickup: Pickup.fromXml(xml.findElements('cac:Pickup').singleOrNull),
      despatch: Despatch.fromXml(xml.findElements('cac:Despatch').singleOrNull),
      measurementDimension: xml.findElements('cac:MeasurementDimension').map((XmlElement e) => MeasurementDimension.fromXml(e)!).toList(),
      containingPackage: xml.findElements('cac:ContainingPackage').map((XmlElement e) => ContainingPackage.fromXml(e)!).toList(),
      shipmentDocumentReference: ShipmentDocumentReference.fromXml(xml.findElements('cac:ShipmentDocumentReference').singleOrNull),
      minimumTemperature: MinimumTemperature.fromXml(xml.findElements('cac:MinimumTemperature').singleOrNull),
      maximumTemperature: MaximumTemperature.fromXml(xml.findElements('cac:MaximumTemperature').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      sequenceNumberID?.toXml(),
      ...description.map((Description e) => e.toXml()).toList(),
      hazardousRiskIndicator?.toXml(),
      declaredCustomsValueAmount?.toXml(),
      declaredForCarriageValueAmount?.toXml(),
      declaredStatisticsValueAmount?.toXml(),
      freeOnBoardValueAmount?.toXml(),
      insuranceValueAmount?.toXml(),
      valueAmount?.toXml(),
      grossWeightMeasure?.toXml(),
      netWeightMeasure?.toXml(),
      netNetWeightMeasure?.toXml(),
      chargeableWeightMeasure?.toXml(),
      grossVolumeMeasure?.toXml(),
      netVolumeMeasure?.toXml(),
      quantity?.toXml(),
      preferenceCriterionCode?.toXml(),
      requiredCustomsID?.toXml(),
      customsStatusCode?.toXml(),
      customsProcedureCode?.toXml(),
      customsTariffQuantity?.toXml(),
      customsImportClassifiedIndicator?.toXml(),
      chargeableQuantity?.toXml(),
      returnableQuantity?.toXml(),
      traceID?.toXml(),
      ...item.map((Item e) => e.toXml()).toList(),
      ...goodsItemContainer.map((GoodsItemContainer e) => e.toXml()).toList(),
      ...freightAllowanceCharge.map((FreightAllowanceCharge e) => e.toXml()).toList(),
      ...invoiceLine.map((InvoiceLine e) => e.toXml()).toList(),
      ...orderLineReference.map((OrderLineReference e) => e.toXml()).toList(),
      ...temperature.map((Temperature e) => e.toXml()).toList(),
      ...containedGoodsItem.map((ContainedGoodsItem e) => e.toXml()).toList(),
      originAddress?.toXml(),
      delivery?.toXml(),
      pickup?.toXml(),
      despatch?.toXml(),
      ...measurementDimension.map((MeasurementDimension e) => e.toXml()).toList(),
      ...containingPackage.map((ContainingPackage e) => e.toXml()).toList(),
      shipmentDocumentReference?.toXml(),
      minimumTemperature?.toXml(),
      maximumTemperature?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ContainedGoodsItem',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

