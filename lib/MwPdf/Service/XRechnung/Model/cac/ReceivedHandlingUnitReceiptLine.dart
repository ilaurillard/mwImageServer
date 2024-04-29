import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/UUID.dart';
import '../cbc/Note.dart';
import '../cbc/ReceivedQuantity.dart';
import '../cbc/ShortQuantity.dart';
import '../cbc/ShortageActionCode.dart';
import '../cbc/RejectedQuantity.dart';
import '../cbc/RejectReasonCode.dart';
import '../cbc/RejectReason.dart';
import '../cbc/RejectActionCode.dart';
import '../cbc/QuantityDiscrepancyCode.dart';
import '../cbc/OversupplyQuantity.dart';
import '../cbc/ReceivedDate.dart';
import '../cbc/TimingComplaintCode.dart';
import '../cbc/TimingComplaint.dart';
import '../cac/OrderLineReference.dart';
import '../cac/DespatchLineReference.dart';
import '../cac/DocumentReference.dart';
import '../cac/Item.dart';
import '../cac/Shipment.dart';

// A class to define a line in a Receipt Advice.
class ReceivedHandlingUnitReceiptLine {


  // An identifier for this receipt line.
  final ID iD;

  // A universally unique identifier for this receipt line.
  final UUID? uUID;

  // Free-form text conveying information that is not contained explicitly in other structures.
  final List<Note> note;

  // The quantity received.
  final ReceivedQuantity? receivedQuantity;

  // The quantity received short; the difference between the quantity reported despatched and the quantity actually received.
  final ShortQuantity? shortQuantity;

  // A code signifying the action that the delivery party wishes the despatch party to take as the result of a shortage.
  final ShortageActionCode? shortageActionCode;

  // The quantity rejected.
  final RejectedQuantity? rejectedQuantity;

  // The reason for a rejection, expressed as a code.
  final RejectReasonCode? rejectReasonCode;

  // The reason for a rejection, expressed as text.
  final List<RejectReason> rejectReason;

  // A code signifying the action that the delivery party wishes the despatch party to take as the result of a rejection.
  final RejectActionCode? rejectActionCode;

  // A code signifying the type of a discrepancy in quantity.
  final QuantityDiscrepancyCode? quantityDiscrepancyCode;

  // The quantity over-supplied, i.e., the quantity over and above the quantity ordered.
  final OversupplyQuantity? oversupplyQuantity;

  // The date on which the goods or services were received.
  final ReceivedDate? receivedDate;

  // A complaint about the timing of delivery, expressed as a code.
  final TimingComplaintCode? timingComplaintCode;

  // A complaint about the timing of delivery, expressed as text.
  final TimingComplaint? timingComplaint;

  // A reference to the order line associated with this receipt line.
  final OrderLineReference? orderLineReference;

  // A reference to a despatch line associated with this receipt line.
  final List<DespatchLineReference> despatchLineReference;

  // A reference to a document associated with this receipt line.
  final List<DocumentReference> documentReference;

  // An item associated with this receipt line.
  final List<Item> item;

  // A shipment associated with this receipt line.
  final List<Shipment> shipment;

  ReceivedHandlingUnitReceiptLine ({
    required this.iD,
    this.uUID,
    this.note = const [],
    this.receivedQuantity,
    this.shortQuantity,
    this.shortageActionCode,
    this.rejectedQuantity,
    this.rejectReasonCode,
    this.rejectReason = const [],
    this.rejectActionCode,
    this.quantityDiscrepancyCode,
    this.oversupplyQuantity,
    this.receivedDate,
    this.timingComplaintCode,
    this.timingComplaint,
    this.orderLineReference,
    this.despatchLineReference = const [],
    this.documentReference = const [],
    this.item = const [],
    this.shipment = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD.toJson(),
      'uUID': uUID?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'receivedQuantity': receivedQuantity?.toJson(),
      'shortQuantity': shortQuantity?.toJson(),
      'shortageActionCode': shortageActionCode?.toJson(),
      'rejectedQuantity': rejectedQuantity?.toJson(),
      'rejectReasonCode': rejectReasonCode?.toJson(),
      'rejectReason': rejectReason.map((e) => e.toJson()).toList(),
      'rejectActionCode': rejectActionCode?.toJson(),
      'quantityDiscrepancyCode': quantityDiscrepancyCode?.toJson(),
      'oversupplyQuantity': oversupplyQuantity?.toJson(),
      'receivedDate': receivedDate?.toJson(),
      'timingComplaintCode': timingComplaintCode?.toJson(),
      'timingComplaint': timingComplaint?.toJson(),
      'orderLineReference': orderLineReference?.toJson(),
      'despatchLineReference': despatchLineReference.map((e) => e.toJson()).toList(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
      'item': item.map((e) => e.toJson()).toList(),
      'shipment': shipment.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ReceivedHandlingUnitReceiptLine? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ReceivedHandlingUnitReceiptLine (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      uUID: UUID.fromJson(json['uUID'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      receivedQuantity: ReceivedQuantity.fromJson(json['receivedQuantity'] as Map<String, dynamic>?),
      shortQuantity: ShortQuantity.fromJson(json['shortQuantity'] as Map<String, dynamic>?),
      shortageActionCode: ShortageActionCode.fromJson(json['shortageActionCode'] as Map<String, dynamic>?),
      rejectedQuantity: RejectedQuantity.fromJson(json['rejectedQuantity'] as Map<String, dynamic>?),
      rejectReasonCode: RejectReasonCode.fromJson(json['rejectReasonCode'] as Map<String, dynamic>?),
      rejectReason: (json['rejectReason'] as List? ?? []).map((dynamic d) => RejectReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      rejectActionCode: RejectActionCode.fromJson(json['rejectActionCode'] as Map<String, dynamic>?),
      quantityDiscrepancyCode: QuantityDiscrepancyCode.fromJson(json['quantityDiscrepancyCode'] as Map<String, dynamic>?),
      oversupplyQuantity: OversupplyQuantity.fromJson(json['oversupplyQuantity'] as Map<String, dynamic>?),
      receivedDate: ReceivedDate.fromJson(json['receivedDate'] as Map<String, dynamic>?),
      timingComplaintCode: TimingComplaintCode.fromJson(json['timingComplaintCode'] as Map<String, dynamic>?),
      timingComplaint: TimingComplaint.fromJson(json['timingComplaint'] as Map<String, dynamic>?),
      orderLineReference: OrderLineReference.fromJson(json['orderLineReference'] as Map<String, dynamic>?),
      despatchLineReference: (json['despatchLineReference'] as List? ?? []).map((dynamic d) => DespatchLineReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      item: (json['item'] as List? ?? []).map((dynamic d) => Item.fromJson(d as Map<String, dynamic>?)!).toList(),
      shipment: (json['shipment'] as List? ?? []).map((dynamic d) => Shipment.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static ReceivedHandlingUnitReceiptLine? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ReceivedHandlingUnitReceiptLine (
      iD: null,
      uUID: null,
      note: null,
      receivedQuantity: null,
      shortQuantity: null,
      shortageActionCode: null,
      rejectedQuantity: null,
      rejectReasonCode: null,
      rejectReason: null,
      rejectActionCode: null,
      quantityDiscrepancyCode: null,
      oversupplyQuantity: null,
      receivedDate: null,
      timingComplaintCode: null,
      timingComplaint: null,
      orderLineReference: null,
      despatchLineReference: null,
      documentReference: null,
      item: null,
      shipment: null,
    );
  }

}

