import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/CustomerAssignedAccountID.dart';
import '../cbc/AdditionalAccountID.dart';
import '../cbc/DataSendingCapability.dart';
import '../cac/Party.dart';
import '../cac/DespatchContact.dart';
import '../cac/AccountingContact.dart';
import '../cac/SellerContact.dart';

// A class to describe a supplier party.
class SupplierParty {


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

  SupplierParty ({
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


  SupplierParty fromJson(Map<String, dynamic> json) {
    return SupplierParty (
    );
  }

}

