import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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
import '../cac/Storage.dart';
import '../cac/SubsidiaryLocation.dart';
import '../cac/LocationCoordinate.dart';

// A class to describe a location.
class DeliveryLocation {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // The description and requirements of the storage at this location.
  final Storage? storage;

  // A location subsidiary to this location.
  final List<SubsidiaryLocation> subsidiaryLocation;

  // The geographical coordinates of this location.
  final List<LocationCoordinate> locationCoordinate;

  DeliveryLocation ({
    this.uBLExtensions,
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
    this.storage,
    this.subsidiaryLocation = const [],
    this.locationCoordinate = const [],
  });

  static DeliveryLocation? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DeliveryLocation (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      conditions: (json['conditions'] as List? ?? []).map((dynamic d) => Conditions.fromJson(d as Map<String, dynamic>?)!).toList(),
      countrySubentity: CountrySubentity.fromJson(json['countrySubentity'] as Map<String, dynamic>?),
      countrySubentityCode: CountrySubentityCode.fromJson(json['countrySubentityCode'] as Map<String, dynamic>?),
      locationTypeCode: LocationTypeCode.fromJson(json['locationTypeCode'] as Map<String, dynamic>?),
      informationURI: InformationURI.fromJson(json['informationURI'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      validityPeriod: (json['validityPeriod'] as List? ?? []).map((dynamic d) => ValidityPeriod.fromJson(d as Map<String, dynamic>?)!).toList(),
      address: Address.fromJson(json['address'] as Map<String, dynamic>?),
      storage: Storage.fromJson(json['storage'] as Map<String, dynamic>?),
      subsidiaryLocation: (json['subsidiaryLocation'] as List? ?? []).map((dynamic d) => SubsidiaryLocation.fromJson(d as Map<String, dynamic>?)!).toList(),
      locationCoordinate: (json['locationCoordinate'] as List? ?? []).map((dynamic d) => LocationCoordinate.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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
      'storage': storage?.toJson(),
      'subsidiaryLocation': subsidiaryLocation.map((e) => e.toJson()).toList(),
      'locationCoordinate': locationCoordinate.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DeliveryLocation? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DeliveryLocation (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      conditions: xml.findElements('cbc:Conditions').map((XmlElement e) => Conditions.fromXml(e)!).toList(),
      countrySubentity: CountrySubentity.fromXml(xml.findElements('cbc:CountrySubentity').singleOrNull),
      countrySubentityCode: CountrySubentityCode.fromXml(xml.findElements('cbc:CountrySubentityCode').singleOrNull),
      locationTypeCode: LocationTypeCode.fromXml(xml.findElements('cbc:LocationTypeCode').singleOrNull),
      informationURI: InformationURI.fromXml(xml.findElements('cbc:InformationURI').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      validityPeriod: xml.findElements('cac:ValidityPeriod').map((XmlElement e) => ValidityPeriod.fromXml(e)!).toList(),
      address: Address.fromXml(xml.findElements('cac:Address').singleOrNull),
      storage: Storage.fromXml(xml.findElements('cac:Storage').singleOrNull),
      subsidiaryLocation: xml.findElements('cac:SubsidiaryLocation').map((XmlElement e) => SubsidiaryLocation.fromXml(e)!).toList(),
      locationCoordinate: xml.findElements('cac:LocationCoordinate').map((XmlElement e) => LocationCoordinate.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      ...description.map((Description e) => e.toXml()).toList(),
      ...conditions.map((Conditions e) => e.toXml()).toList(),
      countrySubentity?.toXml(),
      countrySubentityCode?.toXml(),
      locationTypeCode?.toXml(),
      informationURI?.toXml(),
      name?.toXml(),
      ...validityPeriod.map((ValidityPeriod e) => e.toXml()).toList(),
      address?.toXml(),
      storage?.toXml(),
      ...subsidiaryLocation.map((SubsidiaryLocation e) => e.toXml()).toList(),
      ...locationCoordinate.map((LocationCoordinate e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DeliveryLocation',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

