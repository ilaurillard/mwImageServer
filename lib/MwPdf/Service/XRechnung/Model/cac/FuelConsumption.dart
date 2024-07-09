// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/FuelTypeCode.dart';
import '../cbc/FuelType.dart';
import '../cbc/FuelConsumptionMeasure.dart';
import '../cac/AdditionalFuelProperty.dart';
import '../cac/FuelMetering.dart';
import '../cac/EnvironmentalEmission.dart';
import '../cac/FuelProviderParty.dart';

// A class to describe fuel consumption.
class FuelConsumption {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this fuel consumption.
  final ID? iD;

  // The type of fuel, expressed as a code.
  final FuelTypeCode? fuelTypeCode;

  // The type of fuel, expressed as text.
  final List<FuelType> fuelType;

  // The measure of this fuel consumption.
  final FuelConsumptionMeasure? fuelConsumptionMeasure;

  // One or more additional properties of the fuel being consumed.
  final List<AdditionalFuelProperty> additionalFuelProperty;

  // One or more meters of the fuel being consumed.
  final List<FuelMetering> fuelMetering;

  // One or more environmental emissions of the fuel being measured.
  final List<EnvironmentalEmission> environmentalEmission;

  // The party providing the fuel.
  final FuelProviderParty? fuelProviderParty;

  FuelConsumption ({
    this.uBLExtensions,
    this.iD,
    this.fuelTypeCode,
    this.fuelType = const [],
    this.fuelConsumptionMeasure,
    this.additionalFuelProperty = const [],
    this.fuelMetering = const [],
    this.environmentalEmission = const [],
    this.fuelProviderParty,
  });

  static FuelConsumption? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FuelConsumption (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      fuelTypeCode: FuelTypeCode.fromJson(json['fuelTypeCode'] as Map<String, dynamic>?),
      fuelType: (json['fuelType'] as List? ?? []).map((dynamic d) => FuelType.fromJson(d as Map<String, dynamic>?)!).toList(),
      fuelConsumptionMeasure: FuelConsumptionMeasure.fromJson(json['fuelConsumptionMeasure'] as Map<String, dynamic>?),
      additionalFuelProperty: (json['additionalFuelProperty'] as List? ?? []).map((dynamic d) => AdditionalFuelProperty.fromJson(d as Map<String, dynamic>?)!).toList(),
      fuelMetering: (json['fuelMetering'] as List? ?? []).map((dynamic d) => FuelMetering.fromJson(d as Map<String, dynamic>?)!).toList(),
      environmentalEmission: (json['environmentalEmission'] as List? ?? []).map((dynamic d) => EnvironmentalEmission.fromJson(d as Map<String, dynamic>?)!).toList(),
      fuelProviderParty: FuelProviderParty.fromJson(json['fuelProviderParty'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'fuelTypeCode': fuelTypeCode?.toJson(),
      'fuelType': fuelType.map((e) => e.toJson()).toList(),
      'fuelConsumptionMeasure': fuelConsumptionMeasure?.toJson(),
      'additionalFuelProperty': additionalFuelProperty.map((e) => e.toJson()).toList(),
      'fuelMetering': fuelMetering.map((e) => e.toJson()).toList(),
      'environmentalEmission': environmentalEmission.map((e) => e.toJson()).toList(),
      'fuelProviderParty': fuelProviderParty?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FuelConsumption? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return FuelConsumption (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      fuelTypeCode: FuelTypeCode.fromXml(xml.findElements('cbc:FuelTypeCode').singleOrNull),
      fuelType: xml.findElements('cbc:FuelType').map((XmlElement e) => FuelType.fromXml(e)!).toList(),
      fuelConsumptionMeasure: FuelConsumptionMeasure.fromXml(xml.findElements('cbc:FuelConsumptionMeasure').singleOrNull),
      additionalFuelProperty: xml.findElements('cac:AdditionalFuelProperty').map((XmlElement e) => AdditionalFuelProperty.fromXml(e)!).toList(),
      fuelMetering: xml.findElements('cac:FuelMetering').map((XmlElement e) => FuelMetering.fromXml(e)!).toList(),
      environmentalEmission: xml.findElements('cac:EnvironmentalEmission').map((XmlElement e) => EnvironmentalEmission.fromXml(e)!).toList(),
      fuelProviderParty: FuelProviderParty.fromXml(xml.findElements('cac:FuelProviderParty').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      fuelTypeCode?.toXml(),
      ...fuelType.map((FuelType e) => e.toXml()),
      fuelConsumptionMeasure?.toXml(),
      ...additionalFuelProperty.map((AdditionalFuelProperty e) => e.toXml()),
      ...fuelMetering.map((FuelMetering e) => e.toXml()),
      ...environmentalEmission.map((EnvironmentalEmission e) => e.toXml()),
      fuelProviderParty?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'FuelConsumption',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

