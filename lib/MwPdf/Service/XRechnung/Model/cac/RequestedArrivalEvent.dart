import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/IdentificationID.dart';
import '../cbc/OccurrenceDate.dart';
import '../cbc/OccurrenceTime.dart';
import '../cbc/TypeCode.dart';
import '../cbc/Description.dart';
import '../cbc/CompletionIndicator.dart';
import '../cac/CurrentStatus.dart';
import '../cac/Contact.dart';
import '../cac/OccurenceLocation.dart';

// A class to describe a significant occurrence relating to an object, process, or person.
class RequestedArrivalEvent {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this event within an agreed event identification scheme.
  final IdentificationID? identificationID;

  // The date of this event.
  final OccurrenceDate? occurrenceDate;

  // The time of this event.
  final OccurrenceTime? occurrenceTime;

  // A code signifying the type of this event.
  final TypeCode? typeCode;

  // Text describing this event.
  final List<Description> description;

  // An indicator that this event has been completed (true) or not (false).
  final CompletionIndicator? completionIndicator;

  // The current status of this event.
  final List<CurrentStatus> currentStatus;

  // Contacts associated with this event.
  final List<Contact> contact;

  // The location of this event.
  final OccurenceLocation? occurenceLocation;

  RequestedArrivalEvent ({
    this.uBLExtensions,
    this.identificationID,
    this.occurrenceDate,
    this.occurrenceTime,
    this.typeCode,
    this.description = const [],
    this.completionIndicator,
    this.currentStatus = const [],
    this.contact = const [],
    this.occurenceLocation,
  });

  static RequestedArrivalEvent? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return RequestedArrivalEvent (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      identificationID: IdentificationID.fromJson(json['identificationID'] as Map<String, dynamic>?),
      occurrenceDate: OccurrenceDate.fromJson(json['occurrenceDate'] as Map<String, dynamic>?),
      occurrenceTime: OccurrenceTime.fromJson(json['occurrenceTime'] as Map<String, dynamic>?),
      typeCode: TypeCode.fromJson(json['typeCode'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      completionIndicator: CompletionIndicator.fromJson(json['completionIndicator'] as Map<String, dynamic>?),
      currentStatus: (json['currentStatus'] as List? ?? []).map((dynamic d) => CurrentStatus.fromJson(d as Map<String, dynamic>?)!).toList(),
      contact: (json['contact'] as List? ?? []).map((dynamic d) => Contact.fromJson(d as Map<String, dynamic>?)!).toList(),
      occurenceLocation: OccurenceLocation.fromJson(json['occurenceLocation'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'identificationID': identificationID?.toJson(),
      'occurrenceDate': occurrenceDate?.toJson(),
      'occurrenceTime': occurrenceTime?.toJson(),
      'typeCode': typeCode?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'completionIndicator': completionIndicator?.toJson(),
      'currentStatus': currentStatus.map((e) => e.toJson()).toList(),
      'contact': contact.map((e) => e.toJson()).toList(),
      'occurenceLocation': occurenceLocation?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static RequestedArrivalEvent? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return RequestedArrivalEvent (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      identificationID: IdentificationID.fromXml(xml.findElements('cbc:IdentificationID').singleOrNull),
      occurrenceDate: OccurrenceDate.fromXml(xml.findElements('cbc:OccurrenceDate').singleOrNull),
      occurrenceTime: OccurrenceTime.fromXml(xml.findElements('cbc:OccurrenceTime').singleOrNull),
      typeCode: TypeCode.fromXml(xml.findElements('cbc:TypeCode').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      completionIndicator: CompletionIndicator.fromXml(xml.findElements('cbc:CompletionIndicator').singleOrNull),
      currentStatus: xml.findElements('cac:CurrentStatus').map((XmlElement e) => CurrentStatus.fromXml(e)!).toList(),
      contact: xml.findElements('cac:Contact').map((XmlElement e) => Contact.fromXml(e)!).toList(),
      occurenceLocation: OccurenceLocation.fromXml(xml.findElements('cac:OccurenceLocation').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'RequestedArrivalEvent',
        'cac',
      ),
    );
  }
}

