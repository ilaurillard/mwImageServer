import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/Party.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/ServiceTypeCode.dart';
import '../cbc/ServiceType.dart';
import '../cac/SellerContact.dart';

// A class to describe a party contracting to provide services, such as transportation, finance, etc.
class ServiceProviderParty {


  // The party providing the service.
  final Party party;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this service provider.
  final ID? iD;

  // The type of service provided, expressed as a code.
  final ServiceTypeCode? serviceTypeCode;

  // The type of service provided, expressed as text.
  final List<ServiceType> serviceType;

  // The contact for the service provider.
  final SellerContact? sellerContact;

  ServiceProviderParty ({
    required this.party,
    this.uBLExtensions,
    this.iD,
    this.serviceTypeCode,
    this.serviceType = const [],
    this.sellerContact,
  });

  static ServiceProviderParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ServiceProviderParty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      serviceTypeCode: ServiceTypeCode.fromJson(json['serviceTypeCode'] as Map<String, dynamic>?),
      serviceType: (json['serviceType'] as List? ?? []).map((dynamic d) => ServiceType.fromJson(d as Map<String, dynamic>?)!).toList(),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?)!,
      sellerContact: SellerContact.fromJson(json['sellerContact'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'serviceTypeCode': serviceTypeCode?.toJson(),
      'serviceType': serviceType.map((e) => e.toJson()).toList(),
      'party': party.toJson(),
      'sellerContact': sellerContact?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ServiceProviderParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ServiceProviderParty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      serviceTypeCode: ServiceTypeCode.fromXml(xml.findElements('cbc:ServiceTypeCode').singleOrNull),
      serviceType: xml.findElements('cbc:ServiceType').map((XmlElement e) => ServiceType.fromXml(e)!).toList(),
      party: Party.fromXml(xml.findElements('cac:Party').singleOrNull)!,
      sellerContact: SellerContact.fromXml(xml.findElements('cac:SellerContact').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      serviceTypeCode?.toXml(),
      ...serviceType.map((ServiceType e) => e.toXml()).toList(),
      party.toXml(),
      sellerContact?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ServiceProviderParty',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

