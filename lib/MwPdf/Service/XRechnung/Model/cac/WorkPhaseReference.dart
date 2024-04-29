import '../cac/ID.dart';
import '../cac/WorkPhaseCode.dart';
import '../cac/WorkPhase.dart';
import '../cac/ProgressPercent.dart';
import '../cac/StartDate.dart';
import '../cac/EndDate.dart';
import '../cac/WorkOrderDocumentReference.dart';

// A class that refers to a phase of work. Used for instance to specify what part of the contract the billing is referring to.
class WorkPhaseReference {


  // An identifier for this phase of work.
  final ID? iD;

  // A code signifying this phase of work.
  final WorkPhaseCode? workPhaseCode;

  // Text describing this phase of work.
  final List<WorkPhase> workPhase;

  // The progress percentage of the work phase.
  final ProgressPercent? progressPercent;

  // The date on which this phase of work begins.
  final StartDate? startDate;

  // The date on which this phase of work ends.
  final EndDate? endDate;

  // A reference to a document regarding the work order for the project in which this phase of work takes place.
  final List<WorkOrderDocumentReference> workOrderDocumentReference;

  WorkPhaseReference ({
    this.iD,
    this.workPhaseCode,
    this.workPhase = const [],
    this.progressPercent,
    this.startDate,
    this.endDate,
    this.workOrderDocumentReference = const [],
  });
}

