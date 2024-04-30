import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CoordinateSystemCode.dart';
import '../cbc/LatitudeDegreesMeasure.dart';
import '../cbc/LatitudeMinutesMeasure.dart';
import '../cbc/LatitudeDirectionCode.dart';
import '../cbc/LongitudeDegreesMeasure.dart';
import '../cbc/LongitudeMinutesMeasure.dart';
import '../cbc/LongitudeDirectionCode.dart';
import '../cbc/AltitudeMeasure.dart';

// A class for defining a set of geographical coordinates (apparently misnamed).
class LocationCoordinate {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code signifying the location system used.
  final CoordinateSystemCode? coordinateSystemCode;

  // The degree component of a latitude measured in degrees and minutes.
  final LatitudeDegreesMeasure? latitudeDegreesMeasure;

  // The minutes component of a latitude measured in degrees and minutes (modulo 60).
  final LatitudeMinutesMeasure? latitudeMinutesMeasure;

  // A code signifying the direction of latitude measurement from the equator (north or south).
  final LatitudeDirectionCode? latitudeDirectionCode;

  // The degree component of a longitude measured in degrees and minutes.
  final LongitudeDegreesMeasure? longitudeDegreesMeasure;

  // The minutes component of a longitude measured in degrees and minutes (modulo 60).
  final LongitudeMinutesMeasure? longitudeMinutesMeasure;

  // A code signifying the direction of longitude measurement from the prime meridian (east or west).
  final LongitudeDirectionCode? longitudeDirectionCode;

  // The altitude of the location.
  final AltitudeMeasure? altitudeMeasure;

  LocationCoordinate ({
    this.uBLExtensions,
    this.coordinateSystemCode,
    this.latitudeDegreesMeasure,
    this.latitudeMinutesMeasure,
    this.latitudeDirectionCode,
    this.longitudeDegreesMeasure,
    this.longitudeMinutesMeasure,
    this.longitudeDirectionCode,
    this.altitudeMeasure,
  });

  static LocationCoordinate? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LocationCoordinate (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      coordinateSystemCode: CoordinateSystemCode.fromJson(json['coordinateSystemCode'] as Map<String, dynamic>?),
      latitudeDegreesMeasure: LatitudeDegreesMeasure.fromJson(json['latitudeDegreesMeasure'] as Map<String, dynamic>?),
      latitudeMinutesMeasure: LatitudeMinutesMeasure.fromJson(json['latitudeMinutesMeasure'] as Map<String, dynamic>?),
      latitudeDirectionCode: LatitudeDirectionCode.fromJson(json['latitudeDirectionCode'] as Map<String, dynamic>?),
      longitudeDegreesMeasure: LongitudeDegreesMeasure.fromJson(json['longitudeDegreesMeasure'] as Map<String, dynamic>?),
      longitudeMinutesMeasure: LongitudeMinutesMeasure.fromJson(json['longitudeMinutesMeasure'] as Map<String, dynamic>?),
      longitudeDirectionCode: LongitudeDirectionCode.fromJson(json['longitudeDirectionCode'] as Map<String, dynamic>?),
      altitudeMeasure: AltitudeMeasure.fromJson(json['altitudeMeasure'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'coordinateSystemCode': coordinateSystemCode?.toJson(),
      'latitudeDegreesMeasure': latitudeDegreesMeasure?.toJson(),
      'latitudeMinutesMeasure': latitudeMinutesMeasure?.toJson(),
      'latitudeDirectionCode': latitudeDirectionCode?.toJson(),
      'longitudeDegreesMeasure': longitudeDegreesMeasure?.toJson(),
      'longitudeMinutesMeasure': longitudeMinutesMeasure?.toJson(),
      'longitudeDirectionCode': longitudeDirectionCode?.toJson(),
      'altitudeMeasure': altitudeMeasure?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LocationCoordinate? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return LocationCoordinate (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      coordinateSystemCode: CoordinateSystemCode.fromXml(xml.findElements('cbc:CoordinateSystemCode').singleOrNull),
      latitudeDegreesMeasure: LatitudeDegreesMeasure.fromXml(xml.findElements('cbc:LatitudeDegreesMeasure').singleOrNull),
      latitudeMinutesMeasure: LatitudeMinutesMeasure.fromXml(xml.findElements('cbc:LatitudeMinutesMeasure').singleOrNull),
      latitudeDirectionCode: LatitudeDirectionCode.fromXml(xml.findElements('cbc:LatitudeDirectionCode').singleOrNull),
      longitudeDegreesMeasure: LongitudeDegreesMeasure.fromXml(xml.findElements('cbc:LongitudeDegreesMeasure').singleOrNull),
      longitudeMinutesMeasure: LongitudeMinutesMeasure.fromXml(xml.findElements('cbc:LongitudeMinutesMeasure').singleOrNull),
      longitudeDirectionCode: LongitudeDirectionCode.fromXml(xml.findElements('cbc:LongitudeDirectionCode').singleOrNull),
      altitudeMeasure: AltitudeMeasure.fromXml(xml.findElements('cbc:AltitudeMeasure').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      coordinateSystemCode?.toXml(),
      latitudeDegreesMeasure?.toXml(),
      latitudeMinutesMeasure?.toXml(),
      latitudeDirectionCode?.toXml(),
      longitudeDegreesMeasure?.toXml(),
      longitudeMinutesMeasure?.toXml(),
      longitudeDirectionCode?.toXml(),
      altitudeMeasure?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'LocationCoordinate',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

