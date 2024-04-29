import '../cac/LineID.dart';
import '../cac/UUID.dart';
import '../cac/LineStatusCode.dart';
import '../cac/DocumentReference.dart';

// A class to define a reference to a line in a document.
class ReceiptLineReference {


  // Identifies the referenced line in the document.
  final LineID lineID;

  // A universally unique identifier for this line reference.
  final UUID? uUID;

  // A code signifying the status of the referenced line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // A reference to the document containing the referenced line.
  final DocumentReference? documentReference;

  ReceiptLineReference ({
    required this.lineID,
    this.uUID,
    this.lineStatusCode,
    this.documentReference,
  });
}

