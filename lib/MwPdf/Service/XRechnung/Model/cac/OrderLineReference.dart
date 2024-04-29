import '../cac/LineID.dart';
import '../cac/SalesOrderLineID.dart';
import '../cac/UUID.dart';
import '../cac/LineStatusCode.dart';
import '../cac/OrderReference.dart';

// A class to define a reference to an order line.
class OrderLineReference {


  // An identifier for the referenced order line, assigned by the buyer.
  final LineID lineID;

  // An identifier for the referenced order line, assigned by the seller.
  final SalesOrderLineID? salesOrderLineID;

  // A universally unique identifier for this order line reference.
  final UUID? uUID;

  // A code signifying the status of the referenced order line with respect to its original state.
  final LineStatusCode? lineStatusCode;

  // A reference to the Order containing the referenced order line.
  final OrderReference? orderReference;

  OrderLineReference ({
    required this.lineID,
    this.salesOrderLineID,
    this.uUID,
    this.lineStatusCode,
    this.orderReference,
  });
}

