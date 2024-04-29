import '../cac/IdentificationCode.dart';
import '../cac/Name.dart';

// A class to describe a country.
class Country {


  // A code signifying this country.
  final IdentificationCode? identificationCode;

  // The name of this country.
  final Name? name;

  Country ({
    this.identificationCode,
    this.name,
  });
}

