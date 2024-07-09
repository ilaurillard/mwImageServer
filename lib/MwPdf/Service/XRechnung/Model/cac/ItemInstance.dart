// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
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


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

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
    this.uBLExtensions,
    this.productTraceID,
    this.manufactureDate,
    this.manufactureTime,
    this.bestBeforeDate,
    this.registrationID,
    this.serialID,
    this.additionalItemProperty = const [],
    this.lotIdentification,
  });

  static ItemInstance? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ItemInstance (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      productTraceID: ProductTraceID.fromJson(json['productTraceID'] as Map<String, dynamic>?),
      manufactureDate: ManufactureDate.fromJson(json['manufactureDate'] as Map<String, dynamic>?),
      manufactureTime: ManufactureTime.fromJson(json['manufactureTime'] as Map<String, dynamic>?),
      bestBeforeDate: BestBeforeDate.fromJson(json['bestBeforeDate'] as Map<String, dynamic>?),
      registrationID: RegistrationID.fromJson(json['registrationID'] as Map<String, dynamic>?),
      serialID: SerialID.fromJson(json['serialID'] as Map<String, dynamic>?),
      additionalItemProperty: (json['additionalItemProperty'] as List? ?? []).map((dynamic d) => AdditionalItemProperty.fromJson(d as Map<String, dynamic>?)!).toList(),
      lotIdentification: LotIdentification.fromJson(json['lotIdentification'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
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

  static ItemInstance? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ItemInstance (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      productTraceID: ProductTraceID.fromXml(xml.findElements('cbc:ProductTraceID').singleOrNull),
      manufactureDate: ManufactureDate.fromXml(xml.findElements('cbc:ManufactureDate').singleOrNull),
      manufactureTime: ManufactureTime.fromXml(xml.findElements('cbc:ManufactureTime').singleOrNull),
      bestBeforeDate: BestBeforeDate.fromXml(xml.findElements('cbc:BestBeforeDate').singleOrNull),
      registrationID: RegistrationID.fromXml(xml.findElements('cbc:RegistrationID').singleOrNull),
      serialID: SerialID.fromXml(xml.findElements('cbc:SerialID').singleOrNull),
      additionalItemProperty: xml.findElements('cac:AdditionalItemProperty').map((XmlElement e) => AdditionalItemProperty.fromXml(e)!).toList(),
      lotIdentification: LotIdentification.fromXml(xml.findElements('cac:LotIdentification').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      productTraceID?.toXml(),
      manufactureDate?.toXml(),
      manufactureTime?.toXml(),
      bestBeforeDate?.toXml(),
      registrationID?.toXml(),
      serialID?.toXml(),
      ...additionalItemProperty.map((AdditionalItemProperty e) => e.toXml()),
      lotIdentification?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ItemInstance',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

