import '../cac/ID.dart';
import '../cac/Description.dart';
import '../cac/Conditions.dart';
import '../cac/CountrySubentity.dart';
import '../cac/CountrySubentityCode.dart';
import '../cac/LocationTypeCode.dart';
import '../cac/InformationURI.dart';
import '../cac/Name.dart';
import '../cac/ValidityPeriod.dart';
import '../cac/Address.dart';
import '../cac/SubsidiaryLocation.dart';
import '../cac/LocationCoordinate.dart';

// A class to describe a location.
class UnloadingLocation {


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

  UnloadingLocation ({
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
}

