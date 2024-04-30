import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/IdentificationID.dart';
import '../cbc/OccurrenceDate.dart';
import '../cbc/OccurrenceTime.dart';
import '../cbc/TransportEventTypeCode.dart';
import '../cbc/Description.dart';
import '../cbc/CompletionIndicator.dart';
import '../cac/ReportedShipment.dart';
import '../cac/CurrentStatus.dart';
import '../cac/Contact.dart';
import '../cac/Location.dart';
import '../cac/Signature.dart';
import '../cac/Period.dart';

// A class to describe a significant occurrence or happening related to the transportation of goods.
class PlannedPickupTransportEvent {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this transport event within an agreed event identification scheme.
  final IdentificationID? identificationID;

  // The date of this transport event.
  final OccurrenceDate? occurrenceDate;

  // The time of this transport event.
  final OccurrenceTime? occurrenceTime;

  // A code signifying the type of this transport event.
  final TransportEventTypeCode? transportEventTypeCode;

  // Text describing this transport event.
  final List<Description> description;

  // An indicator that this transport event has been completed (true) or not (false).
  final CompletionIndicator? completionIndicator;

  // The shipment involved in this transport event.
  final ReportedShipment? reportedShipment;

  // The current status of this transport event.
  final List<CurrentStatus> currentStatus;

  // A contact associated with this transport event.
  final List<Contact> contact;

  // The location associated with this transport event.
  final Location? location;

  // A signature that can be used to sign for an entry or an exit at a transport location (e.g., port terminal).
  final Signature? signature;

  // A period of time associated with this transport event.
  final List<Period> period;

  PlannedPickupTransportEvent ({
    this.uBLExtensions,
    this.identificationID,
    this.occurrenceDate,
    this.occurrenceTime,
    this.transportEventTypeCode,
    this.description = const [],
    this.completionIndicator,
    this.reportedShipment,
    this.currentStatus = const [],
    this.contact = const [],
    this.location,
    this.signature,
    this.period = const [],
  });

  static PlannedPickupTransportEvent? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PlannedPickupTransportEvent (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      identificationID: IdentificationID.fromJson(json['identificationID'] as Map<String, dynamic>?),
      occurrenceDate: OccurrenceDate.fromJson(json['occurrenceDate'] as Map<String, dynamic>?),
      occurrenceTime: OccurrenceTime.fromJson(json['occurrenceTime'] as Map<String, dynamic>?),
      transportEventTypeCode: TransportEventTypeCode.fromJson(json['transportEventTypeCode'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      completionIndicator: CompletionIndicator.fromJson(json['completionIndicator'] as Map<String, dynamic>?),
      reportedShipment: ReportedShipment.fromJson(json['reportedShipment'] as Map<String, dynamic>?),
      currentStatus: (json['currentStatus'] as List? ?? []).map((dynamic d) => CurrentStatus.fromJson(d as Map<String, dynamic>?)!).toList(),
      contact: (json['contact'] as List? ?? []).map((dynamic d) => Contact.fromJson(d as Map<String, dynamic>?)!).toList(),
      location: Location.fromJson(json['location'] as Map<String, dynamic>?),
      signature: Signature.fromJson(json['signature'] as Map<String, dynamic>?),
      period: (json['period'] as List? ?? []).map((dynamic d) => Period.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'identificationID': identificationID?.toJson(),
      'occurrenceDate': occurrenceDate?.toJson(),
      'occurrenceTime': occurrenceTime?.toJson(),
      'transportEventTypeCode': transportEventTypeCode?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'completionIndicator': completionIndicator?.toJson(),
      'reportedShipment': reportedShipment?.toJson(),
      'currentStatus': currentStatus.map((e) => e.toJson()).toList(),
      'contact': contact.map((e) => e.toJson()).toList(),
      'location': location?.toJson(),
      'signature': signature?.toJson(),
      'period': period.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PlannedPickupTransportEvent? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PlannedPickupTransportEvent (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      identificationID: IdentificationID.fromXml(xml.findElements('cbc:IdentificationID').singleOrNull),
      occurrenceDate: OccurrenceDate.fromXml(xml.findElements('cbc:OccurrenceDate').singleOrNull),
      occurrenceTime: OccurrenceTime.fromXml(xml.findElements('cbc:OccurrenceTime').singleOrNull),
      transportEventTypeCode: TransportEventTypeCode.fromXml(xml.findElements('cbc:TransportEventTypeCode').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      completionIndicator: CompletionIndicator.fromXml(xml.findElements('cbc:CompletionIndicator').singleOrNull),
      reportedShipment: ReportedShipment.fromXml(xml.findElements('cac:ReportedShipment').singleOrNull),
      currentStatus: xml.findElements('cac:CurrentStatus').map((XmlElement e) => CurrentStatus.fromXml(e)!).toList(),
      contact: xml.findElements('cac:Contact').map((XmlElement e) => Contact.fromXml(e)!).toList(),
      location: Location.fromXml(xml.findElements('cac:Location').singleOrNull),
      signature: Signature.fromXml(xml.findElements('cac:Signature').singleOrNull),
      period: xml.findElements('cac:Period').map((XmlElement e) => Period.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'PlannedPickupTransportEvent',
        'cac',
      ),
    );
  }
}

