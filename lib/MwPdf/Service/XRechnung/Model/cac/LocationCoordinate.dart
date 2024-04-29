import '../cac/CoordinateSystemCode.dart';
import '../cac/LatitudeDegreesMeasure.dart';
import '../cac/LatitudeMinutesMeasure.dart';
import '../cac/LatitudeDirectionCode.dart';
import '../cac/LongitudeDegreesMeasure.dart';
import '../cac/LongitudeMinutesMeasure.dart';
import '../cac/LongitudeDirectionCode.dart';
import '../cac/AltitudeMeasure.dart';

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
}

