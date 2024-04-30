import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/CustomerAssignedAccountID.dart';
import '../cbc/SupplierAssignedAccountID.dart';
import '../cbc/AdditionalAccountID.dart';
import '../cac/Party.dart';
import '../cac/DeliveryContact.dart';
import '../cac/AccountingContact.dart';
import '../cac/BuyerContact.dart';

// A class to describe a customer party.
class AccountingCustomerParty {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for the customer's account, assigned by the customer itself.
  final CustomerAssignedAccountID? customerAssignedAccountID;

  // An identifier for the customer's account, assigned by the supplier.
  final SupplierAssignedAccountID? supplierAssignedAccountID;

  // An identifier for the customer's account, assigned by a third party.
  final List<AdditionalAccountID> additionalAccountID;

  // The customer party itself.
  final Party? party;

  // A customer contact for deliveries.
  final DeliveryContact? deliveryContact;

  // A customer contact for accounting.
  final AccountingContact? accountingContact;

  // A customer contact for purchasing.
  final BuyerContact? buyerContact;

  AccountingCustomerParty ({
    this.uBLExtensions,
    this.customerAssignedAccountID,
    this.supplierAssignedAccountID,
    this.additionalAccountID = const [],
    this.party,
    this.deliveryContact,
    this.accountingContact,
    this.buyerContact,
  });

  static AccountingCustomerParty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AccountingCustomerParty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      customerAssignedAccountID: CustomerAssignedAccountID.fromJson(json['customerAssignedAccountID'] as Map<String, dynamic>?),
      supplierAssignedAccountID: SupplierAssignedAccountID.fromJson(json['supplierAssignedAccountID'] as Map<String, dynamic>?),
      additionalAccountID: (json['additionalAccountID'] as List? ?? []).map((dynamic d) => AdditionalAccountID.fromJson(d as Map<String, dynamic>?)!).toList(),
      party: Party.fromJson(json['party'] as Map<String, dynamic>?),
      deliveryContact: DeliveryContact.fromJson(json['deliveryContact'] as Map<String, dynamic>?),
      accountingContact: AccountingContact.fromJson(json['accountingContact'] as Map<String, dynamic>?),
      buyerContact: BuyerContact.fromJson(json['buyerContact'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'customerAssignedAccountID': customerAssignedAccountID?.toJson(),
      'supplierAssignedAccountID': supplierAssignedAccountID?.toJson(),
      'additionalAccountID': additionalAccountID.map((e) => e.toJson()).toList(),
      'party': party?.toJson(),
      'deliveryContact': deliveryContact?.toJson(),
      'accountingContact': accountingContact?.toJson(),
      'buyerContact': buyerContact?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AccountingCustomerParty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AccountingCustomerParty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      customerAssignedAccountID: CustomerAssignedAccountID.fromXml(xml.findElements('cbc:CustomerAssignedAccountID').singleOrNull),
      supplierAssignedAccountID: SupplierAssignedAccountID.fromXml(xml.findElements('cbc:SupplierAssignedAccountID').singleOrNull),
      additionalAccountID: xml.findElements('cbc:AdditionalAccountID').map((XmlElement e) => AdditionalAccountID.fromXml(e)!).toList(),
      party: Party.fromXml(xml.findElements('cac:Party').singleOrNull),
      deliveryContact: DeliveryContact.fromXml(xml.findElements('cac:DeliveryContact').singleOrNull),
      accountingContact: AccountingContact.fromXml(xml.findElements('cac:AccountingContact').singleOrNull),
      buyerContact: BuyerContact.fromXml(xml.findElements('cac:BuyerContact').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'AccountingCustomerParty',
        'cac',
      ),
    );
  }
}

