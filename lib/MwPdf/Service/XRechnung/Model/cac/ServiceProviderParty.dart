import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cac/Party.dart';
import '../cbc/ID.dart';
import '../cbc/ServiceTypeCode.dart';
import '../cbc/ServiceType.dart';
import '../cac/SellerContact.dart';

// A class to describe a party contracting to provide services, such as transportation, finance, etc.
class ServiceProviderParty {


  // The party providing the service.
  final Party party;

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
    this.iD,
    this.serviceTypeCode,
    this.serviceType = const [],
    this.sellerContact,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'serviceTypeCode': serviceTypeCode?.toJson(),
      'serviceType': serviceType.map((e) => e.toJson()).toList(),
      'party': party.toJson(),
      'sellerContact': sellerContact?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ServiceProviderParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ServiceProviderParty (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      serviceTypeCode: ServiceTypeCode.fromJson(json['serviceTypeCode'] as Map<String, dynamic>?),
      serviceType: (json['serviceType'] as List? ?? []).map((dynamic d) => ServiceType.fromJson(d as Map<String, dynamic>?)!).toList(),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?)!,
      sellerContact: SellerContact.fromJson(json['sellerContact'] as Map<String, dynamic>?),
    );
  }

  static ServiceProviderParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ServiceProviderParty (
      iD: null,
      serviceTypeCode: null,
      serviceType: null,
      party: null,
      sellerContact: null,
    );
  }

}

