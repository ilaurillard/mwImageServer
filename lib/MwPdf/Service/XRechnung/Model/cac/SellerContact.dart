import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/Telephone.dart';
import '../cbc/Telefax.dart';
import '../cbc/ElectronicMail.dart';
import '../cbc/Note.dart';
import '../cac/OtherCommunication.dart';

// A class to describe a contactable person or department in an organization.
class SellerContact {


  // An identifier for this contact.
  final ID? iD;

  // The name of this contact. It is recommended that this be used for a functional name and not a personal name.
  final Name? name;

  // The primary telephone number of this contact.
  final Telephone? telephone;

  // The primary fax number of this contact.
  final Telefax? telefax;

  // The primary email address of this contact.
  final ElectronicMail? electronicMail;

  // Free-form text conveying information that is not contained explicitly in other structures; in particular, a textual description of the circumstances under which this contact can be used (e.g., "emergency" or "after hours").
  final List<Note> note;

  // Another means of communication with this contact.
  final List<OtherCommunication> otherCommunication;

  SellerContact ({
    this.iD,
    this.name,
    this.telephone,
    this.telefax,
    this.electronicMail,
    this.note = const [],
    this.otherCommunication = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'name': name?.toJson(),
     'telephone': telephone?.toJson(),
     'telefax': telefax?.toJson(),
     'electronicMail': electronicMail?.toJson(),
     'note': note.map((e) => e.toJson()).toList(),
     'otherCommunication': otherCommunication.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

