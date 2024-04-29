import '../cac/ID.dart';
import '../cac/IssuerParty.dart';

// A class describing identifiers or references relating to customs procedures.
class CustomsDeclaration {


  // An identifier associated with customs related procedures.
  final ID iD;

  // Describes the party issuing the customs declaration.
  final IssuerParty? issuerParty;

  CustomsDeclaration ({
    required this.iD,
    this.issuerParty,
  });
}

