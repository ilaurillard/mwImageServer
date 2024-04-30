import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CustomerAssignedAccountID.dart';
import '../cbc/AdditionalAccountID.dart';
import '../cbc/DataSendingCapability.dart';
import '../cac/Party.dart';
import '../cac/DespatchContact.dart';
import '../cac/AccountingContact.dart';
import '../cac/SellerContact.dart';

// A class to describe a supplier party.
class AccountingSupplierParty {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this supplier party, assigned by the customer.
  final CustomerAssignedAccountID? customerAssignedAccountID;

  // An additional identifier for this supplier party.
  final List<AdditionalAccountID> additionalAccountID;

  // Text describing the supplier's ability to send invoice data via a purchase card provider (e.g., VISA, MasterCard, American Express).
  final DataSendingCapability? dataSendingCapability;

  // The supplier party itself.
  final Party? party;

  // A contact at this supplier party for despatches (pickups).
  final DespatchContact? despatchContact;

  // A contact at this supplier party for accounting.
  final AccountingContact? accountingContact;

  // The primary contact for this supplier party.
  final SellerContact? sellerContact;

  AccountingSupplierParty ({
    this.uBLExtensions,
    this.customerAssignedAccountID,
    this.additionalAccountID = const [],
    this.dataSendingCapability,
    this.party,
    this.despatchContact,
    this.accountingContact,
    this.sellerContact,
  });

  static AccountingSupplierParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AccountingSupplierParty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      customerAssignedAccountID: CustomerAssignedAccountID.fromJson(json['customerAssignedAccountID'] as Map<String, dynamic>?),
      additionalAccountID: (json['additionalAccountID'] as List? ?? []).map((dynamic d) => AdditionalAccountID.fromJson(d as Map<String, dynamic>?)!).toList(),
      dataSendingCapability: DataSendingCapability.fromJson(json['dataSendingCapability'] as Map<String, dynamic>?),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?),
      despatchContact: DespatchContact.fromJson(json['despatchContact'] as Map<String, dynamic>?),
      accountingContact: AccountingContact.fromJson(json['accountingContact'] as Map<String, dynamic>?),
      sellerContact: SellerContact.fromJson(json['sellerContact'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'customerAssignedAccountID': customerAssignedAccountID?.toJson(),
      'additionalAccountID': additionalAccountID.map((e) => e.toJson()).toList(),
      'dataSendingCapability': dataSendingCapability?.toJson(),
      'party': party?.toJson(),
      'despatchContact': despatchContact?.toJson(),
      'accountingContact': accountingContact?.toJson(),
      'sellerContact': sellerContact?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AccountingSupplierParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AccountingSupplierParty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      customerAssignedAccountID: CustomerAssignedAccountID.fromXml(xml.findElements('cbc:CustomerAssignedAccountID').singleOrNull),
      additionalAccountID: xml.findElements('cbc:AdditionalAccountID').map((XmlElement e) => AdditionalAccountID.fromXml(e)!).toList(),
      dataSendingCapability: DataSendingCapability.fromXml(xml.findElements('cbc:DataSendingCapability').singleOrNull),
      party: Party.fromXml(xml.findElements('cac:Party').singleOrNull),
      despatchContact: DespatchContact.fromXml(xml.findElements('cac:DespatchContact').singleOrNull),
      accountingContact: AccountingContact.fromXml(xml.findElements('cac:AccountingContact').singleOrNull),
      sellerContact: SellerContact.fromXml(xml.findElements('cac:SellerContact').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      customerAssignedAccountID?.toXml(),
      ...additionalAccountID.map((AdditionalAccountID e) => e.toXml()).toList(),
      dataSendingCapability?.toXml(),
      party?.toXml(),
      despatchContact?.toXml(),
      accountingContact?.toXml(),
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
        'AccountingSupplierParty',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

