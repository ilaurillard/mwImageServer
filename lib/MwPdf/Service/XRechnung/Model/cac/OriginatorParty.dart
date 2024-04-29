import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/MarkCareIndicator.dart';
import '../cbc/MarkAttentionIndicator.dart';
import '../cbc/WebsiteURI.dart';
import '../cbc/LogoReferenceID.dart';
import '../cbc/EndpointID.dart';
import '../cbc/IndustryClassificationCode.dart';
import '../cac/PartyIdentification.dart';
import '../cac/PartyName.dart';
import '../cac/Language.dart';
import '../cac/PostalAddress.dart';
import '../cac/PhysicalLocation.dart';
import '../cac/PartyTaxScheme.dart';
import '../cac/PartyLegalEntity.dart';
import '../cac/Contact.dart';
import '../cac/Person.dart';
import '../cac/AgentParty.dart';
import '../cac/ServiceProviderParty.dart';
import '../cac/PowerOfAttorney.dart';
import '../cac/FinancialAccount.dart';

// A class to describe an organization, sub-organization, or individual fulfilling a role in a business process.
class OriginatorParty {


  // An indicator that this party is "care of" (c/o) (true) or not (false).
  final MarkCareIndicator? markCareIndicator;

  // An indicator that this party is "for the attention of" (FAO) (true) or not (false).
  final MarkAttentionIndicator? markAttentionIndicator;

  // The Uniform Resource Identifier (URI) that identifies this party's web site; i.e., the web site's Uniform Resource Locator (URL).
  final WebsiteURI? websiteURI;

  // An identifier for this party's logo.
  final LogoReferenceID? logoReferenceID;

  // An identifier for the end point of the routing service (e.g., EAN Location Number, GLN).
  final EndpointID? endpointID;

  // This party's Industry Classification Code.
  final IndustryClassificationCode? industryClassificationCode;

  // An identifier for this party.
  final List<PartyIdentification> partyIdentification;

  // A name for this party.
  final List<PartyName> partyName;

  // The language associated with this party.
  final Language? language;

  // The party's postal address.
  final PostalAddress? postalAddress;

  // The physical location of this party.
  final PhysicalLocation? physicalLocation;

  // A tax scheme applying to this party.
  final List<PartyTaxScheme> partyTaxScheme;

  // A description of this party as a legal entity.
  final List<PartyLegalEntity> partyLegalEntity;

  // The primary contact for this party.
  final Contact? contact;

  // A person associated with this party.
  final List<Person> person;

  // A party who acts as an agent for this party.
  final AgentParty? agentParty;

  // A party providing a service to this party.
  final List<ServiceProviderParty> serviceProviderParty;

  // A power of attorney associated with this party.
  final List<PowerOfAttorney> powerOfAttorney;

  // The financial account associated with this party.
  final FinancialAccount? financialAccount;

  OriginatorParty ({
    this.markCareIndicator,
    this.markAttentionIndicator,
    this.websiteURI,
    this.logoReferenceID,
    this.endpointID,
    this.industryClassificationCode,
    this.partyIdentification = const [],
    this.partyName = const [],
    this.language,
    this.postalAddress,
    this.physicalLocation,
    this.partyTaxScheme = const [],
    this.partyLegalEntity = const [],
    this.contact,
    this.person = const [],
    this.agentParty,
    this.serviceProviderParty = const [],
    this.powerOfAttorney = const [],
    this.financialAccount,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'markCareIndicator': markCareIndicator?.toJson(),
     'markAttentionIndicator': markAttentionIndicator?.toJson(),
     'websiteURI': websiteURI?.toJson(),
     'logoReferenceID': logoReferenceID?.toJson(),
     'endpointID': endpointID?.toJson(),
     'industryClassificationCode': industryClassificationCode?.toJson(),
     'partyIdentification': partyIdentification.map((e) => e.toJson()).toList(),
     'partyName': partyName.map((e) => e.toJson()).toList(),
     'language': language?.toJson(),
     'postalAddress': postalAddress?.toJson(),
     'physicalLocation': physicalLocation?.toJson(),
     'partyTaxScheme': partyTaxScheme.map((e) => e.toJson()).toList(),
     'partyLegalEntity': partyLegalEntity.map((e) => e.toJson()).toList(),
     'contact': contact?.toJson(),
     'person': person.map((e) => e.toJson()).toList(),
     'agentParty': agentParty?.toJson(),
     'serviceProviderParty': serviceProviderParty.map((e) => e.toJson()).toList(),
     'powerOfAttorney': powerOfAttorney.map((e) => e.toJson()).toList(),
     'financialAccount': financialAccount?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  OriginatorParty fromJson(Map<String, dynamic> json) {
    return OriginatorParty (
    );
  }

}

