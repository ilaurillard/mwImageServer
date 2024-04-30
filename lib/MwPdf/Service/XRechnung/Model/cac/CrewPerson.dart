import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/FirstName.dart';
import '../cbc/FamilyName.dart';
import '../cbc/Title.dart';
import '../cbc/MiddleName.dart';
import '../cbc/OtherName.dart';
import '../cbc/NameSuffix.dart';
import '../cbc/JobTitle.dart';
import '../cbc/NationalityID.dart';
import '../cbc/GenderCode.dart';
import '../cbc/BirthDate.dart';
import '../cbc/BirthplaceName.dart';
import '../cbc/OrganizationDepartment.dart';
import '../cbc/RoleCode.dart';
import '../cac/BirthplaceLocation.dart';
import '../cac/CitizenshipCountry.dart';
import '../cac/Contact.dart';
import '../cac/FinancialAccount.dart';
import '../cac/IdentityDocumentReference.dart';
import '../cac/ResidenceAddress.dart';

// A class to describe a person.
class CrewPerson {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // A code stating the person's role
  final RoleCode? roleCode;

  // The location where this person was born.
  final BirthplaceLocation? birthplaceLocation;

  // The country of the person's citizenship.
  final CitizenshipCountry? citizenshipCountry;

  // Contact information for this person.
  final Contact? contact;

  // The financial account associated with this person.
  final FinancialAccount? financialAccount;

  // A reference to a document that can precisely identify this person (e.g., a driver's license).
  final List<IdentityDocumentReference> identityDocumentReference;

  // This person's address of residence.
  final ResidenceAddress? residenceAddress;

  CrewPerson ({
    this.uBLExtensions,
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
    this.roleCode,
    this.birthplaceLocation,
    this.citizenshipCountry,
    this.contact,
    this.financialAccount,
    this.identityDocumentReference = const [],
    this.residenceAddress,
  });

  static CrewPerson? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CrewPerson (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      firstName: FirstName.fromJson(json['firstName'] as Map<String, dynamic>?),
      familyName: FamilyName.fromJson(json['familyName'] as Map<String, dynamic>?),
      title: Title.fromJson(json['title'] as Map<String, dynamic>?),
      middleName: MiddleName.fromJson(json['middleName'] as Map<String, dynamic>?),
      otherName: OtherName.fromJson(json['otherName'] as Map<String, dynamic>?),
      nameSuffix: NameSuffix.fromJson(json['nameSuffix'] as Map<String, dynamic>?),
      jobTitle: JobTitle.fromJson(json['jobTitle'] as Map<String, dynamic>?),
      nationalityID: NationalityID.fromJson(json['nationalityID'] as Map<String, dynamic>?),
      genderCode: GenderCode.fromJson(json['genderCode'] as Map<String, dynamic>?),
      birthDate: BirthDate.fromJson(json['birthDate'] as Map<String, dynamic>?),
      birthplaceName: BirthplaceName.fromJson(json['birthplaceName'] as Map<String, dynamic>?),
      organizationDepartment: OrganizationDepartment.fromJson(json['organizationDepartment'] as Map<String, dynamic>?),
      roleCode: RoleCode.fromJson(json['roleCode'] as Map<String, dynamic>?),
      birthplaceLocation: BirthplaceLocation.fromJson(json['birthplaceLocation'] as Map<String, dynamic>?),
      citizenshipCountry: CitizenshipCountry.fromJson(json['citizenshipCountry'] as Map<String, dynamic>?),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>?),
      financialAccount: FinancialAccount.fromJson(json['financialAccount'] as Map<String, dynamic>?),
      identityDocumentReference: (json['identityDocumentReference'] as List? ?? []).map((dynamic d) => IdentityDocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
      residenceAddress: ResidenceAddress.fromJson(json['residenceAddress'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'firstName': firstName?.toJson(),
      'familyName': familyName?.toJson(),
      'title': title?.toJson(),
      'middleName': middleName?.toJson(),
      'otherName': otherName?.toJson(),
      'nameSuffix': nameSuffix?.toJson(),
      'jobTitle': jobTitle?.toJson(),
      'nationalityID': nationalityID?.toJson(),
      'genderCode': genderCode?.toJson(),
      'birthDate': birthDate?.toJson(),
      'birthplaceName': birthplaceName?.toJson(),
      'organizationDepartment': organizationDepartment?.toJson(),
      'roleCode': roleCode?.toJson(),
      'birthplaceLocation': birthplaceLocation?.toJson(),
      'citizenshipCountry': citizenshipCountry?.toJson(),
      'contact': contact?.toJson(),
      'financialAccount': financialAccount?.toJson(),
      'identityDocumentReference': identityDocumentReference.map((e) => e.toJson()).toList(),
      'residenceAddress': residenceAddress?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CrewPerson? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CrewPerson (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      firstName: FirstName.fromXml(xml.findElements('cbc:FirstName').singleOrNull),
      familyName: FamilyName.fromXml(xml.findElements('cbc:FamilyName').singleOrNull),
      title: Title.fromXml(xml.findElements('cbc:Title').singleOrNull),
      middleName: MiddleName.fromXml(xml.findElements('cbc:MiddleName').singleOrNull),
      otherName: OtherName.fromXml(xml.findElements('cbc:OtherName').singleOrNull),
      nameSuffix: NameSuffix.fromXml(xml.findElements('cbc:NameSuffix').singleOrNull),
      jobTitle: JobTitle.fromXml(xml.findElements('cbc:JobTitle').singleOrNull),
      nationalityID: NationalityID.fromXml(xml.findElements('cbc:NationalityID').singleOrNull),
      genderCode: GenderCode.fromXml(xml.findElements('cbc:GenderCode').singleOrNull),
      birthDate: BirthDate.fromXml(xml.findElements('cbc:BirthDate').singleOrNull),
      birthplaceName: BirthplaceName.fromXml(xml.findElements('cbc:BirthplaceName').singleOrNull),
      organizationDepartment: OrganizationDepartment.fromXml(xml.findElements('cbc:OrganizationDepartment').singleOrNull),
      roleCode: RoleCode.fromXml(xml.findElements('cbc:RoleCode').singleOrNull),
      birthplaceLocation: BirthplaceLocation.fromXml(xml.findElements('cac:BirthplaceLocation').singleOrNull),
      citizenshipCountry: CitizenshipCountry.fromXml(xml.findElements('cac:CitizenshipCountry').singleOrNull),
      contact: Contact.fromXml(xml.findElements('cac:Contact').singleOrNull),
      financialAccount: FinancialAccount.fromXml(xml.findElements('cac:FinancialAccount').singleOrNull),
      identityDocumentReference: xml.findElements('cac:IdentityDocumentReference').map((XmlElement e) => IdentityDocumentReference.fromXml(e)!).toList(),
      residenceAddress: ResidenceAddress.fromXml(xml.findElements('cac:ResidenceAddress').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      firstName?.toXml(),
      familyName?.toXml(),
      title?.toXml(),
      middleName?.toXml(),
      otherName?.toXml(),
      nameSuffix?.toXml(),
      jobTitle?.toXml(),
      nationalityID?.toXml(),
      genderCode?.toXml(),
      birthDate?.toXml(),
      birthplaceName?.toXml(),
      organizationDepartment?.toXml(),
      roleCode?.toXml(),
      birthplaceLocation?.toXml(),
      citizenshipCountry?.toXml(),
      contact?.toXml(),
      financialAccount?.toXml(),
      ...identityDocumentReference.map((IdentityDocumentReference e) => e.toXml()).toList(),
      residenceAddress?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'CrewPerson',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

