import 'dart:convert';
import '../cbc/ID.dart';
import '../cbc/Description.dart';
import '../cbc/Conditions.dart';
import '../cbc/CountrySubentity.dart';
import '../cbc/CountrySubentityCode.dart';
import '../cbc/LocationTypeCode.dart';
import '../cbc/InformationURI.dart';
import '../cbc/Name.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/Address.dart';
import '../cac/SubsidiaryLocation.dart';
import '../cac/LocationCoordinate.dart';

// A class to describe a location.
class FreightChargeLocation {


  // An identifier for this location, e.g., the EAN Location Number, GLN.
  final ID? iD;

  // Text describing this location.
  final List<Description> description;

  // Free-form text describing the physical conditions of the location.
  final List<Conditions> conditions;

  // A territorial division of a country, such as a county or state, expressed as text.
  final CountrySubentity? countrySubentity;

  // A territorial division of a country, such as a county or state, expressed as a code.
  final CountrySubentityCode? countrySubentityCode;

  // A code signifying the type of location.
  final LocationTypeCode? locationTypeCode;

  // The Uniform Resource Identifier (URI) of a document providing information about this location.
  final InformationURI? informationURI;

  // The name of this location.
  final Name? name;

  // A period during which this location can be used (e.g., for delivery).
  final List<ValidityPeriod> validityPeriod;

  // The address of this location.
  final Address? address;

  // A location subsidiary to this location.
  final List<SubsidiaryLocation> subsidiaryLocation;

  // The geographical coordinates of this location.
  final List<LocationCoordinate> locationCoordinate;

  FreightChargeLocation ({
    this.iD,
    this.description = const [],
    this.conditions = const [],
    this.countrySubentity,
    this.countrySubentityCode,
    this.locationTypeCode,
    this.informationURI,
    this.name,
    this.validityPeriod = const [],
    this.address,
    this.subsidiaryLocation = const [],
    this.locationCoordinate = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'iD': iD?.toJson(),
     'description': description.map((e) => e.toJson()).toList(),
     'conditions': conditions.map((e) => e.toJson()).toList(),
     'countrySubentity': countrySubentity?.toJson(),
     'countrySubentityCode': countrySubentityCode?.toJson(),
     'locationTypeCode': locationTypeCode?.toJson(),
     'informationURI': informationURI?.toJson(),
     'name': name?.toJson(),
     'validityPeriod': validityPeriod.map((e) => e.toJson()).toList(),
     'address': address?.toJson(),
     'subsidiaryLocation': subsidiaryLocation.map((e) => e.toJson()).toList(),
     'locationCoordinate': locationCoordinate.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;

  }

}

