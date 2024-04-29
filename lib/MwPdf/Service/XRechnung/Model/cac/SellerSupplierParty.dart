import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/CustomerAssignedAccountID.dart';
import '../cbc/AdditionalAccountID.dart';
import '../cbc/DataSendingCapability.dart';
import '../cac/Party.dart';
import '../cac/DespatchContact.dart';
import '../cac/AccountingContact.dart';
import '../cac/SellerContact.dart';

// A class to describe a supplier party.
class SellerSupplierParty {


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

  SellerSupplierParty ({
    this.customerAssignedAccountID,
    this.additionalAccountID = const [],
    this.dataSendingCapability,
    this.party,
    this.despatchContact,
    this.accountingContact,
    this.sellerContact,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

  static SellerSupplierParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SellerSupplierParty (
      customerAssignedAccountID: CustomerAssignedAccountID.fromJson(json['customerAssignedAccountID'] as Map<String, dynamic>?),
      additionalAccountID: (json['additionalAccountID'] as List? ?? []).map((dynamic d) => AdditionalAccountID.fromJson(d as Map<String, dynamic>?)!).toList(),
      dataSendingCapability: DataSendingCapability.fromJson(json['dataSendingCapability'] as Map<String, dynamic>?),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?),
      despatchContact: DespatchContact.fromJson(json['despatchContact'] as Map<String, dynamic>?),
      accountingContact: AccountingContact.fromJson(json['accountingContact'] as Map<String, dynamic>?),
      sellerContact: SellerContact.fromJson(json['sellerContact'] as Map<String, dynamic>?),
    );
  }

  static SellerSupplierParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return SellerSupplierParty (
      customerAssignedAccountID: null,
      additionalAccountID: null,
      dataSendingCapability: null,
      party: null,
      despatchContact: null,
      accountingContact: null,
      sellerContact: null,
    );
  }

}

