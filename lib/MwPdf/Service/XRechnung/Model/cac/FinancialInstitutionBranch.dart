import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cac/FinancialInstitution.dart';
import '../cac/Address.dart';

// A class to describe a branch or a division of an organization.
class FinancialInstitutionBranch {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this branch or division of an organization.
  final ID? iD;

  // The name of this branch or division of an organization.
  final Name? name;

  // The financial institution that this branch belongs to (if applicable).
  final FinancialInstitution? financialInstitution;

  // The address of this branch or division.
  final Address? address;

  FinancialInstitutionBranch ({
    this.uBLExtensions,
    this.iD,
    this.name,
    this.financialInstitution,
    this.address,
  });

  static FinancialInstitutionBranch? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return FinancialInstitutionBranch (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      financialInstitution: FinancialInstitution.fromJson(json['financialInstitution'] as Map<String, dynamic>?),
      address: Address.fromJson(json['address'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'financialInstitution': financialInstitution?.toJson(),
      'address': address?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static FinancialInstitutionBranch? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return FinancialInstitutionBranch (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      financialInstitution: FinancialInstitution.fromXml(xml.findElements('cac:FinancialInstitution').singleOrNull),
      address: Address.fromXml(xml.findElements('cac:Address').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      name?.toXml(),
      financialInstitution?.toXml(),
      address?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'FinancialInstitutionBranch',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

