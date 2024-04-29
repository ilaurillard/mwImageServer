import 'dart:convert';
import '../../Etc/Util.dart';
import '../cbc/ProductTraceID.dart';
import '../cbc/ManufactureDate.dart';
import '../cbc/ManufactureTime.dart';
import '../cbc/BestBeforeDate.dart';
import '../cbc/RegistrationID.dart';
import '../cbc/SerialID.dart';
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

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
     'productTraceID': productTraceID?.toJson(),
     'manufactureDate': manufactureDate?.toJson(),
     'manufactureTime': manufactureTime?.toJson(),
     'bestBeforeDate': bestBeforeDate?.toJson(),
     'registrationID': registrationID?.toJson(),
     'serialID': serialID?.toJson(),
     'additionalItemProperty': additionalItemProperty.map((e) => e.toJson()).toList(),
     'lotIdentification': lotIdentification?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }


  ItemInstance fromJson(Map<String, dynamic> json) {
    return ItemInstance (
    );
  }

}

