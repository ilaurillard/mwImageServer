import '../cac/ID.dart';
import '../cac/UUID.dart';
import '../cac/IssueDate.dart';
import '../cac/WorkPhaseReference.dart';

// A class to define a reference to a procurement project.
class ProjectReference {


  // An identifier for the referenced project.
  final ID iD;

  // A universally unique identifier for the referenced project.
  final UUID? uUID;

  // The date on which the referenced project was issued.
  final IssueDate? issueDate;

  // A specific phase of work in the referenced project.
  final List<WorkPhaseReference> workPhaseReference;

  ProjectReference ({
    required this.iD,
    this.uUID,
    this.issueDate,
    this.workPhaseReference = const [],
  });
}

