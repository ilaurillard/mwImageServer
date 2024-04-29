import '../cac/ID.dart';
import '../cac/AddressTypeCode.dart';
import '../cac/AddressFormatCode.dart';
import '../cac/Postbox.dart';
import '../cac/Floor.dart';
import '../cac/Room.dart';
import '../cac/StreetName.dart';
import '../cac/AdditionalStreetName.dart';
import '../cac/BlockName.dart';
import '../cac/BuildingName.dart';
import '../cac/BuildingNumber.dart';
import '../cac/InhouseMail.dart';
import '../cac/Department.dart';
import '../cac/MarkAttention.dart';
import '../cac/MarkCare.dart';
import '../cac/PlotIdentification.dart';
import '../cac/CitySubdivisionName.dart';
import '../cac/CityName.dart';
import '../cac/PostalZone.dart';
import '../cac/CountrySubentity.dart';
import '../cac/CountrySubentityCode.dart';
import '../cac/Region.dart';
import '../cac/District.dart';
import '../cac/TimezoneOffset.dart';
import '../cac/AddressLine.dart';
import '../cac/Country.dart';
import '../cac/LocationCoordinate.dart';

// A class to define common information related to an address.
class DespatchAddress {


  // An identifier for this address within an agreed scheme of address identifiers.
  final ID? iD;

  // A mutually agreed code signifying the type of this address.
  final AddressTypeCode? addressTypeCode;

  // A mutually agreed code signifying the format of this address.
  final AddressFormatCode? addressFormatCode;

  // A post office box number registered for postal delivery by a postal service provider.
  final Postbox? postbox;

  // An identifiable floor of a building.
  final Floor? floor;

  // An identifiable room, suite, or apartment of a building.
  final Room? room;

  // The name of the street, road, avenue, way, etc. to which the number of the building is attached.
  final StreetName? streetName;

  // An additional street name used to further clarify the address.
  final AdditionalStreetName? additionalStreetName;

  // The name of the block (an area surrounded by streets and usually containing several buildings) in which this address is located.
  final BlockName? blockName;

  // The name of a building.
  final BuildingName? buildingName;

  // The number of a building within the street.
  final BuildingNumber? buildingNumber;

  // The specific identifable location within a building where mail is delivered.
  final InhouseMail? inhouseMail;

  // The department of the addressee.
  final Department? department;

  // The name, expressed as text, of a person or department in an organization to whose attention incoming mail is directed; corresponds to the printed forms "for the attention of", "FAO", and ATTN:".
  final MarkAttention? markAttention;

  // The name, expressed as text, of a person or organization at this address into whose care incoming mail is entrusted; corresponds to the printed forms "care of" and "c/o".
  final MarkCare? markCare;

  // An identifier (e.g., a parcel number) for the piece of land associated with this address.
  final PlotIdentification? plotIdentification;

  // The name of the subdivision of a city, town, or village in which this address is located, such as the name of its district or borough.
  final CitySubdivisionName? citySubdivisionName;

  // The name of a city, town, or village.
  final CityName? cityName;

  // The postal identifier for this address according to the relevant national postal service, such as a ZIP code or Post Code.
  final PostalZone? postalZone;

  // The political or administrative division of a country in which this address is located, such as the name of its county, province, or state, expressed as text.
  final CountrySubentity? countrySubentity;

  // The political or administrative division of a country in which this address is located, such as a county, province, or state, expressed as a code (typically nationally agreed).
  final CountrySubentityCode? countrySubentityCode;

  // The recognized geographic or economic region or group of countries in which this address is located.
  final Region? region;

  // The district or geographical division of a country or region in which this address is located.
  final District? district;

  // The time zone in which this address is located (as an offset from Universal Coordinated Time (UTC)) at the time of exchange.
  final TimezoneOffset? timezoneOffset;

  // An unstructured address line.
  final List<AddressLine> addressLine;

  // The country in which this address is situated.
  final Country? country;

  // The geographical coordinates of this address.
  final List<LocationCoordinate> locationCoordinate;

  DespatchAddress ({
    this.iD,
    this.addressTypeCode,
    this.addressFormatCode,
    this.postbox,
    this.floor,
    this.room,
    this.streetName,
    this.additionalStreetName,
    this.blockName,
    this.buildingName,
    this.buildingNumber,
    this.inhouseMail,
    this.department,
    this.markAttention,
    this.markCare,
    this.plotIdentification,
    this.citySubdivisionName,
    this.cityName,
    this.postalZone,
    this.countrySubentity,
    this.countrySubentityCode,
    this.region,
    this.district,
    this.timezoneOffset,
    this.addressLine = const [],
    this.country,
    this.locationCoordinate = const [],
  });
}

