import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/WorkPhaseCode.dart';
import '../cbc/WorkPhase.dart';
import '../cbc/ProgressPercent.dart';
import '../cbc/StartDate.dart';
import '../cbc/EndDate.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'workPhaseCode': workPhaseCode?.toJson(),
     'workPhase': workPhase.map((e) => e.toJson()).toList(),
     'progressPercent': progressPercent?.toJson(),
     'startDate': startDate?.toJson(),
     'endDate': endDate?.toJson(),
     'workOrderDocumentReference': workOrderDocumentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

