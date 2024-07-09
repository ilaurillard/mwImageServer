// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/TransportHandlingUnitTypeCode.dart';
import '../cbc/HandlingCode.dart';
import '../cbc/HandlingInstructions.dart';
import '../cbc/HazardousRiskIndicator.dart';
import '../cbc/TotalGoodsItemQuantity.dart';
import '../cbc/TotalPackageQuantity.dart';
import '../cbc/DamageRemarks.dart';
import '../cbc/ShippingMarks.dart';
import '../cbc/TraceID.dart';
import '../cac/HandlingUnitDespatchLine.dart';
import '../cac/ActualPackage.dart';
import '../cac/ReceivedHandlingUnitReceiptLine.dart';
import '../cac/TransportEquipment.dart';
import '../cac/TransportMeans.dart';
import '../cac/HazardousGoodsTransit.dart';
import '../cac/MeasurementDimension.dart';
import '../cac/MinimumTemperature.dart';
import '../cac/MaximumTemperature.dart';
import '../cac/GoodsItem.dart';
import '../cac/FloorSpaceMeasurementDimension.dart';
import '../cac/PalletSpaceMeasurementDimension.dart';
import '../cac/ShipmentDocumentReference.dart';
import '../cac/Status.dart';
import '../cac/CustomsDeclaration.dart';
import '../cac/ReferencedShipment.dart';
import '../cac/Package.dart';
import '../cac/DamageDocumentationAttachment.dart';

// A class to describe a uniquely identifiable unit consisting of one or more packages, goods items, or pieces of transport equipment.
class TransportHandlingUnit {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this transport handling unit.
  final ID? iD;

  // A code signifying the type of this transport handling unit.
  final TransportHandlingUnitTypeCode? transportHandlingUnitTypeCode;

  // The handling required for this transport handling unit, expressed as a code.
  final HandlingCode? handlingCode;

  // The handling required for this transport handling unit, expressed as text.
  final List<HandlingInstructions> handlingInstructions;

  // An indicator that the materials contained in this transport handling unit are subject to an international regulation concerning the carriage of dangerous goods (true) or not (false).
  final HazardousRiskIndicator? hazardousRiskIndicator;

  // The total number of goods items in this transport handling unit.
  final TotalGoodsItemQuantity? totalGoodsItemQuantity;

  // The total number of packages in this transport handling unit.
  final TotalPackageQuantity? totalPackageQuantity;

  // Text describing damage associated with this transport handling unit.
  final List<DamageRemarks> damageRemarks;

  // Text describing the marks and numbers on this transport handling unit.
  final List<ShippingMarks> shippingMarks;

  // An identifier for use in tracing this transport handling unit, such as the EPC number used in RFID.
  final TraceID? traceID;

  // A despatch line associated with this transport handling unit.
  final List<HandlingUnitDespatchLine> handlingUnitDespatchLine;

  // A package contained in this transport handling unit.
  final List<ActualPackage> actualPackage;

  // A receipt line associated with this transport handling unit.
  final List<ReceivedHandlingUnitReceiptLine> receivedHandlingUnitReceiptLine;

  // A piece of transport equipment associated with this transport handling unit.
  final List<TransportEquipment> transportEquipment;

  // A means of transport associated with this transport handling unit.
  final List<TransportMeans> transportMeans;

  // Transit-related information regarding a type of hazardous goods contained in this transport handling unit.
  final List<HazardousGoodsTransit> hazardousGoodsTransit;

  // A measurable dimension (length, mass, weight, or volume) of this transport handling unit.
  final List<MeasurementDimension> measurementDimension;

  // The minimum required operating temperature of this transport handling unit.
  final MinimumTemperature? minimumTemperature;

  // The maximum allowable operating temperature of this transport handling unit.
  final MaximumTemperature? maximumTemperature;

  // A goods item contained in this transport handling unit.
  final List<GoodsItem> goodsItem;

  // The floor space measurement dimension associated with this transport handling unit.
  final FloorSpaceMeasurementDimension? floorSpaceMeasurementDimension;

  // The pallet space measurement dimension associated to this transport handling unit.
  final PalletSpaceMeasurementDimension? palletSpaceMeasurementDimension;

  // A reference to a shipping document associated with this transport handling unit.
  final List<ShipmentDocumentReference> shipmentDocumentReference;

  // The status of this transport handling unit.
  final List<Status> status;

  // Describes identifiers or references relating to customs procedures.
  final List<CustomsDeclaration> customsDeclaration;

  // A shipment associated with this transport handling unit.
  final List<ReferencedShipment> referencedShipment;

  // A package contained in this transport handling unit.
  final List<Package> package;

  // An attachment, such as a photo, documenting damage associated with this transport handling unit.
  final List<DamageDocumentationAttachment> damageDocumentationAttachment;

  TransportHandlingUnit ({
    this.uBLExtensions,
    this.iD,
    this.transportHandlingUnitTypeCode,
    this.handlingCode,
    this.handlingInstructions = const [],
    this.hazardousRiskIndicator,
    this.totalGoodsItemQuantity,
    this.totalPackageQuantity,
    this.damageRemarks = const [],
    this.shippingMarks = const [],
    this.traceID,
    this.handlingUnitDespatchLine = const [],
    this.actualPackage = const [],
    this.receivedHandlingUnitReceiptLine = const [],
    this.transportEquipment = const [],
    this.transportMeans = const [],
    this.hazardousGoodsTransit = const [],
    this.measurementDimension = const [],
    this.minimumTemperature,
    this.maximumTemperature,
    this.goodsItem = const [],
    this.floorSpaceMeasurementDimension,
    this.palletSpaceMeasurementDimension,
    this.shipmentDocumentReference = const [],
    this.status = const [],
    this.customsDeclaration = const [],
    this.referencedShipment = const [],
    this.package = const [],
    this.damageDocumentationAttachment = const [],
  });

  static TransportHandlingUnit? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransportHandlingUnit (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      transportHandlingUnitTypeCode: TransportHandlingUnitTypeCode.fromJson(json['transportHandlingUnitTypeCode'] as Map<String, dynamic>?),
      handlingCode: HandlingCode.fromJson(json['handlingCode'] as Map<String, dynamic>?),
      handlingInstructions: (json['handlingInstructions'] as List? ?? []).map((dynamic d) => HandlingInstructions.fromJson(d as Map<String, dynamic>?)!).toList(),
      hazardousRiskIndicator: HazardousRiskIndicator.fromJson(json['hazardousRiskIndicator'] as Map<String, dynamic>?),
      totalGoodsItemQuantity: TotalGoodsItemQuantity.fromJson(json['totalGoodsItemQuantity'] as Map<String, dynamic>?),
      totalPackageQuantity: TotalPackageQuantity.fromJson(json['totalPackageQuantity'] as Map<String, dynamic>?),
      damageRemarks: (json['damageRemarks'] as List? ?? []).map((dynamic d) => DamageRemarks.fromJson(d as Map<String, dynamic>?)!).toList(),
      shippingMarks: (json['shippingMarks'] as List? ?? []).map((dynamic d) => ShippingMarks.fromJson(d as Map<String, dynamic>?)!).toList(),
      traceID: TraceID.fromJson(json['traceID'] as Map<String, dynamic>?),
      handlingUnitDespatchLine: (json['handlingUnitDespatchLine'] as List? ?? []).map((dynamic d) => HandlingUnitDespatchLine.fromJson(d as Map<String, dynamic>?)!).toList(),
      actualPackage: (json['actualPackage'] as List? ?? []).map((dynamic d) => ActualPackage.fromJson(d as Map<String, dynamic>?)!).toList(),
      receivedHandlingUnitReceiptLine: (json['receivedHandlingUnitReceiptLine'] as List? ?? []).map((dynamic d) => ReceivedHandlingUnitReceiptLine.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportEquipment: (json['transportEquipment'] as List? ?? []).map((dynamic d) => TransportEquipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      transportMeans: (json['transportMeans'] as List? ?? []).map((dynamic d) => TransportMeans.fromJson(d as Map<String, dynamic>?)!).toList(),
      hazardousGoodsTransit: (json['hazardousGoodsTransit'] as List? ?? []).map((dynamic d) => HazardousGoodsTransit.fromJson(d as Map<String, dynamic>?)!).toList(),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
      minimumTemperature: MinimumTemperature.fromJson(json['minimumTemperature'] as Map<String, dynamic>?),
      maximumTemperature: MaximumTemperature.fromJson(json['maximumTemperature'] as Map<String, dynamic>?),
      goodsItem: (json['goodsItem'] as List? ?? []).map((dynamic d) => GoodsItem.fromJson(d as Map<String, dynamic>?)!).toList(),
      floorSpaceMeasurementDimension: FloorSpaceMeasurementDimension.fromJson(json['floorSpaceMeasurementDimension'] as Map<String, dynamic>?),
      palletSpaceMeasurementDimension: PalletSpaceMeasurementDimension.fromJson(json['palletSpaceMeasurementDimension'] as Map<String, dynamic>?),
      shipmentDocumentReference: (json['shipmentDocumentReference'] as List? ?? []).map((dynamic d) => ShipmentDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      status: (json['status'] as List? ?? []).map((dynamic d) => Status.fromJson(d as Map<String, dynamic>?)!).toList(),
      customsDeclaration: (json['customsDeclaration'] as List? ?? []).map((dynamic d) => CustomsDeclaration.fromJson(d as Map<String, dynamic>?)!).toList(),
      referencedShipment: (json['referencedShipment'] as List? ?? []).map((dynamic d) => ReferencedShipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      package: (json['package'] as List? ?? []).map((dynamic d) => Package.fromJson(d as Map<String, dynamic>?)!).toList(),
      damageDocumentationAttachment: (json['damageDocumentationAttachment'] as List? ?? []).map((dynamic d) => DamageDocumentationAttachment.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'transportHandlingUnitTypeCode': transportHandlingUnitTypeCode?.toJson(),
      'handlingCode': handlingCode?.toJson(),
      'handlingInstructions': handlingInstructions.map((e) => e.toJson()).toList(),
      'hazardousRiskIndicator': hazardousRiskIndicator?.toJson(),
      'totalGoodsItemQuantity': totalGoodsItemQuantity?.toJson(),
      'totalPackageQuantity': totalPackageQuantity?.toJson(),
      'damageRemarks': damageRemarks.map((e) => e.toJson()).toList(),
      'shippingMarks': shippingMarks.map((e) => e.toJson()).toList(),
      'traceID': traceID?.toJson(),
      'handlingUnitDespatchLine': handlingUnitDespatchLine.map((e) => e.toJson()).toList(),
      'actualPackage': actualPackage.map((e) => e.toJson()).toList(),
      'receivedHandlingUnitReceiptLine': receivedHandlingUnitReceiptLine.map((e) => e.toJson()).toList(),
      'transportEquipment': transportEquipment.map((e) => e.toJson()).toList(),
      'transportMeans': transportMeans.map((e) => e.toJson()).toList(),
      'hazardousGoodsTransit': hazardousGoodsTransit.map((e) => e.toJson()).toList(),
      'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
      'minimumTemperature': minimumTemperature?.toJson(),
      'maximumTemperature': maximumTemperature?.toJson(),
      'goodsItem': goodsItem.map((e) => e.toJson()).toList(),
      'floorSpaceMeasurementDimension': floorSpaceMeasurementDimension?.toJson(),
      'palletSpaceMeasurementDimension': palletSpaceMeasurementDimension?.toJson(),
      'shipmentDocumentReference': shipmentDocumentReference.map((e) => e.toJson()).toList(),
      'status': status.map((e) => e.toJson()).toList(),
      'customsDeclaration': customsDeclaration.map((e) => e.toJson()).toList(),
      'referencedShipment': referencedShipment.map((e) => e.toJson()).toList(),
      'package': package.map((e) => e.toJson()).toList(),
      'damageDocumentationAttachment': damageDocumentationAttachment.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TransportHandlingUnit? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TransportHandlingUnit (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      transportHandlingUnitTypeCode: TransportHandlingUnitTypeCode.fromXml(xml.findElements('cbc:TransportHandlingUnitTypeCode').singleOrNull),
      handlingCode: HandlingCode.fromXml(xml.findElements('cbc:HandlingCode').singleOrNull),
      handlingInstructions: xml.findElements('cbc:HandlingInstructions').map((XmlElement e) => HandlingInstructions.fromXml(e)!).toList(),
      hazardousRiskIndicator: HazardousRiskIndicator.fromXml(xml.findElements('cbc:HazardousRiskIndicator').singleOrNull),
      totalGoodsItemQuantity: TotalGoodsItemQuantity.fromXml(xml.findElements('cbc:TotalGoodsItemQuantity').singleOrNull),
      totalPackageQuantity: TotalPackageQuantity.fromXml(xml.findElements('cbc:TotalPackageQuantity').singleOrNull),
      damageRemarks: xml.findElements('cbc:DamageRemarks').map((XmlElement e) => DamageRemarks.fromXml(e)!).toList(),
      shippingMarks: xml.findElements('cbc:ShippingMarks').map((XmlElement e) => ShippingMarks.fromXml(e)!).toList(),
      traceID: TraceID.fromXml(xml.findElements('cbc:TraceID').singleOrNull),
      handlingUnitDespatchLine: xml.findElements('cac:HandlingUnitDespatchLine').map((XmlElement e) => HandlingUnitDespatchLine.fromXml(e)!).toList(),
      actualPackage: xml.findElements('cac:ActualPackage').map((XmlElement e) => ActualPackage.fromXml(e)!).toList(),
      receivedHandlingUnitReceiptLine: xml.findElements('cac:ReceivedHandlingUnitReceiptLine').map((XmlElement e) => ReceivedHandlingUnitReceiptLine.fromXml(e)!).toList(),
      transportEquipment: xml.findElements('cac:TransportEquipment').map((XmlElement e) => TransportEquipment.fromXml(e)!).toList(),
      transportMeans: xml.findElements('cac:TransportMeans').map((XmlElement e) => TransportMeans.fromXml(e)!).toList(),
      hazardousGoodsTransit: xml.findElements('cac:HazardousGoodsTransit').map((XmlElement e) => HazardousGoodsTransit.fromXml(e)!).toList(),
      measurementDimension: xml.findElements('cac:MeasurementDimension').map((XmlElement e) => MeasurementDimension.fromXml(e)!).toList(),
      minimumTemperature: MinimumTemperature.fromXml(xml.findElements('cac:MinimumTemperature').singleOrNull),
      maximumTemperature: MaximumTemperature.fromXml(xml.findElements('cac:MaximumTemperature').singleOrNull),
      goodsItem: xml.findElements('cac:GoodsItem').map((XmlElement e) => GoodsItem.fromXml(e)!).toList(),
      floorSpaceMeasurementDimension: FloorSpaceMeasurementDimension.fromXml(xml.findElements('cac:FloorSpaceMeasurementDimension').singleOrNull),
      palletSpaceMeasurementDimension: PalletSpaceMeasurementDimension.fromXml(xml.findElements('cac:PalletSpaceMeasurementDimension').singleOrNull),
      shipmentDocumentReference: xml.findElements('cac:ShipmentDocumentReference').map((XmlElement e) => ShipmentDocumentReference.fromXml(e)!).toList(),
      status: xml.findElements('cac:Status').map((XmlElement e) => Status.fromXml(e)!).toList(),
      customsDeclaration: xml.findElements('cac:CustomsDeclaration').map((XmlElement e) => CustomsDeclaration.fromXml(e)!).toList(),
      referencedShipment: xml.findElements('cac:ReferencedShipment').map((XmlElement e) => ReferencedShipment.fromXml(e)!).toList(),
      package: xml.findElements('cac:Package').map((XmlElement e) => Package.fromXml(e)!).toList(),
      damageDocumentationAttachment: xml.findElements('cac:DamageDocumentationAttachment').map((XmlElement e) => DamageDocumentationAttachment.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      transportHandlingUnitTypeCode?.toXml(),
      handlingCode?.toXml(),
      ...handlingInstructions.map((HandlingInstructions e) => e.toXml()),
      hazardousRiskIndicator?.toXml(),
      totalGoodsItemQuantity?.toXml(),
      totalPackageQuantity?.toXml(),
      ...damageRemarks.map((DamageRemarks e) => e.toXml()),
      ...shippingMarks.map((ShippingMarks e) => e.toXml()),
      traceID?.toXml(),
      ...handlingUnitDespatchLine.map((HandlingUnitDespatchLine e) => e.toXml()),
      ...actualPackage.map((ActualPackage e) => e.toXml()),
      ...receivedHandlingUnitReceiptLine.map((ReceivedHandlingUnitReceiptLine e) => e.toXml()),
      ...transportEquipment.map((TransportEquipment e) => e.toXml()),
      ...transportMeans.map((TransportMeans e) => e.toXml()),
      ...hazardousGoodsTransit.map((HazardousGoodsTransit e) => e.toXml()),
      ...measurementDimension.map((MeasurementDimension e) => e.toXml()),
      minimumTemperature?.toXml(),
      maximumTemperature?.toXml(),
      ...goodsItem.map((GoodsItem e) => e.toXml()),
      floorSpaceMeasurementDimension?.toXml(),
      palletSpaceMeasurementDimension?.toXml(),
      ...shipmentDocumentReference.map((ShipmentDocumentReference e) => e.toXml()),
      ...status.map((Status e) => e.toXml()),
      ...customsDeclaration.map((CustomsDeclaration e) => e.toXml()),
      ...referencedShipment.map((ReferencedShipment e) => e.toXml()),
      ...package.map((Package e) => e.toXml()),
      ...damageDocumentationAttachment.map((DamageDocumentationAttachment e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TransportHandlingUnit',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

