import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cac/OrderLineReference.dart';
import '../cac/Item.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/UUID.dart';
import '../cbc/Note.dart';
import '../cbc/LineStatusCode.dart';
import '../cbc/DeliveredQuantity.dart';
import '../cbc/BackorderQuantity.dart';
import '../cbc/BackorderReason.dart';
import '../cbc/OutstandingQuantity.dart';
import '../cbc/OutstandingReason.dart';
import '../cbc/OversupplyQuantity.dart';
import '../cac/DocumentReference.dart';
import '../cac/Shipment.dart';

// A class to define a line in a Despatch Advice.
class SubDespatchLine {


  // An identifier for this despatch line.
  final ID iD;

  // A reference to an order line associated with this despatch line.
  final List<OrderLineReference> orderLineReference;

  // The item associated with this despatch line.
  final Item item;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A universally unique identifier for this despatch line.
  final UUID? uUID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // A code signifying the status of this despatch line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // The quantity despatched (picked up).
  final DeliveredQuantity? deliveredQuantity;

  // The quantity on back order at the supplier.
  final BackorderQuantity? backorderQuantity;

  // The reason for the back order.
  final List<BackorderReason> backorderReason;

  // The quantity outstanding (which will follow in a later despatch).
  final OutstandingQuantity? outstandingQuantity;

  // The reason for the outstanding quantity.
  final List<OutstandingReason> outstandingReason;

  // The quantity over-supplied, i.e., the quantity over and above that ordered.
  final OversupplyQuantity? oversupplyQuantity;

  // A reference to a document associated with this despatch line.
  final List<DocumentReference> documentReference;

  // A shipment associated with this despatch line.
  final List<Shipment> shipment;

  // A despatch line subsidiary to this despatch line.
  final List<SubDespatchLine> subDespatchLine;

  SubDespatchLine ({
    required this.iD,
    required this.orderLineReference,
    required this.item,
    this.uBLExtensions,
    this.uUID,
    this.note = const [],
    this.lineStatusCode,
    this.deliveredQuantity,
    this.backorderQuantity,
    this.backorderReason = const [],
    this.outstandingQuantity,
    this.outstandingReason = const [],
    this.oversupplyQuantity,
    this.documentReference = const [],
    this.shipment = const [],
    this.subDespatchLine = const [],
  }) {
    assert(orderLineReference.isNotEmpty);
  }

  static SubDespatchLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SubDespatchLine (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      lineStatusCode: LineStatusCode.fromJson(json['lineStatusCode'] as Map<String, dynamic>?),
      deliveredQuantity: DeliveredQuantity.fromJson(json['deliveredQuantity'] as Map<String, dynamic>?),
      backorderQuantity: BackorderQuantity.fromJson(json['backorderQuantity'] as Map<String, dynamic>?),
      backorderReason: (json['backorderReason'] as List? ?? []).map((dynamic d) => BackorderReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      outstandingQuantity: OutstandingQuantity.fromJson(json['outstandingQuantity'] as Map<String, dynamic>?),
      outstandingReason: (json['outstandingReason'] as List? ?? []).map((dynamic d) => OutstandingReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      oversupplyQuantity: OversupplyQuantity.fromJson(json['oversupplyQuantity'] as Map<String, dynamic>?),
      orderLineReference: (json['orderLineReference'] as List? ?? []).map((dynamic d) => OrderLineReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      item: Item.fromJson(json['item'] as Map<String, dynamic>?)!,
      shipment: (json['shipment'] as List? ?? []).map((dynamic d) => Shipment.fromJson(d as Map<String, dynamic>?)!).toList(),
      subDespatchLine: (json['subDespatchLine'] as List? ?? []).map((dynamic d) => SubDespatchLine.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'uUID': uUID?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'lineStatusCode': lineStatusCode?.toJson(),
      'deliveredQuantity': deliveredQuantity?.toJson(),
      'backorderQuantity': backorderQuantity?.toJson(),
      'backorderReason': backorderReason.map((e) => e.toJson()).toList(),
      'outstandingQuantity': outstandingQuantity?.toJson(),
      'outstandingReason': outstandingReason.map((e) => e.toJson()).toList(),
      'oversupplyQuantity': oversupplyQuantity?.toJson(),
      'orderLineReference': orderLineReference.map((e) => e.toJson()).toList(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
      'item': item.toJson(),
      'shipment': shipment.map((e) => e.toJson()).toList(),
      'subDespatchLine': subDespatchLine.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SubDespatchLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SubDespatchLine (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      uUID: UUID.fromXml(xml.findElements('cbc:UUID').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      lineStatusCode: LineStatusCode.fromXml(xml.findElements('cbc:LineStatusCode').singleOrNull),
      deliveredQuantity: DeliveredQuantity.fromXml(xml.findElements('cbc:DeliveredQuantity').singleOrNull),
      backorderQuantity: BackorderQuantity.fromXml(xml.findElements('cbc:BackorderQuantity').singleOrNull),
      backorderReason: xml.findElements('cbc:BackorderReason').map((XmlElement e) => BackorderReason.fromXml(e)!).toList(),
      outstandingQuantity: OutstandingQuantity.fromXml(xml.findElements('cbc:OutstandingQuantity').singleOrNull),
      outstandingReason: xml.findElements('cbc:OutstandingReason').map((XmlElement e) => OutstandingReason.fromXml(e)!).toList(),
      oversupplyQuantity: OversupplyQuantity.fromXml(xml.findElements('cbc:OversupplyQuantity').singleOrNull),
      orderLineReference: xml.findElements('cac:OrderLineReference').map((XmlElement e) => OrderLineReference.fromXml(e)!).toList(),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
      item: Item.fromXml(xml.findElements('cac:Item').singleOrNull)!,
      shipment: xml.findElements('cac:Shipment').map((XmlElement e) => Shipment.fromXml(e)!).toList(),
      subDespatchLine: xml.findElements('cac:SubDespatchLine').map((XmlElement e) => SubDespatchLine.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      uUID?.toXml(),
      ...note.map((Note e) => e.toXml()).toList(),
      lineStatusCode?.toXml(),
      deliveredQuantity?.toXml(),
      backorderQuantity?.toXml(),
      ...backorderReason.map((BackorderReason e) => e.toXml()).toList(),
      outstandingQuantity?.toXml(),
      ...outstandingReason.map((OutstandingReason e) => e.toXml()).toList(),
      oversupplyQuantity?.toXml(),
      ...orderLineReference.map((OrderLineReference e) => e.toXml()).toList(),
      ...documentReference.map((DocumentReference e) => e.toXml()).toList(),
      item.toXml(),
      ...shipment.map((Shipment e) => e.toXml()).toList(),
      ...subDespatchLine.map((SubDespatchLine e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SubDespatchLine',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

