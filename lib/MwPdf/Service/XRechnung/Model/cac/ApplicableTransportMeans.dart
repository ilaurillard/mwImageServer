import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/JourneyID.dart';
import '../cbc/RegistrationNationalityID.dart';
import '../cbc/RegistrationNationality.dart';
import '../cbc/DirectionCode.dart';
import '../cbc/TransportMeansTypeCode.dart';
import '../cbc/TradeServiceCode.dart';
import '../cac/Stowage.dart';
import '../cac/AirTransport.dart';
import '../cac/RoadTransport.dart';
import '../cac/RailTransport.dart';
import '../cac/MaritimeTransport.dart';
import '../cac/OwnerParty.dart';
import '../cac/MeasurementDimension.dart';

// A class to describe a particular vehicle or vessel used for the conveyance of goods or persons.
class ApplicableTransportMeans {


  // An identifier for the regular service schedule of this means of transport.
  final JourneyID? journeyID;

  // An identifier for the country in which this means of transport is registered.
  final RegistrationNationalityID? registrationNationalityID;

  // Text describing the country in which this means of transport is registered.
  final List<RegistrationNationality> registrationNationality;

  // A code signifying the direction of this means of transport.
  final DirectionCode? directionCode;

  // A code signifying the type of this means of transport (truck, vessel, etc.).
  final TransportMeansTypeCode? transportMeansTypeCode;

  // A code signifying the service regularly provided by the carrier operating this means of transport.
  final TradeServiceCode? tradeServiceCode;

  // The location within the means of transport where goods are to be or have been stowed.
  final Stowage? stowage;

  // An aircraft used for transport.
  final AirTransport? airTransport;

  // A vehicle used for road transport.
  final RoadTransport? roadTransport;

  // Equipment used for rail transport.
  final RailTransport? railTransport;

  // A vessel used for transport by water (not only by sea).
  final MaritimeTransport? maritimeTransport;

  // The party that owns this means of transport.
  final OwnerParty? ownerParty;

  // A measurable dimension (length, mass, weight, or volume) of this means of transport.
  final List<MeasurementDimension> measurementDimension;

  ApplicableTransportMeans ({
    this.journeyID,
    this.registrationNationalityID,
    this.registrationNationality = const [],
    this.directionCode,
    this.transportMeansTypeCode,
    this.tradeServiceCode,
    this.stowage,
    this.airTransport,
    this.roadTransport,
    this.railTransport,
    this.maritimeTransport,
    this.ownerParty,
    this.measurementDimension = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'journeyID': journeyID?.toJson(),
     'registrationNationalityID': registrationNationalityID?.toJson(),
     'registrationNationality': registrationNationality.map((e) => e.toJson()).toList(),
     'directionCode': directionCode?.toJson(),
     'transportMeansTypeCode': transportMeansTypeCode?.toJson(),
     'tradeServiceCode': tradeServiceCode?.toJson(),
     'stowage': stowage?.toJson(),
     'airTransport': airTransport?.toJson(),
     'roadTransport': roadTransport?.toJson(),
     'railTransport': railTransport?.toJson(),
     'maritimeTransport': maritimeTransport?.toJson(),
     'ownerParty': ownerParty?.toJson(),
     'measurementDimension': measurementDimension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ApplicableTransportMeans fromJson(Map<String, dynamic> json) {
    return ApplicableTransportMeans (
    );
  }

}

