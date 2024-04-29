import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cac/Address.dart';

// A class to describe a financial institution.
class FinancialInstitution {


  // An identifier for this financial institution. It is recommended that the ISO 9362 Bank Identification Code (BIC) be used as the ID.
  final ID? iD;

  // The name of this financial institution.
  final Name? name;

  // The address of this financial institution.
  final Address? address;

  FinancialInstitution ({
    this.iD,
    this.name,
    this.address,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'address': address?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FinancialInstitution? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FinancialInstitution (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      address: Address.fromJson(json['address'] as Map<String, dynamic>?),
    );
  }

  static FinancialInstitution? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return FinancialInstitution (
      iD: null,
      name: null,
      address: null,
    );
  }

}

