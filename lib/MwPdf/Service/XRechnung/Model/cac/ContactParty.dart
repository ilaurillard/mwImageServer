import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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
import '../cac/PartyAuthorization.dart';
import '../cac/FinancialAccount.dart';
import '../cac/AdditionalWebSite.dart';
import '../cac/SocialMediaProfile.dart';

// A class to describe an organization, sub-organization, or individual fulfilling a role in a business process.
class ContactParty {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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

  // An authorization issued to this party
  final List<PartyAuthorization> partyAuthorization;

  // The financial account associated with this party.
  final FinancialAccount? financialAccount;

  // An additional web site associated with this party (e.g. a satellite web site).
  final List<AdditionalWebSite> additionalWebSite;

  // A social media profile associated with this party.
  final List<SocialMediaProfile> socialMediaProfile;

  ContactParty ({
    this.uBLExtensions,
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
    this.partyAuthorization = const [],
    this.financialAccount,
    this.additionalWebSite = const [],
    this.socialMediaProfile = const [],
  });

  static ContactParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ContactParty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      markCareIndicator: MarkCareIndicator.fromJson(json['markCareIndicator'] as Map<String, dynamic>?),
      markAttentionIndicator: MarkAttentionIndicator.fromJson(json['markAttentionIndicator'] as Map<String, dynamic>?),
      websiteURI: WebsiteURI.fromJson(json['websiteURI'] as Map<String, dynamic>?),
      logoReferenceID: LogoReferenceID.fromJson(json['logoReferenceID'] as Map<String, dynamic>?),
      endpointID: EndpointID.fromJson(json['endpointID'] as Map<String, dynamic>?),
      industryClassificationCode: IndustryClassificationCode.fromJson(json['industryClassificationCode'] as Map<String, dynamic>?),
      partyIdentification: (json['partyIdentification'] as List? ?? []).map((dynamic d) => PartyIdentification.fromJson(d as Map<String, dynamic>?)!).toList(),
      partyName: (json['partyName'] as List? ?? []).map((dynamic d) => PartyName.fromJson(d as Map<String, dynamic>?)!).toList(),
      language: Language.fromJson(json['language'] as Map<String, dynamic>?),
      postalAddress: PostalAddress.fromJson(json['postalAddress'] as Map<String, dynamic>?),
      physicalLocation: PhysicalLocation.fromJson(json['physicalLocation'] as Map<String, dynamic>?),
      partyTaxScheme: (json['partyTaxScheme'] as List? ?? []).map((dynamic d) => PartyTaxScheme.fromJson(d as Map<String, dynamic>?)!).toList(),
      partyLegalEntity: (json['partyLegalEntity'] as List? ?? []).map((dynamic d) => PartyLegalEntity.fromJson(d as Map<String, dynamic>?)!).toList(),
      contact: Contact.fromJson(json['contact'] as Map<String, dynamic>?),
      person: (json['person'] as List? ?? []).map((dynamic d) => Person.fromJson(d as Map<String, dynamic>?)!).toList(),
      agentParty: AgentParty.fromJson(json['agentParty'] as Map<String, dynamic>?),
      serviceProviderParty: (json['serviceProviderParty'] as List? ?? []).map((dynamic d) => ServiceProviderParty.fromJson(d as Map<String, dynamic>?)!).toList(),
      powerOfAttorney: (json['powerOfAttorney'] as List? ?? []).map((dynamic d) => PowerOfAttorney.fromJson(d as Map<String, dynamic>?)!).toList(),
      partyAuthorization: (json['partyAuthorization'] as List? ?? []).map((dynamic d) => PartyAuthorization.fromJson(d as Map<String, dynamic>?)!).toList(),
      financialAccount: FinancialAccount.fromJson(json['financialAccount'] as Map<String, dynamic>?),
      additionalWebSite: (json['additionalWebSite'] as List? ?? []).map((dynamic d) => AdditionalWebSite.fromJson(d as Map<String, dynamic>?)!).toList(),
      socialMediaProfile: (json['socialMediaProfile'] as List? ?? []).map((dynamic d) => SocialMediaProfile.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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
      'partyAuthorization': partyAuthorization.map((e) => e.toJson()).toList(),
      'financialAccount': financialAccount?.toJson(),
      'additionalWebSite': additionalWebSite.map((e) => e.toJson()).toList(),
      'socialMediaProfile': socialMediaProfile.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ContactParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ContactParty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      markCareIndicator: MarkCareIndicator.fromXml(xml.findElements('cbc:MarkCareIndicator').singleOrNull),
      markAttentionIndicator: MarkAttentionIndicator.fromXml(xml.findElements('cbc:MarkAttentionIndicator').singleOrNull),
      websiteURI: WebsiteURI.fromXml(xml.findElements('cbc:WebsiteURI').singleOrNull),
      logoReferenceID: LogoReferenceID.fromXml(xml.findElements('cbc:LogoReferenceID').singleOrNull),
      endpointID: EndpointID.fromXml(xml.findElements('cbc:EndpointID').singleOrNull),
      industryClassificationCode: IndustryClassificationCode.fromXml(xml.findElements('cbc:IndustryClassificationCode').singleOrNull),
      partyIdentification: xml.findElements('cac:PartyIdentification').map((XmlElement e) => PartyIdentification.fromXml(e)!).toList(),
      partyName: xml.findElements('cac:PartyName').map((XmlElement e) => PartyName.fromXml(e)!).toList(),
      language: Language.fromXml(xml.findElements('cac:Language').singleOrNull),
      postalAddress: PostalAddress.fromXml(xml.findElements('cac:PostalAddress').singleOrNull),
      physicalLocation: PhysicalLocation.fromXml(xml.findElements('cac:PhysicalLocation').singleOrNull),
      partyTaxScheme: xml.findElements('cac:PartyTaxScheme').map((XmlElement e) => PartyTaxScheme.fromXml(e)!).toList(),
      partyLegalEntity: xml.findElements('cac:PartyLegalEntity').map((XmlElement e) => PartyLegalEntity.fromXml(e)!).toList(),
      contact: Contact.fromXml(xml.findElements('cac:Contact').singleOrNull),
      person: xml.findElements('cac:Person').map((XmlElement e) => Person.fromXml(e)!).toList(),
      agentParty: AgentParty.fromXml(xml.findElements('cac:AgentParty').singleOrNull),
      serviceProviderParty: xml.findElements('cac:ServiceProviderParty').map((XmlElement e) => ServiceProviderParty.fromXml(e)!).toList(),
      powerOfAttorney: xml.findElements('cac:PowerOfAttorney').map((XmlElement e) => PowerOfAttorney.fromXml(e)!).toList(),
      partyAuthorization: xml.findElements('cac:PartyAuthorization').map((XmlElement e) => PartyAuthorization.fromXml(e)!).toList(),
      financialAccount: FinancialAccount.fromXml(xml.findElements('cac:FinancialAccount').singleOrNull),
      additionalWebSite: xml.findElements('cac:AdditionalWebSite').map((XmlElement e) => AdditionalWebSite.fromXml(e)!).toList(),
      socialMediaProfile: xml.findElements('cac:SocialMediaProfile').map((XmlElement e) => SocialMediaProfile.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      markCareIndicator?.toXml(),
      markAttentionIndicator?.toXml(),
      websiteURI?.toXml(),
      logoReferenceID?.toXml(),
      endpointID?.toXml(),
      industryClassificationCode?.toXml(),
      ...partyIdentification.map((PartyIdentification e) => e.toXml()).toList(),
      ...partyName.map((PartyName e) => e.toXml()).toList(),
      language?.toXml(),
      postalAddress?.toXml(),
      physicalLocation?.toXml(),
      ...partyTaxScheme.map((PartyTaxScheme e) => e.toXml()).toList(),
      ...partyLegalEntity.map((PartyLegalEntity e) => e.toXml()).toList(),
      contact?.toXml(),
      ...person.map((Person e) => e.toXml()).toList(),
      agentParty?.toXml(),
      ...serviceProviderParty.map((ServiceProviderParty e) => e.toXml()).toList(),
      ...powerOfAttorney.map((PowerOfAttorney e) => e.toXml()).toList(),
      ...partyAuthorization.map((PartyAuthorization e) => e.toXml()).toList(),
      financialAccount?.toXml(),
      ...additionalWebSite.map((AdditionalWebSite e) => e.toXml()).toList(),
      ...socialMediaProfile.map((SocialMediaProfile e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ContactParty',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

