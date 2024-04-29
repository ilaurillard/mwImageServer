import '../cac/ID.dart';
import '../cac/SalesOrderID.dart';
import '../cac/CopyIndicator.dart';
import '../cac/UUID.dart';
import '../cac/IssueDate.dart';
import '../cac/IssueTime.dart';
import '../cac/CustomerReference.dart';
import '../cac/OrderTypeCode.dart';
import '../cac/DocumentReference.dart';

// A class to define a reference to an Order.
class OrderReference {


  // An identifier for this order reference, assigned by the buyer.
  final ID iD;

  // An identifier for this order reference, assigned by the seller.
  final SalesOrderID? salesOrderID;

  // Indicates whether the referenced Order is a copy (true) or the original (false).
  final CopyIndicator? copyIndicator;

  // A universally unique identifier for this order reference.
  final UUID? uUID;

  // The date on which the referenced Order was issued.
  final IssueDate? issueDate;

  // The time at which the referenced Order was issued.
  final IssueTime? issueTime;

  // Text used for tagging purchasing card transactions.
  final CustomerReference? customerReference;

  // A code signifying the type of the referenced Order.
  final OrderTypeCode? orderTypeCode;

  // A document associated with this reference to an Order.
  final DocumentReference? documentReference;

  OrderReference ({
    required this.iD,
    this.salesOrderID,
    this.copyIndicator,
    this.uUID,
    this.issueDate,
    this.issueTime,
    this.customerReference,
    this.orderTypeCode,
    this.documentReference,
  });
}

