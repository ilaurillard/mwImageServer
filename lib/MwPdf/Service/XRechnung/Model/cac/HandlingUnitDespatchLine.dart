import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ID.dart';
import '../cac/OrderLineReference.dart';
import '../cac/Item.dart';
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
class HandlingUnitDespatchLine {


  // An identifier for this despatch line.
  final ID iD;

  // A reference to an order line associated with this despatch line.
  final List<OrderLineReference> orderLineReference;

  // The item associated with this despatch line.
  final Item item;

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

  HandlingUnitDespatchLine ({
    required this.iD,
    required this.orderLineReference,
    required this.item,
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
  }) {
    assert(orderLineReference.isNotEmpty);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  HandlingUnitDespatchLine fromJson(Map<String, dynamic> json) {
    return HandlingUnitDespatchLine (
    );
  }

}

