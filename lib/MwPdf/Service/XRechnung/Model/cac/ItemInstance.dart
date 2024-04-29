import '../cac/ProductTraceID.dart';
import '../cac/ManufactureDate.dart';
import '../cac/ManufactureTime.dart';
import '../cac/BestBeforeDate.dart';
import '../cac/RegistrationID.dart';
import '../cac/SerialID.dart';
import '../cac/AdditionalItemProperty.dart';
import '../cac/LotIdentification.dart';

// A class to describe a specific, trackable instance of an item.
class ItemInstance {


  // An identifier used for tracing this item instance, such as the EPC number used in RFID.
  final ProductTraceID? productTraceID;

  // The date on which this item instance was manufactured.
  final ManufactureDate? manufactureDate;

  // The time at which this item instance was manufactured.
  final ManufactureTime? manufactureTime;

  // The date before which it is best to use this item instance.
  final BestBeforeDate? bestBeforeDate;

  // The registration identifier of this item instance.
  final RegistrationID? registrationID;

  // The serial number of this item instance.
  final SerialID? serialID;

  // An additional property of this item instance.
  final List<AdditionalItemProperty> additionalItemProperty;

  // The lot identifier of this item instance (the identifier that allows recall of the item if necessary).
  final LotIdentification? lotIdentification;

  ItemInstance ({
    this.productTraceID,
    this.manufactureDate,
    this.manufactureTime,
    this.bestBeforeDate,
    this.registrationID,
    this.serialID,
    this.additionalItemProperty = const [],
    this.lotIdentification,
  });
}

