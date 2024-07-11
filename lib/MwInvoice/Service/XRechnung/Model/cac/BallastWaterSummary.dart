// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/ManagementPlanOnBoardIndicator.dart';
import '../cbc/ManagementPlanImplementedIndicator.dart';
import '../cbc/IMOGuidelinesOnBoardIndicator.dart';
import '../cbc/TotalBallastTanksOnBoardQuantity.dart';
import '../cbc/TanksInBallastQuantity.dart';
import '../cbc/TanksExchangedQuantity.dart';
import '../cbc/TanksNotExchangedQuantity.dart';
import '../cbc/TotalBallastWaterOnBoardMeasure.dart';
import '../cbc/TotalBallastWaterCapacityMeasure.dart';
import '../cbc/OtherControlActions.dart';
import '../cbc/NoControlActionsReason.dart';
import '../cac/UptakeBallastWaterTransaction.dart';
import '../cac/ExchangeBallastWaterTransaction.dart';
import '../cac/DischargeBallastWaterTransaction.dart';
import '../cac/ResponsibleOfficerPerson.dart';

// A class to summarize the ballast water management of a vessel.
class BallastWaterSummary {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identification of this ballast water summary.
  final ID? iD;

  // An indication of whether a waste water management plan is on board (true) or not (false).
  final ManagementPlanOnBoardIndicator? managementPlanOnBoardIndicator;

  // An indication of whether a waste water management plan has been implemented (true) or not (false).
  final ManagementPlanImplementedIndicator? managementPlanImplementedIndicator;

  // An indication of whether International Maritime Organization (IMO) ballast water guidelines are on board (true) or not (false).
  final IMOGuidelinesOnBoardIndicator? iMOGuidelinesOnBoardIndicator;

  // The total number of ballast tanks on board the vessel.
  final TotalBallastTanksOnBoardQuantity? totalBallastTanksOnBoardQuantity;

  // The number of tanks in the ballast of the vessel.
  final TanksInBallastQuantity? tanksInBallastQuantity;

  // The number of tanks being exchanged as part of this ballast water summary.
  final TanksExchangedQuantity? tanksExchangedQuantity;

  // The quantity of tanks not being exchanged.
  final TanksNotExchangedQuantity? tanksNotExchangedQuantity;

  // The messure of the total ballast water on board the vessel.
  final TotalBallastWaterOnBoardMeasure? totalBallastWaterOnBoardMeasure;

  // The total ballast water capacity of the vessel.
  final TotalBallastWaterCapacityMeasure? totalBallastWaterCapacityMeasure;

  // A text describing any other control actions that are part of this ballast water summary.
  final List<OtherControlActions> otherControlActions;

  // A textual description of the reason if no control actions are being taken.
  final List<NoControlActionsReason> noControlActionsReason;

  // The uptake ballast water transaction.
  final List<UptakeBallastWaterTransaction> uptakeBallastWaterTransaction;

  // The exchange ballast water transaction.
  final List<ExchangeBallastWaterTransaction> exchangeBallastWaterTransaction;

  // The discharge ballast water transaction.
  final List<DischargeBallastWaterTransaction> dischargeBallastWaterTransaction;

  // The officer responsible for this ballast water summery.
  final ResponsibleOfficerPerson? responsibleOfficerPerson;

  BallastWaterSummary ({
    this.uBLExtensions,
    this.iD,
    this.managementPlanOnBoardIndicator,
    this.managementPlanImplementedIndicator,
    this.iMOGuidelinesOnBoardIndicator,
    this.totalBallastTanksOnBoardQuantity,
    this.tanksInBallastQuantity,
    this.tanksExchangedQuantity,
    this.tanksNotExchangedQuantity,
    this.totalBallastWaterOnBoardMeasure,
    this.totalBallastWaterCapacityMeasure,
    this.otherControlActions = const [],
    this.noControlActionsReason = const [],
    this.uptakeBallastWaterTransaction = const [],
    this.exchangeBallastWaterTransaction = const [],
    this.dischargeBallastWaterTransaction = const [],
    this.responsibleOfficerPerson,
  });

  static BallastWaterSummary? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return BallastWaterSummary (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      managementPlanOnBoardIndicator: ManagementPlanOnBoardIndicator.fromJson(json['managementPlanOnBoardIndicator'] as Map<String, dynamic>?),
      managementPlanImplementedIndicator: ManagementPlanImplementedIndicator.fromJson(json['managementPlanImplementedIndicator'] as Map<String, dynamic>?),
      iMOGuidelinesOnBoardIndicator: IMOGuidelinesOnBoardIndicator.fromJson(json['iMOGuidelinesOnBoardIndicator'] as Map<String, dynamic>?),
      totalBallastTanksOnBoardQuantity: TotalBallastTanksOnBoardQuantity.fromJson(json['totalBallastTanksOnBoardQuantity'] as Map<String, dynamic>?),
      tanksInBallastQuantity: TanksInBallastQuantity.fromJson(json['tanksInBallastQuantity'] as Map<String, dynamic>?),
      tanksExchangedQuantity: TanksExchangedQuantity.fromJson(json['tanksExchangedQuantity'] as Map<String, dynamic>?),
      tanksNotExchangedQuantity: TanksNotExchangedQuantity.fromJson(json['tanksNotExchangedQuantity'] as Map<String, dynamic>?),
      totalBallastWaterOnBoardMeasure: TotalBallastWaterOnBoardMeasure.fromJson(json['totalBallastWaterOnBoardMeasure'] as Map<String, dynamic>?),
      totalBallastWaterCapacityMeasure: TotalBallastWaterCapacityMeasure.fromJson(json['totalBallastWaterCapacityMeasure'] as Map<String, dynamic>?),
      otherControlActions: (json['otherControlActions'] as List? ?? []).map((dynamic d) => OtherControlActions.fromJson(d as Map<String, dynamic>?)!).toList(),
      noControlActionsReason: (json['noControlActionsReason'] as List? ?? []).map((dynamic d) => NoControlActionsReason.fromJson(d as Map<String, dynamic>?)!).toList(),
      uptakeBallastWaterTransaction: (json['uptakeBallastWaterTransaction'] as List? ?? []).map((dynamic d) => UptakeBallastWaterTransaction.fromJson(d as Map<String, dynamic>?)!).toList(),
      exchangeBallastWaterTransaction: (json['exchangeBallastWaterTransaction'] as List? ?? []).map((dynamic d) => ExchangeBallastWaterTransaction.fromJson(d as Map<String, dynamic>?)!).toList(),
      dischargeBallastWaterTransaction: (json['dischargeBallastWaterTransaction'] as List? ?? []).map((dynamic d) => DischargeBallastWaterTransaction.fromJson(d as Map<String, dynamic>?)!).toList(),
      responsibleOfficerPerson: ResponsibleOfficerPerson.fromJson(json['responsibleOfficerPerson'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'managementPlanOnBoardIndicator': managementPlanOnBoardIndicator?.toJson(),
      'managementPlanImplementedIndicator': managementPlanImplementedIndicator?.toJson(),
      'iMOGuidelinesOnBoardIndicator': iMOGuidelinesOnBoardIndicator?.toJson(),
      'totalBallastTanksOnBoardQuantity': totalBallastTanksOnBoardQuantity?.toJson(),
      'tanksInBallastQuantity': tanksInBallastQuantity?.toJson(),
      'tanksExchangedQuantity': tanksExchangedQuantity?.toJson(),
      'tanksNotExchangedQuantity': tanksNotExchangedQuantity?.toJson(),
      'totalBallastWaterOnBoardMeasure': totalBallastWaterOnBoardMeasure?.toJson(),
      'totalBallastWaterCapacityMeasure': totalBallastWaterCapacityMeasure?.toJson(),
      'otherControlActions': otherControlActions.map((e) => e.toJson()).toList(),
      'noControlActionsReason': noControlActionsReason.map((e) => e.toJson()).toList(),
      'uptakeBallastWaterTransaction': uptakeBallastWaterTransaction.map((e) => e.toJson()).toList(),
      'exchangeBallastWaterTransaction': exchangeBallastWaterTransaction.map((e) => e.toJson()).toList(),
      'dischargeBallastWaterTransaction': dischargeBallastWaterTransaction.map((e) => e.toJson()).toList(),
      'responsibleOfficerPerson': responsibleOfficerPerson?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static BallastWaterSummary? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return BallastWaterSummary (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      managementPlanOnBoardIndicator: ManagementPlanOnBoardIndicator.fromXml(xml.findElements('cbc:ManagementPlanOnBoardIndicator').singleOrNull),
      managementPlanImplementedIndicator: ManagementPlanImplementedIndicator.fromXml(xml.findElements('cbc:ManagementPlanImplementedIndicator').singleOrNull),
      iMOGuidelinesOnBoardIndicator: IMOGuidelinesOnBoardIndicator.fromXml(xml.findElements('cbc:IMOGuidelinesOnBoardIndicator').singleOrNull),
      totalBallastTanksOnBoardQuantity: TotalBallastTanksOnBoardQuantity.fromXml(xml.findElements('cbc:TotalBallastTanksOnBoardQuantity').singleOrNull),
      tanksInBallastQuantity: TanksInBallastQuantity.fromXml(xml.findElements('cbc:TanksInBallastQuantity').singleOrNull),
      tanksExchangedQuantity: TanksExchangedQuantity.fromXml(xml.findElements('cbc:TanksExchangedQuantity').singleOrNull),
      tanksNotExchangedQuantity: TanksNotExchangedQuantity.fromXml(xml.findElements('cbc:TanksNotExchangedQuantity').singleOrNull),
      totalBallastWaterOnBoardMeasure: TotalBallastWaterOnBoardMeasure.fromXml(xml.findElements('cbc:TotalBallastWaterOnBoardMeasure').singleOrNull),
      totalBallastWaterCapacityMeasure: TotalBallastWaterCapacityMeasure.fromXml(xml.findElements('cbc:TotalBallastWaterCapacityMeasure').singleOrNull),
      otherControlActions: xml.findElements('cbc:OtherControlActions').map((XmlElement e) => OtherControlActions.fromXml(e)!).toList(),
      noControlActionsReason: xml.findElements('cbc:NoControlActionsReason').map((XmlElement e) => NoControlActionsReason.fromXml(e)!).toList(),
      uptakeBallastWaterTransaction: xml.findElements('cac:UptakeBallastWaterTransaction').map((XmlElement e) => UptakeBallastWaterTransaction.fromXml(e)!).toList(),
      exchangeBallastWaterTransaction: xml.findElements('cac:ExchangeBallastWaterTransaction').map((XmlElement e) => ExchangeBallastWaterTransaction.fromXml(e)!).toList(),
      dischargeBallastWaterTransaction: xml.findElements('cac:DischargeBallastWaterTransaction').map((XmlElement e) => DischargeBallastWaterTransaction.fromXml(e)!).toList(),
      responsibleOfficerPerson: ResponsibleOfficerPerson.fromXml(xml.findElements('cac:ResponsibleOfficerPerson').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      managementPlanOnBoardIndicator?.toXml(),
      managementPlanImplementedIndicator?.toXml(),
      iMOGuidelinesOnBoardIndicator?.toXml(),
      totalBallastTanksOnBoardQuantity?.toXml(),
      tanksInBallastQuantity?.toXml(),
      tanksExchangedQuantity?.toXml(),
      tanksNotExchangedQuantity?.toXml(),
      totalBallastWaterOnBoardMeasure?.toXml(),
      totalBallastWaterCapacityMeasure?.toXml(),
      ...otherControlActions.map((OtherControlActions e) => e.toXml()),
      ...noControlActionsReason.map((NoControlActionsReason e) => e.toXml()),
      ...uptakeBallastWaterTransaction.map((UptakeBallastWaterTransaction e) => e.toXml()),
      ...exchangeBallastWaterTransaction.map((ExchangeBallastWaterTransaction e) => e.toXml()),
      ...dischargeBallastWaterTransaction.map((DischargeBallastWaterTransaction e) => e.toXml()),
      responsibleOfficerPerson?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'BallastWaterSummary',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

