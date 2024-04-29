import '../cac/ID.dart';
import '../cac/Name.dart';
import '../cac/FinancialInstitution.dart';
import '../cac/Address.dart';

// A class to describe a branch or a division of an organization.
class FinancialInstitutionBranch {


  // An identifier for this branch or division of an organization.
  final ID? iD;

  // The name of this branch or division of an organization.
  final Name? name;

  // The financial institution that this branch belongs to (if applicable).
  final FinancialInstitution? financialInstitution;

  // The address of this branch or division.
  final Address? address;

  FinancialInstitutionBranch ({
    this.iD,
    this.name,
    this.financialInstitution,
    this.address,
  });
}

