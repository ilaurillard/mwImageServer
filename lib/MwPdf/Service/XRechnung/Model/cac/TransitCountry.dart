import '../cac/IdentificationCode.dart';
import '../cac/Name.dart';

// A class to describe a country.
class TransitCountry {


  // A code signifying this country.
  final IdentificationCode? identificationCode;

  // The name of this country.
  final Name? name;

  TransitCountry ({
    this.identificationCode,
    this.name,
  });
}

