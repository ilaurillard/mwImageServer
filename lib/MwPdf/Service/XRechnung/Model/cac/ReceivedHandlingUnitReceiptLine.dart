import '../cac/ID.dart';
import '../cac/UUID.dart';
import '../cac/Note.dart';
import '../cac/ReceivedQuantity.dart';
import '../cac/ShortQuantity.dart';
import '../cac/ShortageActionCode.dart';
import '../cac/RejectedQuantity.dart';
import '../cac/RejectReasonCode.dart';
import '../cac/RejectReason.dart';
import '../cac/RejectActionCode.dart';
import '../cac/QuantityDiscrepancyCode.dart';
import '../cac/OversupplyQuantity.dart';
import '../cac/ReceivedDate.dart';
import '../cac/TimingComplaintCode.dart';
import '../cac/TimingComplaint.dart';
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
}

