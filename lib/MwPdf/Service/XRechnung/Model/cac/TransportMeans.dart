import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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
class TransportMeans {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  TransportMeans ({
    this.uBLExtensions,
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

  static TransportMeans? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TransportMeans (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      journeyID: JourneyID.fromJson(json['journeyID'] as Map<String, dynamic>?),
      registrationNationalityID: RegistrationNationalityID.fromJson(json['registrationNationalityID'] as Map<String, dynamic>?),
      registrationNationality: (json['registrationNationality'] as List? ?? []).map((dynamic d) => RegistrationNationality.fromJson(d as Map<String, dynamic>?)!).toList(),
      directionCode: DirectionCode.fromJson(json['directionCode'] as Map<String, dynamic>?),
      transportMeansTypeCode: TransportMeansTypeCode.fromJson(json['transportMeansTypeCode'] as Map<String, dynamic>?),
      tradeServiceCode: TradeServiceCode.fromJson(json['tradeServiceCode'] as Map<String, dynamic>?),
      stowage: Stowage.fromJson(json['stowage'] as Map<String, dynamic>?),
      airTransport: AirTransport.fromJson(json['airTransport'] as Map<String, dynamic>?),
      roadTransport: RoadTransport.fromJson(json['roadTransport'] as Map<String, dynamic>?),
      railTransport: RailTransport.fromJson(json['railTransport'] as Map<String, dynamic>?),
      maritimeTransport: MaritimeTransport.fromJson(json['maritimeTransport'] as Map<String, dynamic>?),
      ownerParty: OwnerParty.fromJson(json['ownerParty'] as Map<String, dynamic>?),
      measurementDimension: (json['measurementDimension'] as List? ?? []).map((dynamic d) => MeasurementDimension.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static TransportMeans? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TransportMeans (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      journeyID: JourneyID.fromXml(xml.findElements('cbc:JourneyID').singleOrNull),
      registrationNationalityID: RegistrationNationalityID.fromXml(xml.findElements('cbc:RegistrationNationalityID').singleOrNull),
      registrationNationality: xml.findElements('cbc:RegistrationNationality').map((XmlElement e) => RegistrationNationality.fromXml(e)!).toList(),
      directionCode: DirectionCode.fromXml(xml.findElements('cbc:DirectionCode').singleOrNull),
      transportMeansTypeCode: TransportMeansTypeCode.fromXml(xml.findElements('cbc:TransportMeansTypeCode').singleOrNull),
      tradeServiceCode: TradeServiceCode.fromXml(xml.findElements('cbc:TradeServiceCode').singleOrNull),
      stowage: Stowage.fromXml(xml.findElements('cac:Stowage').singleOrNull),
      airTransport: AirTransport.fromXml(xml.findElements('cac:AirTransport').singleOrNull),
      roadTransport: RoadTransport.fromXml(xml.findElements('cac:RoadTransport').singleOrNull),
      railTransport: RailTransport.fromXml(xml.findElements('cac:RailTransport').singleOrNull),
      maritimeTransport: MaritimeTransport.fromXml(xml.findElements('cac:MaritimeTransport').singleOrNull),
      ownerParty: OwnerParty.fromXml(xml.findElements('cac:OwnerParty').singleOrNull),
      measurementDimension: xml.findElements('cac:MeasurementDimension').map((XmlElement e) => MeasurementDimension.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      journeyID?.toXml(),
      registrationNationalityID?.toXml(),
      ...registrationNationality.map((RegistrationNationality e) => e.toXml()).toList(),
      directionCode?.toXml(),
      transportMeansTypeCode?.toXml(),
      tradeServiceCode?.toXml(),
      stowage?.toXml(),
      airTransport?.toXml(),
      roadTransport?.toXml(),
      railTransport?.toXml(),
      maritimeTransport?.toXml(),
      ownerParty?.toXml(),
      ...measurementDimension.map((MeasurementDimension e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TransportMeans',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

