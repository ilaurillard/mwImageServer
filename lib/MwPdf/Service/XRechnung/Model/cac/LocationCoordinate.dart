import 'dart:convert';
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
    this.coordinateSystemCode,
    this.latitudeDegreesMeasure,
    this.latitudeMinutesMeasure,
    this.latitudeDirectionCode,
    this.longitudeDegreesMeasure,
    this.longitudeMinutesMeasure,
    this.longitudeDirectionCode,
    this.altitudeMeasure,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

}

