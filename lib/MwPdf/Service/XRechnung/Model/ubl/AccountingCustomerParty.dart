import '../cac/CustomerAssignedAccountID.dart';
import '../cac/SupplierAssignedAccountID.dart';
import '../cac/AdditionalAccountID.dart';
import '../cac/Party.dart';
import '../cac/DeliveryContact.dart';
import '../cac/AccountingContact.dart';
import '../cac/BuyerContact.dart';

// A class to describe a customer party.
class AccountingCustomerParty {


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
    this.customerAssignedAccountID,
    this.supplierAssignedAccountID,
    this.additionalAccountID = const [],
    this.party,
    this.deliveryContact,
    this.accountingContact,
    this.buyerContact,
  });
}

