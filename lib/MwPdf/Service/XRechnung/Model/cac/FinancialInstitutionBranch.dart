import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'financialInstitution': financialInstitution?.toJson(),
      'address': address?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FinancialInstitutionBranch? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FinancialInstitutionBranch (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      financialInstitution: FinancialInstitution.fromJson(json['financialInstitution'] as Map<String, dynamic>?),
      address: Address.fromJson(json['address'] as Map<String, dynamic>?),
    );
  }

  static FinancialInstitutionBranch? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return FinancialInstitutionBranch (
      iD: null,
      name: null,
      financialInstitution: null,
      address: null,
    );
  }

}

