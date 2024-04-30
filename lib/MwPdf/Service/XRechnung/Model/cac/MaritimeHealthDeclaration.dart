import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/InfectiousDiseaseCaseOnBoardIndicator.dart';
import '../cbc/MoreIllThanExpectedIndicator.dart';
import '../cbc/MedicalPractitionerConsultedIndicator.dart';
import '../cbc/StowawaysFoundOnBoardIndicator.dart';
import '../cbc/SickAnimalOnBoardIndicator.dart';
import '../cbc/FumigatedCargoTransportIndicator.dart';
import '../cbc/SanitaryMeasuresAppliedIndicator.dart';
import '../cbc/ValidSanitationCertificateOnBoardIndicator.dart';
import '../cbc/ReinspectionRequiredIndicator.dart';
import '../cbc/TotalDeadPersonQuantity.dart';
import '../cbc/TotalIllPersonQuantity.dart';
import '../cbc/SickAnimalDescription.dart';
import '../cbc/StowawayDescription.dart';
import '../cbc/LastDrinkingWaterAnalysisDate.dart';
import '../cac/WHOAffectedAreaVisit.dart';
import '../cac/PersonnelHealthIncident.dart';
import '../cac/SanitaryMeasure.dart';
import '../cac/PlaceOfReportLocation.dart';
import '../cac/MedicalCertificate.dart';
import '../cac/ShipSanitationControlCertificate.dart';
import '../cac/ShipSanitationControlExemptionDocumentReference.dart';

// A class to desccribe a maritime health declaration.
class MaritimeHealthDeclaration {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this maritime health declaration.
  final ID? iD;

  // Indicates whether there is an infectious diasase case on board (true) or not (false).
  final InfectiousDiseaseCaseOnBoardIndicator? infectiousDiseaseCaseOnBoardIndicator;

  // Indicates whether a sick person is more ill than extected (true) or not (false).
  final MoreIllThanExpectedIndicator? moreIllThanExpectedIndicator;

  // Indicates whether a medical practioner has been consulted (true) or not (false).
  final MedicalPractitionerConsultedIndicator? medicalPractitionerConsultedIndicator;

  // Indicates whether stowaways have been found on board (true) or not (false).
  final StowawaysFoundOnBoardIndicator? stowawaysFoundOnBoardIndicator;

  // Indicates whether a sick animal is on board (true) or not (false).
  final SickAnimalOnBoardIndicator? sickAnimalOnBoardIndicator;

  // Indicates whether the cargo under transport has been fumigated (true) or not (false).
  final FumigatedCargoTransportIndicator? fumigatedCargoTransportIndicator;

  // Indicates whether sanity measures are applied (true) or not (false).
  final SanitaryMeasuresAppliedIndicator? sanitaryMeasuresAppliedIndicator;

  // Indicates whether a valid sanitary certificate is on board (true) or not (false).
  final ValidSanitationCertificateOnBoardIndicator? validSanitationCertificateOnBoardIndicator;

  // Indicates whether a reinspaction is required (true) or not (false).
  final ReinspectionRequiredIndicator? reinspectionRequiredIndicator;

  // Specifies the total number of dead persons on board the vessel.
  final TotalDeadPersonQuantity? totalDeadPersonQuantity;

  // Specifies the total number of ill persons on board the vessel.
  final TotalIllPersonQuantity? totalIllPersonQuantity;

  // Describes any sick animals on board the vessel.
  final List<SickAnimalDescription> sickAnimalDescription;

  // Describes any stowaways on board the vessel.
  final List<StowawayDescription> stowawayDescription;

  // The date when the last drinking water analysis was made.
  final LastDrinkingWaterAnalysisDate? lastDrinkingWaterAnalysisDate;

  // A WHO Affected Area visit related to this maritime health declaration.
  final List<WHOAffectedAreaVisit> wHOAffectedAreaVisit;

  // A personal health incident related to this maritime health declaration.
  final List<PersonnelHealthIncident> personnelHealthIncident;

  // A sanitary meassure for this health declaration.
  final List<SanitaryMeasure> sanitaryMeasure;

  // The location where this maritime health declaration is reported.
  final PlaceOfReportLocation? placeOfReportLocation;

  // The medical certificate for this maritime health declaration.
  final MedicalCertificate? medicalCertificate;

  // A certificate describing the sanitation control of this maritime health certificate.
  final ShipSanitationControlCertificate? shipSanitationControlCertificate;

  // A reference to a document evidencing the exemption of a ship sanitation control certificate, when absent.
  final List<ShipSanitationControlExemptionDocumentReference> shipSanitationControlExemptionDocumentReference;

  MaritimeHealthDeclaration ({
    this.uBLExtensions,
    this.iD,
    this.infectiousDiseaseCaseOnBoardIndicator,
    this.moreIllThanExpectedIndicator,
    this.medicalPractitionerConsultedIndicator,
    this.stowawaysFoundOnBoardIndicator,
    this.sickAnimalOnBoardIndicator,
    this.fumigatedCargoTransportIndicator,
    this.sanitaryMeasuresAppliedIndicator,
    this.validSanitationCertificateOnBoardIndicator,
    this.reinspectionRequiredIndicator,
    this.totalDeadPersonQuantity,
    this.totalIllPersonQuantity,
    this.sickAnimalDescription = const [],
    this.stowawayDescription = const [],
    this.lastDrinkingWaterAnalysisDate,
    this.wHOAffectedAreaVisit = const [],
    this.personnelHealthIncident = const [],
    this.sanitaryMeasure = const [],
    this.placeOfReportLocation,
    this.medicalCertificate,
    this.shipSanitationControlCertificate,
    this.shipSanitationControlExemptionDocumentReference = const [],
  });

  static MaritimeHealthDeclaration? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MaritimeHealthDeclaration (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      infectiousDiseaseCaseOnBoardIndicator: InfectiousDiseaseCaseOnBoardIndicator.fromJson(json['infectiousDiseaseCaseOnBoardIndicator'] as Map<String, dynamic>?),
      moreIllThanExpectedIndicator: MoreIllThanExpectedIndicator.fromJson(json['moreIllThanExpectedIndicator'] as Map<String, dynamic>?),
      medicalPractitionerConsultedIndicator: MedicalPractitionerConsultedIndicator.fromJson(json['medicalPractitionerConsultedIndicator'] as Map<String, dynamic>?),
      stowawaysFoundOnBoardIndicator: StowawaysFoundOnBoardIndicator.fromJson(json['stowawaysFoundOnBoardIndicator'] as Map<String, dynamic>?),
      sickAnimalOnBoardIndicator: SickAnimalOnBoardIndicator.fromJson(json['sickAnimalOnBoardIndicator'] as Map<String, dynamic>?),
      fumigatedCargoTransportIndicator: FumigatedCargoTransportIndicator.fromJson(json['fumigatedCargoTransportIndicator'] as Map<String, dynamic>?),
      sanitaryMeasuresAppliedIndicator: SanitaryMeasuresAppliedIndicator.fromJson(json['sanitaryMeasuresAppliedIndicator'] as Map<String, dynamic>?),
      validSanitationCertificateOnBoardIndicator: ValidSanitationCertificateOnBoardIndicator.fromJson(json['validSanitationCertificateOnBoardIndicator'] as Map<String, dynamic>?),
      reinspectionRequiredIndicator: ReinspectionRequiredIndicator.fromJson(json['reinspectionRequiredIndicator'] as Map<String, dynamic>?),
      totalDeadPersonQuantity: TotalDeadPersonQuantity.fromJson(json['totalDeadPersonQuantity'] as Map<String, dynamic>?),
      totalIllPersonQuantity: TotalIllPersonQuantity.fromJson(json['totalIllPersonQuantity'] as Map<String, dynamic>?),
      sickAnimalDescription: (json['sickAnimalDescription'] as List? ?? []).map((dynamic d) => SickAnimalDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      stowawayDescription: (json['stowawayDescription'] as List? ?? []).map((dynamic d) => StowawayDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      lastDrinkingWaterAnalysisDate: LastDrinkingWaterAnalysisDate.fromJson(json['lastDrinkingWaterAnalysisDate'] as Map<String, dynamic>?),
      wHOAffectedAreaVisit: (json['wHOAffectedAreaVisit'] as List? ?? []).map((dynamic d) => WHOAffectedAreaVisit.fromJson(d as Map<String, dynamic>?)!).toList(),
      personnelHealthIncident: (json['personnelHealthIncident'] as List? ?? []).map((dynamic d) => PersonnelHealthIncident.fromJson(d as Map<String, dynamic>?)!).toList(),
      sanitaryMeasure: (json['sanitaryMeasure'] as List? ?? []).map((dynamic d) => SanitaryMeasure.fromJson(d as Map<String, dynamic>?)!).toList(),
      placeOfReportLocation: PlaceOfReportLocation.fromJson(json['placeOfReportLocation'] as Map<String, dynamic>?),
      medicalCertificate: MedicalCertificate.fromJson(json['medicalCertificate'] as Map<String, dynamic>?),
      shipSanitationControlCertificate: ShipSanitationControlCertificate.fromJson(json['shipSanitationControlCertificate'] as Map<String, dynamic>?),
      shipSanitationControlExemptionDocumentReference: (json['shipSanitationControlExemptionDocumentReference'] as List? ?? []).map((dynamic d) => ShipSanitationControlExemptionDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'infectiousDiseaseCaseOnBoardIndicator': infectiousDiseaseCaseOnBoardIndicator?.toJson(),
      'moreIllThanExpectedIndicator': moreIllThanExpectedIndicator?.toJson(),
      'medicalPractitionerConsultedIndicator': medicalPractitionerConsultedIndicator?.toJson(),
      'stowawaysFoundOnBoardIndicator': stowawaysFoundOnBoardIndicator?.toJson(),
      'sickAnimalOnBoardIndicator': sickAnimalOnBoardIndicator?.toJson(),
      'fumigatedCargoTransportIndicator': fumigatedCargoTransportIndicator?.toJson(),
      'sanitaryMeasuresAppliedIndicator': sanitaryMeasuresAppliedIndicator?.toJson(),
      'validSanitationCertificateOnBoardIndicator': validSanitationCertificateOnBoardIndicator?.toJson(),
      'reinspectionRequiredIndicator': reinspectionRequiredIndicator?.toJson(),
      'totalDeadPersonQuantity': totalDeadPersonQuantity?.toJson(),
      'totalIllPersonQuantity': totalIllPersonQuantity?.toJson(),
      'sickAnimalDescription': sickAnimalDescription.map((e) => e.toJson()).toList(),
      'stowawayDescription': stowawayDescription.map((e) => e.toJson()).toList(),
      'lastDrinkingWaterAnalysisDate': lastDrinkingWaterAnalysisDate?.toJson(),
      'wHOAffectedAreaVisit': wHOAffectedAreaVisit.map((e) => e.toJson()).toList(),
      'personnelHealthIncident': personnelHealthIncident.map((e) => e.toJson()).toList(),
      'sanitaryMeasure': sanitaryMeasure.map((e) => e.toJson()).toList(),
      'placeOfReportLocation': placeOfReportLocation?.toJson(),
      'medicalCertificate': medicalCertificate?.toJson(),
      'shipSanitationControlCertificate': shipSanitationControlCertificate?.toJson(),
      'shipSanitationControlExemptionDocumentReference': shipSanitationControlExemptionDocumentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MaritimeHealthDeclaration? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return MaritimeHealthDeclaration (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      infectiousDiseaseCaseOnBoardIndicator: InfectiousDiseaseCaseOnBoardIndicator.fromXml(xml.findElements('cbc:InfectiousDiseaseCaseOnBoardIndicator').singleOrNull),
      moreIllThanExpectedIndicator: MoreIllThanExpectedIndicator.fromXml(xml.findElements('cbc:MoreIllThanExpectedIndicator').singleOrNull),
      medicalPractitionerConsultedIndicator: MedicalPractitionerConsultedIndicator.fromXml(xml.findElements('cbc:MedicalPractitionerConsultedIndicator').singleOrNull),
      stowawaysFoundOnBoardIndicator: StowawaysFoundOnBoardIndicator.fromXml(xml.findElements('cbc:StowawaysFoundOnBoardIndicator').singleOrNull),
      sickAnimalOnBoardIndicator: SickAnimalOnBoardIndicator.fromXml(xml.findElements('cbc:SickAnimalOnBoardIndicator').singleOrNull),
      fumigatedCargoTransportIndicator: FumigatedCargoTransportIndicator.fromXml(xml.findElements('cbc:FumigatedCargoTransportIndicator').singleOrNull),
      sanitaryMeasuresAppliedIndicator: SanitaryMeasuresAppliedIndicator.fromXml(xml.findElements('cbc:SanitaryMeasuresAppliedIndicator').singleOrNull),
      validSanitationCertificateOnBoardIndicator: ValidSanitationCertificateOnBoardIndicator.fromXml(xml.findElements('cbc:ValidSanitationCertificateOnBoardIndicator').singleOrNull),
      reinspectionRequiredIndicator: ReinspectionRequiredIndicator.fromXml(xml.findElements('cbc:ReinspectionRequiredIndicator').singleOrNull),
      totalDeadPersonQuantity: TotalDeadPersonQuantity.fromXml(xml.findElements('cbc:TotalDeadPersonQuantity').singleOrNull),
      totalIllPersonQuantity: TotalIllPersonQuantity.fromXml(xml.findElements('cbc:TotalIllPersonQuantity').singleOrNull),
      sickAnimalDescription: xml.findElements('cbc:SickAnimalDescription').map((XmlElement e) => SickAnimalDescription.fromXml(e)!).toList(),
      stowawayDescription: xml.findElements('cbc:StowawayDescription').map((XmlElement e) => StowawayDescription.fromXml(e)!).toList(),
      lastDrinkingWaterAnalysisDate: LastDrinkingWaterAnalysisDate.fromXml(xml.findElements('cbc:LastDrinkingWaterAnalysisDate').singleOrNull),
      wHOAffectedAreaVisit: xml.findElements('cac:WHOAffectedAreaVisit').map((XmlElement e) => WHOAffectedAreaVisit.fromXml(e)!).toList(),
      personnelHealthIncident: xml.findElements('cac:PersonnelHealthIncident').map((XmlElement e) => PersonnelHealthIncident.fromXml(e)!).toList(),
      sanitaryMeasure: xml.findElements('cac:SanitaryMeasure').map((XmlElement e) => SanitaryMeasure.fromXml(e)!).toList(),
      placeOfReportLocation: PlaceOfReportLocation.fromXml(xml.findElements('cac:PlaceOfReportLocation').singleOrNull),
      medicalCertificate: MedicalCertificate.fromXml(xml.findElements('cac:MedicalCertificate').singleOrNull),
      shipSanitationControlCertificate: ShipSanitationControlCertificate.fromXml(xml.findElements('cac:ShipSanitationControlCertificate').singleOrNull),
      shipSanitationControlExemptionDocumentReference: xml.findElements('cac:ShipSanitationControlExemptionDocumentReference').map((XmlElement e) => ShipSanitationControlExemptionDocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'MaritimeHealthDeclaration',
        'cac',
      ),
    );
  }
}

