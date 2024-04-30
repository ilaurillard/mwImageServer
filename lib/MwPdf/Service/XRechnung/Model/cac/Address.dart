import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/AddressTypeCode.dart';
import '../cbc/AddressFormatCode.dart';
import '../cbc/Postbox.dart';
import '../cbc/Floor.dart';
import '../cbc/Room.dart';
import '../cbc/StreetName.dart';
import '../cbc/AdditionalStreetName.dart';
import '../cbc/BlockName.dart';
import '../cbc/BuildingName.dart';
import '../cbc/BuildingNumber.dart';
import '../cbc/Description.dart';
import '../cbc/InhouseMail.dart';
import '../cbc/Department.dart';
import '../cbc/MarkAttention.dart';
import '../cbc/MarkCare.dart';
import '../cbc/PlotIdentification.dart';
import '../cbc/CitySubdivisionName.dart';
import '../cbc/CityName.dart';
import '../cbc/PostalZone.dart';
import '../cbc/CountrySubentity.dart';
import '../cbc/CountrySubentityCode.dart';
import '../cbc/Region.dart';
import '../cbc/District.dart';
import '../cbc/TimezoneOffset.dart';
import '../cac/AddressLine.dart';
import '../cac/Country.dart';
import '../cac/LocationCoordinate.dart';

// A class to define common information related to an address.
class Address {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // Text describing this address for clarification or specificity
  final List<Description> description;

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

  Address ({
    this.uBLExtensions,
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
    this.description = const [],
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

  static Address? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Address (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      addressTypeCode: AddressTypeCode.fromJson(json['addressTypeCode'] as Map<String, dynamic>?),
      addressFormatCode: AddressFormatCode.fromJson(json['addressFormatCode'] as Map<String, dynamic>?),
      postbox: Postbox.fromJson(json['postbox'] as Map<String, dynamic>?),
      floor: Floor.fromJson(json['floor'] as Map<String, dynamic>?),
      room: Room.fromJson(json['room'] as Map<String, dynamic>?),
      streetName: StreetName.fromJson(json['streetName'] as Map<String, dynamic>?),
      additionalStreetName: AdditionalStreetName.fromJson(json['additionalStreetName'] as Map<String, dynamic>?),
      blockName: BlockName.fromJson(json['blockName'] as Map<String, dynamic>?),
      buildingName: BuildingName.fromJson(json['buildingName'] as Map<String, dynamic>?),
      buildingNumber: BuildingNumber.fromJson(json['buildingNumber'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      inhouseMail: InhouseMail.fromJson(json['inhouseMail'] as Map<String, dynamic>?),
      department: Department.fromJson(json['department'] as Map<String, dynamic>?),
      markAttention: MarkAttention.fromJson(json['markAttention'] as Map<String, dynamic>?),
      markCare: MarkCare.fromJson(json['markCare'] as Map<String, dynamic>?),
      plotIdentification: PlotIdentification.fromJson(json['plotIdentification'] as Map<String, dynamic>?),
      citySubdivisionName: CitySubdivisionName.fromJson(json['citySubdivisionName'] as Map<String, dynamic>?),
      cityName: CityName.fromJson(json['cityName'] as Map<String, dynamic>?),
      postalZone: PostalZone.fromJson(json['postalZone'] as Map<String, dynamic>?),
      countrySubentity: CountrySubentity.fromJson(json['countrySubentity'] as Map<String, dynamic>?),
      countrySubentityCode: CountrySubentityCode.fromJson(json['countrySubentityCode'] as Map<String, dynamic>?),
      region: Region.fromJson(json['region'] as Map<String, dynamic>?),
      district: District.fromJson(json['district'] as Map<String, dynamic>?),
      timezoneOffset: TimezoneOffset.fromJson(json['timezoneOffset'] as Map<String, dynamic>?),
      addressLine: (json['addressLine'] as List? ?? []).map((dynamic d) => AddressLine.fromJson(d as Map<String, dynamic>?)!).toList(),
      country: Country.fromJson(json['country'] as Map<String, dynamic>?),
      locationCoordinate: (json['locationCoordinate'] as List? ?? []).map((dynamic d) => LocationCoordinate.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'addressTypeCode': addressTypeCode?.toJson(),
      'addressFormatCode': addressFormatCode?.toJson(),
      'postbox': postbox?.toJson(),
      'floor': floor?.toJson(),
      'room': room?.toJson(),
      'streetName': streetName?.toJson(),
      'additionalStreetName': additionalStreetName?.toJson(),
      'blockName': blockName?.toJson(),
      'buildingName': buildingName?.toJson(),
      'buildingNumber': buildingNumber?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'inhouseMail': inhouseMail?.toJson(),
      'department': department?.toJson(),
      'markAttention': markAttention?.toJson(),
      'markCare': markCare?.toJson(),
      'plotIdentification': plotIdentification?.toJson(),
      'citySubdivisionName': citySubdivisionName?.toJson(),
      'cityName': cityName?.toJson(),
      'postalZone': postalZone?.toJson(),
      'countrySubentity': countrySubentity?.toJson(),
      'countrySubentityCode': countrySubentityCode?.toJson(),
      'region': region?.toJson(),
      'district': district?.toJson(),
      'timezoneOffset': timezoneOffset?.toJson(),
      'addressLine': addressLine.map((e) => e.toJson()).toList(),
      'country': country?.toJson(),
      'locationCoordinate': locationCoordinate.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Address? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Address (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      addressTypeCode: AddressTypeCode.fromXml(xml.findElements('cbc:AddressTypeCode').singleOrNull),
      addressFormatCode: AddressFormatCode.fromXml(xml.findElements('cbc:AddressFormatCode').singleOrNull),
      postbox: Postbox.fromXml(xml.findElements('cbc:Postbox').singleOrNull),
      floor: Floor.fromXml(xml.findElements('cbc:Floor').singleOrNull),
      room: Room.fromXml(xml.findElements('cbc:Room').singleOrNull),
      streetName: StreetName.fromXml(xml.findElements('cbc:StreetName').singleOrNull),
      additionalStreetName: AdditionalStreetName.fromXml(xml.findElements('cbc:AdditionalStreetName').singleOrNull),
      blockName: BlockName.fromXml(xml.findElements('cbc:BlockName').singleOrNull),
      buildingName: BuildingName.fromXml(xml.findElements('cbc:BuildingName').singleOrNull),
      buildingNumber: BuildingNumber.fromXml(xml.findElements('cbc:BuildingNumber').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      inhouseMail: InhouseMail.fromXml(xml.findElements('cbc:InhouseMail').singleOrNull),
      department: Department.fromXml(xml.findElements('cbc:Department').singleOrNull),
      markAttention: MarkAttention.fromXml(xml.findElements('cbc:MarkAttention').singleOrNull),
      markCare: MarkCare.fromXml(xml.findElements('cbc:MarkCare').singleOrNull),
      plotIdentification: PlotIdentification.fromXml(xml.findElements('cbc:PlotIdentification').singleOrNull),
      citySubdivisionName: CitySubdivisionName.fromXml(xml.findElements('cbc:CitySubdivisionName').singleOrNull),
      cityName: CityName.fromXml(xml.findElements('cbc:CityName').singleOrNull),
      postalZone: PostalZone.fromXml(xml.findElements('cbc:PostalZone').singleOrNull),
      countrySubentity: CountrySubentity.fromXml(xml.findElements('cbc:CountrySubentity').singleOrNull),
      countrySubentityCode: CountrySubentityCode.fromXml(xml.findElements('cbc:CountrySubentityCode').singleOrNull),
      region: Region.fromXml(xml.findElements('cbc:Region').singleOrNull),
      district: District.fromXml(xml.findElements('cbc:District').singleOrNull),
      timezoneOffset: TimezoneOffset.fromXml(xml.findElements('cbc:TimezoneOffset').singleOrNull),
      addressLine: xml.findElements('cac:AddressLine').map((XmlElement e) => AddressLine.fromXml(e)!).toList(),
      country: Country.fromXml(xml.findElements('cac:Country').singleOrNull),
      locationCoordinate: xml.findElements('cac:LocationCoordinate').map((XmlElement e) => LocationCoordinate.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'Address',
        'cac',
      ),
    );
  }
}

