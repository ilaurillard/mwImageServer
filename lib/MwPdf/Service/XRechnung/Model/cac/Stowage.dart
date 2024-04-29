import '../cac/LocationID.dart';
import '../cac/Location.dart';
import '../cac/MeasurementDimension.dart';

// A class to describe a location on board a means of transport where specified goods or transport equipment have been stowed or are to be stowed.
class Stowage {


  // An identifier for the location.
  final LocationID? locationID;

  // Text describing the location.
  final List<Location> location;

  // A measurable dimension (length, mass, weight, or volume) of this stowage.
  final List<MeasurementDimension> measurementDimension;

  Stowage ({
    this.locationID,
    this.location = const [],
    this.measurementDimension = const [],
  });
}

