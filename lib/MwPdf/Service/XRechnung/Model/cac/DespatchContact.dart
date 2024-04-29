import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/Telephone.dart';
import '../cac/Telefax.dart';
import '../cac/ElectronicMail.dart';
import '../cac/Note.dart';
import '../cac/OtherCommunication.dart';

// A class to describe a contactable person or department in an organization.
class DespatchContact {


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

  DespatchContact ({
    this.iD,
    this.name,
    this.telephone,
    this.telefax,
    this.electronicMail,
    this.note = const [],
    this.otherCommunication = const [],
  });
}

