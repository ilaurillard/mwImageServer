// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/WeighingMethodCode.dart';
import '../cbc/GrossMassMeasure.dart';
import '../cac/DocumentReference.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/WeighingDate.dart';
import '../cbc/WeighingTime.dart';
import '../cbc/WeighingDeviceID.dart';
import '../cbc/WeighingDeviceType.dart';
import '../cac/WeighingParty.dart';
import '../cac/ShipperParty.dart';
import '../cac/ResponsibleParty.dart';

// A class to describe a verified gross mass (VGM) measure and its documentation.
class VerifiedGrossMass {


  // A code signifying the weighing method used (e.g. according the SOLAS Convention).
  final WeighingMethodCode weighingMethodCode;

  // The total verified gross mass of a packed container which includes the cargo weight, block and bracing materials and container tare.
  final GrossMassMeasure grossMassMeasure;

  // A reference to the VGM documentary evidence.
  final List<DocumentReference> documentReference;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this mass measure.
  final ID? iD;

  // The weighing date.
  final WeighingDate? weighingDate;

  // The weighing time.
  final WeighingTime? weighingTime;

  // An identifier for the weighing device used for executing the weight measurement.
  final WeighingDeviceID? weighingDeviceID;

  // Text describing the weighing device type used for executing the weight measurement.
  final WeighingDeviceType? weighingDeviceType;

  // The party executing the weight measure.
  final WeighingParty? weighingParty;

  // The party playing the role of the Shipper (BCO, FF or NVOCC) who is responsible for the VGM (e.g. according the SOLAS Convention).
  final ShipperParty? shipperParty;

  // The party responsible for signing the VGM on behalf of the Shipper.
  final ResponsibleParty? responsibleParty;

  VerifiedGrossMass ({
    required this.weighingMethodCode,
    required this.grossMassMeasure,
    required this.documentReference,
    this.uBLExtensions,
    this.iD,
    this.weighingDate,
    this.weighingTime,
    this.weighingDeviceID,
    this.weighingDeviceType,
    this.weighingParty,
    this.shipperParty,
    this.responsibleParty,
  }) {
    if (documentReference.isEmpty) { throw Exception('empty documentReference given'); }
  }

  static VerifiedGrossMass? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return VerifiedGrossMass (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      weighingDate: WeighingDate.fromJson(json['weighingDate'] as Map<String, dynamic>?),
      weighingTime: WeighingTime.fromJson(json['weighingTime'] as Map<String, dynamic>?),
      weighingMethodCode: WeighingMethodCode.fromJson(json['weighingMethodCode'] as Map<String, dynamic>?)!,
      weighingDeviceID: WeighingDeviceID.fromJson(json['weighingDeviceID'] as Map<String, dynamic>?),
      weighingDeviceType: WeighingDeviceType.fromJson(json['weighingDeviceType'] as Map<String, dynamic>?),
      grossMassMeasure: GrossMassMeasure.fromJson(json['grossMassMeasure'] as Map<String, dynamic>?)!,
      weighingParty: WeighingParty.fromJson(json['weighingParty'] as Map<String, dynamic>?),
      shipperParty: ShipperParty.fromJson(json['shipperParty'] as Map<String, dynamic>?),
      responsibleParty: ResponsibleParty.fromJson(json['responsibleParty'] as Map<String, dynamic>?),
      documentReference: (json['documentReference'] as List? ?? []).map((dynamic d) => DocumentReference.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'weighingDate': weighingDate?.toJson(),
      'weighingTime': weighingTime?.toJson(),
      'weighingMethodCode': weighingMethodCode.toJson(),
      'weighingDeviceID': weighingDeviceID?.toJson(),
      'weighingDeviceType': weighingDeviceType?.toJson(),
      'grossMassMeasure': grossMassMeasure.toJson(),
      'weighingParty': weighingParty?.toJson(),
      'shipperParty': shipperParty?.toJson(),
      'responsibleParty': responsibleParty?.toJson(),
      'documentReference': documentReference.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static VerifiedGrossMass? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return VerifiedGrossMass (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      weighingDate: WeighingDate.fromXml(xml.findElements('cbc:WeighingDate').singleOrNull),
      weighingTime: WeighingTime.fromXml(xml.findElements('cbc:WeighingTime').singleOrNull),
      weighingMethodCode: WeighingMethodCode.fromXml(xml.findElements('cbc:WeighingMethodCode').singleOrNull)!,
      weighingDeviceID: WeighingDeviceID.fromXml(xml.findElements('cbc:WeighingDeviceID').singleOrNull),
      weighingDeviceType: WeighingDeviceType.fromXml(xml.findElements('cbc:WeighingDeviceType').singleOrNull),
      grossMassMeasure: GrossMassMeasure.fromXml(xml.findElements('cbc:GrossMassMeasure').singleOrNull)!,
      weighingParty: WeighingParty.fromXml(xml.findElements('cac:WeighingParty').singleOrNull),
      shipperParty: ShipperParty.fromXml(xml.findElements('cac:ShipperParty').singleOrNull),
      responsibleParty: ResponsibleParty.fromXml(xml.findElements('cac:ResponsibleParty').singleOrNull),
      documentReference: xml.findElements('cac:DocumentReference').map((XmlElement e) => DocumentReference.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      weighingDate?.toXml(),
      weighingTime?.toXml(),
      weighingMethodCode.toXml(),
      weighingDeviceID?.toXml(),
      weighingDeviceType?.toXml(),
      grossMassMeasure.toXml(),
      weighingParty?.toXml(),
      shipperParty?.toXml(),
      responsibleParty?.toXml(),
      ...documentReference.map((DocumentReference e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'VerifiedGrossMass',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

