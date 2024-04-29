import 'dart:convert';
import '../../Etc/Util.dart';
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
class PlannedArrivalTransportEvent {


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

  PlannedArrivalTransportEvent ({
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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


  PlannedArrivalTransportEvent fromJson(Map<String, dynamic> json) {
    return PlannedArrivalTransportEvent (
    );
  }

}

