import 'dart:convert';
import '../cbc/LineID.dart';
import '../cbc/UUID.dart';
import '../cbc/LineStatusCode.dart';
import '../cac/DocumentReference.dart';

// A class to define a reference to a line in a document.
class DespatchLineReference {


  // Identifies the referenced line in the document.
  final LineID lineID;

  // A universally unique identifier for this line reference.
  final UUID? uUID;

  // A code signifying the status of the referenced line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // A reference to the document containing the referenced line.
  final DocumentReference? documentReference;

  DespatchLineReference ({
    required this.lineID,
    this.uUID,
    this.lineStatusCode,
    this.documentReference,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'lineID': lineID.toJson(),
     'uUID': uUID?.toJson(),
     'lineStatusCode': lineStatusCode?.toJson(),
     'documentReference': documentReference?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

