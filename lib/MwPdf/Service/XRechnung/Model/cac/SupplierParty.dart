import '../cac/CustomerAssignedAccountID.dart';
import '../cac/AdditionalAccountID.dart';
import '../cac/DataSendingCapability.dart';
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
}

