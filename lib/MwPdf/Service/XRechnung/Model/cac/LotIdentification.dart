import '../cac/LotNumberID.dart';
import '../cac/ExpiryDate.dart';
import '../cac/AdditionalItemProperty.dart';

// A class for defining a lot identifier (the identifier of a set of item instances that would be used in case of a recall of that item).
class LotIdentification {


  // An identifier for the lot.
  final LotNumberID? lotNumberID;

  // The expiry date of the lot.
  final ExpiryDate? expiryDate;

  // An additional property of the lot.
  final List<AdditionalItemProperty> additionalItemProperty;

  LotIdentification ({
    this.lotNumberID,
    this.expiryDate,
    this.additionalItemProperty = const [],
  });
}

