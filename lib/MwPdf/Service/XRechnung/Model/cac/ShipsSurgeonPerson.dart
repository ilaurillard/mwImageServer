import '../cac/ID.dart';
import '../cac/FirstName.dart';
import '../cac/FamilyName.dart';
import '../cac/Title.dart';
import '../cac/MiddleName.dart';
import '../cac/OtherName.dart';
import '../cac/NameSuffix.dart';
import '../cac/JobTitle.dart';
import '../cac/NationalityID.dart';
import '../cac/GenderCode.dart';
import '../cac/BirthDate.dart';
import '../cac/BirthplaceName.dart';
import '../cac/OrganizationDepartment.dart';
import '../cac/Contact.dart';
import '../cac/FinancialAccount.dart';
import '../cac/IdentityDocumentReference.dart';
import '../cac/ResidenceAddress.dart';

// A class to describe a person.
class ShipsSurgeonPerson {


  // An identifier for this person.
  final ID? iD;

  // This person's given name.
  final FirstName? firstName;

  // This person's family name.
  final FamilyName? familyName;

  // This person's title of address (e.g., Mr, Ms, Dr, Sir).
  final Title? title;

  // This person's middle name(s) or initials.
  final MiddleName? middleName;

  // This person's second family name.
  final OtherName? otherName;

  // A suffix to this person's name (e.g., PhD, OBE, Jr).
  final NameSuffix? nameSuffix;

  // This person's job title (for a particular role) within an organization.
  final JobTitle? jobTitle;

  // An identifier for this person's nationality.
  final NationalityID? nationalityID;

  // A code (e.g., ISO 5218) signifying the gender of this person.
  final GenderCode? genderCode;

  // This person's date of birth.
  final BirthDate? birthDate;

  // The name of the place where this person was born, expressed as text.
  final BirthplaceName? birthplaceName;

  // The department or subdivision of an organization that this person belongs to (in a particular role).
  final OrganizationDepartment? organizationDepartment;

  // Contact information for this person.
  final Contact? contact;

  // The financial account associated with this person.
  final FinancialAccount? financialAccount;

  // A reference to a document that can precisely identify this person (e.g., a driver's license).
  final List<IdentityDocumentReference> identityDocumentReference;

  // This person's address of residence.
  final ResidenceAddress? residenceAddress;

  ShipsSurgeonPerson ({
    this.iD,
    this.firstName,
    this.familyName,
    this.title,
    this.middleName,
    this.otherName,
    this.nameSuffix,
    this.jobTitle,
    this.nationalityID,
    this.genderCode,
    this.birthDate,
    this.birthplaceName,
    this.organizationDepartment,
    this.contact,
    this.financialAccount,
    this.identityDocumentReference = const [],
    this.residenceAddress,
  });
}

