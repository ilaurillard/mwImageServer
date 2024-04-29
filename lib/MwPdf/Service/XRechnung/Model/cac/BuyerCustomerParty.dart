import 'dart:convert';
import '../cbc/CustomerAssignedAccountID.dart';
import '../cbc/SupplierAssignedAccountID.dart';
import '../cbc/AdditionalAccountID.dart';
import '../cac/Party.dart';
import '../cac/DeliveryContact.dart';
import '../cac/AccountingContact.dart';
import '../cac/BuyerContact.dart';

// A class to describe a customer party.
class BuyerCustomerParty {


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

  BuyerCustomerParty ({
    this.customerAssignedAccountID,
    this.supplierAssignedAccountID,
    this.additionalAccountID = const [],
    this.party,
    this.deliveryContact,
    this.accountingContact,
    this.buyerContact,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
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

}

