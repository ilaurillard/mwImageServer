import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/CorporateRegistrationTypeCode.dart';
import '../cac/JurisdictionRegionAddress.dart';

// A class to describe a scheme for corporate registration.
class CorporateRegistrationScheme {


  // An identifier for this registration scheme.
  final ID? iD;

  // The name of this registration scheme.
  final Name? name;

  // A code signifying the type of this registration scheme.
  final CorporateRegistrationTypeCode? corporateRegistrationTypeCode;

  // A geographic area in which this registration scheme applies.
  final List<JurisdictionRegionAddress> jurisdictionRegionAddress;

  CorporateRegistrationScheme ({
    this.iD,
    this.name,
    this.corporateRegistrationTypeCode,
    this.jurisdictionRegionAddress = const [],
  });
}

