import '../cac/IdentificationCode.dart';
import '../cac/Name.dart';

// A class to describe a country.
class OriginCountry {


  // A code signifying this country.
  final IdentificationCode? identificationCode;

  // The name of this country.
  final Name? name;

  OriginCountry ({
    this.identificationCode,
    this.name,
  });
}

