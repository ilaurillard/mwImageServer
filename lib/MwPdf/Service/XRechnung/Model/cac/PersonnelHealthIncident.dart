// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/NatureOfIllnessDescription.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/JoinedShipDate.dart';
import '../cbc/OnsetDate.dart';
import '../cbc/ReportedToMedicalOfficerIndicator.dart';
import '../cbc/GivenTreatmentDescription.dart';
import '../cbc/StillIllIndicator.dart';
import '../cbc/DiedIndicator.dart';
import '../cbc/StillOnBoardIndicator.dart';
import '../cbc/EvacuatedIndicator.dart';
import '../cbc/BuriedAtSeaIndicator.dart';
import '../cbc/Note.dart';
import '../cac/Person.dart';

// A class to describe a health incident involving crew or other personnel.
class PersonnelHealthIncident {


  // An identifier for this personal health incident.
  final ID iD;

  // A text decribing the nature of the illness.
  final List<NatureOfIllnessDescription> natureOfIllnessDescription;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The date when the person joined the ship.
  final JoinedShipDate? joinedShipDate;

  // The first date of the health incident.
  final OnsetDate? onsetDate;

  // An indicator of whether this personal health incident has been reported to a medical officer (true) or not (false).
  final ReportedToMedicalOfficerIndicator? reportedToMedicalOfficerIndicator;

  // A text describing the given treatment.
  final List<GivenTreatmentDescription> givenTreatmentDescription;

  // Indicates whether the person is still ill (true) or not (false).
  final StillIllIndicator? stillIllIndicator;

  // Indicates whether the person died from this health incident (true) or not (false).
  final DiedIndicator? diedIndicator;

  // Indicates whether the person is still on board (true) or not (false).
  final StillOnBoardIndicator? stillOnBoardIndicator;

  // Indicates whether the person has been evacuated (true) or not (false).
  final EvacuatedIndicator? evacuatedIndicator;

  // Indicates whether the person has been buired at sea (true) or not (false).
  final BuriedAtSeaIndicator? buriedAtSeaIndicator;

  // Any additional information that is not included elsewhere, expressed as text.
  final List<Note> note;

  // The person associated to this health incident.
  final Person? person;

  PersonnelHealthIncident ({
    required this.iD,
    required this.natureOfIllnessDescription,
    this.uBLExtensions,
    this.joinedShipDate,
    this.onsetDate,
    this.reportedToMedicalOfficerIndicator,
    this.givenTreatmentDescription = const [],
    this.stillIllIndicator,
    this.diedIndicator,
    this.stillOnBoardIndicator,
    this.evacuatedIndicator,
    this.buriedAtSeaIndicator,
    this.note = const [],
    this.person,
  }) {
    assert(natureOfIllnessDescription.isNotEmpty);
  }

  static PersonnelHealthIncident? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PersonnelHealthIncident (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      joinedShipDate: JoinedShipDate.fromJson(json['joinedShipDate'] as Map<String, dynamic>?),
      natureOfIllnessDescription: (json['natureOfIllnessDescription'] as List? ?? []).map((dynamic d) => NatureOfIllnessDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      onsetDate: OnsetDate.fromJson(json['onsetDate'] as Map<String, dynamic>?),
      reportedToMedicalOfficerIndicator: ReportedToMedicalOfficerIndicator.fromJson(json['reportedToMedicalOfficerIndicator'] as Map<String, dynamic>?),
      givenTreatmentDescription: (json['givenTreatmentDescription'] as List? ?? []).map((dynamic d) => GivenTreatmentDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      stillIllIndicator: StillIllIndicator.fromJson(json['stillIllIndicator'] as Map<String, dynamic>?),
      diedIndicator: DiedIndicator.fromJson(json['diedIndicator'] as Map<String, dynamic>?),
      stillOnBoardIndicator: StillOnBoardIndicator.fromJson(json['stillOnBoardIndicator'] as Map<String, dynamic>?),
      evacuatedIndicator: EvacuatedIndicator.fromJson(json['evacuatedIndicator'] as Map<String, dynamic>?),
      buriedAtSeaIndicator: BuriedAtSeaIndicator.fromJson(json['buriedAtSeaIndicator'] as Map<String, dynamic>?),
      note: (json['note'] as List? ?? []).map((dynamic d) => Note.fromJson(d as Map<String, dynamic>?)!).toList(),
      person: Person.fromJson(json['person'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'joinedShipDate': joinedShipDate?.toJson(),
      'natureOfIllnessDescription': natureOfIllnessDescription.map((e) => e.toJson()).toList(),
      'onsetDate': onsetDate?.toJson(),
      'reportedToMedicalOfficerIndicator': reportedToMedicalOfficerIndicator?.toJson(),
      'givenTreatmentDescription': givenTreatmentDescription.map((e) => e.toJson()).toList(),
      'stillIllIndicator': stillIllIndicator?.toJson(),
      'diedIndicator': diedIndicator?.toJson(),
      'stillOnBoardIndicator': stillOnBoardIndicator?.toJson(),
      'evacuatedIndicator': evacuatedIndicator?.toJson(),
      'buriedAtSeaIndicator': buriedAtSeaIndicator?.toJson(),
      'note': note.map((e) => e.toJson()).toList(),
      'person': person?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PersonnelHealthIncident? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PersonnelHealthIncident (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      joinedShipDate: JoinedShipDate.fromXml(xml.findElements('cbc:JoinedShipDate').singleOrNull),
      natureOfIllnessDescription: xml.findElements('cbc:NatureOfIllnessDescription').map((XmlElement e) => NatureOfIllnessDescription.fromXml(e)!).toList(),
      onsetDate: OnsetDate.fromXml(xml.findElements('cbc:OnsetDate').singleOrNull),
      reportedToMedicalOfficerIndicator: ReportedToMedicalOfficerIndicator.fromXml(xml.findElements('cbc:ReportedToMedicalOfficerIndicator').singleOrNull),
      givenTreatmentDescription: xml.findElements('cbc:GivenTreatmentDescription').map((XmlElement e) => GivenTreatmentDescription.fromXml(e)!).toList(),
      stillIllIndicator: StillIllIndicator.fromXml(xml.findElements('cbc:StillIllIndicator').singleOrNull),
      diedIndicator: DiedIndicator.fromXml(xml.findElements('cbc:DiedIndicator').singleOrNull),
      stillOnBoardIndicator: StillOnBoardIndicator.fromXml(xml.findElements('cbc:StillOnBoardIndicator').singleOrNull),
      evacuatedIndicator: EvacuatedIndicator.fromXml(xml.findElements('cbc:EvacuatedIndicator').singleOrNull),
      buriedAtSeaIndicator: BuriedAtSeaIndicator.fromXml(xml.findElements('cbc:BuriedAtSeaIndicator').singleOrNull),
      note: xml.findElements('cbc:Note').map((XmlElement e) => Note.fromXml(e)!).toList(),
      person: Person.fromXml(xml.findElements('cac:Person').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD.toXml(),
      joinedShipDate?.toXml(),
      ...natureOfIllnessDescription.map((NatureOfIllnessDescription e) => e.toXml()),
      onsetDate?.toXml(),
      reportedToMedicalOfficerIndicator?.toXml(),
      ...givenTreatmentDescription.map((GivenTreatmentDescription e) => e.toXml()),
      stillIllIndicator?.toXml(),
      diedIndicator?.toXml(),
      stillOnBoardIndicator?.toXml(),
      evacuatedIndicator?.toXml(),
      buriedAtSeaIndicator?.toXml(),
      ...note.map((Note e) => e.toXml()),
      person?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'PersonnelHealthIncident',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

