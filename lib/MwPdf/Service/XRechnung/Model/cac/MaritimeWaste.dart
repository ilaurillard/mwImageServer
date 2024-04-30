import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Description.dart';
import '../cbc/WasteTypeCode.dart';
import '../cbc/ToBeDeliveredMeasure.dart';
import '../cbc/RetainedOnBoardMeasure.dart';
import '../cbc/MaxDedicatedStorageCapacityMeasure.dart';
import '../cbc/EstimatedGeneratedUntilNextPortMeasure.dart';
import '../cac/RemainingWasteDeliveryPortLocation.dart';

// A class to describe a transaction of maritime waste.
class MaritimeWaste {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this maritime waste transaction.
  final ID? iD;

  // A text descriping this maritime waste transaction.
  final List<Description> description;

  // A code specifying the type of waste in this maritime waste transaction.
  final WasteTypeCode? wasteTypeCode;

  // The messure of waste to be delivered.
  final ToBeDeliveredMeasure? toBeDeliveredMeasure;

  // The meassure of waste retained on board.
  final RetainedOnBoardMeasure? retainedOnBoardMeasure;

  // The messure for the maximum dedicated storage capacity.
  final MaxDedicatedStorageCapacityMeasure? maxDedicatedStorageCapacityMeasure;

  // The messure of waste generated until the next port.
  final EstimatedGeneratedUntilNextPortMeasure? estimatedGeneratedUntilNextPortMeasure;

  // The location of the port where the remaining waste is delivered.
  final List<RemainingWasteDeliveryPortLocation> remainingWasteDeliveryPortLocation;

  MaritimeWaste ({
    this.uBLExtensions,
    this.iD,
    this.description = const [],
    this.wasteTypeCode,
    this.toBeDeliveredMeasure,
    this.retainedOnBoardMeasure,
    this.maxDedicatedStorageCapacityMeasure,
    this.estimatedGeneratedUntilNextPortMeasure,
    this.remainingWasteDeliveryPortLocation = const [],
  });

  static MaritimeWaste? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return MaritimeWaste (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      wasteTypeCode: WasteTypeCode.fromJson(json['wasteTypeCode'] as Map<String, dynamic>?),
      toBeDeliveredMeasure: ToBeDeliveredMeasure.fromJson(json['toBeDeliveredMeasure'] as Map<String, dynamic>?),
      retainedOnBoardMeasure: RetainedOnBoardMeasure.fromJson(json['retainedOnBoardMeasure'] as Map<String, dynamic>?),
      maxDedicatedStorageCapacityMeasure: MaxDedicatedStorageCapacityMeasure.fromJson(json['maxDedicatedStorageCapacityMeasure'] as Map<String, dynamic>?),
      estimatedGeneratedUntilNextPortMeasure: EstimatedGeneratedUntilNextPortMeasure.fromJson(json['estimatedGeneratedUntilNextPortMeasure'] as Map<String, dynamic>?),
      remainingWasteDeliveryPortLocation: (json['remainingWasteDeliveryPortLocation'] as List? ?? []).map((dynamic d) => RemainingWasteDeliveryPortLocation.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'wasteTypeCode': wasteTypeCode?.toJson(),
      'toBeDeliveredMeasure': toBeDeliveredMeasure?.toJson(),
      'retainedOnBoardMeasure': retainedOnBoardMeasure?.toJson(),
      'maxDedicatedStorageCapacityMeasure': maxDedicatedStorageCapacityMeasure?.toJson(),
      'estimatedGeneratedUntilNextPortMeasure': estimatedGeneratedUntilNextPortMeasure?.toJson(),
      'remainingWasteDeliveryPortLocation': remainingWasteDeliveryPortLocation.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static MaritimeWaste? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return MaritimeWaste (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      wasteTypeCode: WasteTypeCode.fromXml(xml.findElements('cbc:WasteTypeCode').singleOrNull),
      toBeDeliveredMeasure: ToBeDeliveredMeasure.fromXml(xml.findElements('cbc:ToBeDeliveredMeasure').singleOrNull),
      retainedOnBoardMeasure: RetainedOnBoardMeasure.fromXml(xml.findElements('cbc:RetainedOnBoardMeasure').singleOrNull),
      maxDedicatedStorageCapacityMeasure: MaxDedicatedStorageCapacityMeasure.fromXml(xml.findElements('cbc:MaxDedicatedStorageCapacityMeasure').singleOrNull),
      estimatedGeneratedUntilNextPortMeasure: EstimatedGeneratedUntilNextPortMeasure.fromXml(xml.findElements('cbc:EstimatedGeneratedUntilNextPortMeasure').singleOrNull),
      remainingWasteDeliveryPortLocation: xml.findElements('cac:RemainingWasteDeliveryPortLocation').map((XmlElement e) => RemainingWasteDeliveryPortLocation.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'MaritimeWaste',
        'cac',
      ),
    );
  }
}

