// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/TankID.dart';
import '../cbc/TankTypeCode.dart';
import '../cbc/ExchangeMethodCode.dart';
import '../cbc/ExchangedPercent.dart';
import '../cbc/VolumeMeasure.dart';
import '../cbc/SeaHeightMeasure.dart';
import '../cbc/SalinityMeasure.dart';
import '../cbc/TransactionDate.dart';
import '../cac/Location.dart';
import '../cac/BallastWaterTemperature.dart';

// A class to define a ballast water transaction, such as the uptake, exchange or discharge of ballast water.
class DischargeBallastWaterTransaction {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for the ballast water tank being used in this ballast water transaction.
  final TankID? tankID;

  // A code for the type of ballast water tank being used in the ballast water transaction.
  final TankTypeCode? tankTypeCode;

  // A code expressing how ballast water is being filled into or discharged from the tank.
  final ExchangeMethodCode? exchangeMethodCode;

  // The percentage of the ballast water in the tank being exchanged in this ballast water transaction.
  final ExchangedPercent? exchangedPercent;

  // The volume of ballast water being exchanged in this ballast water transaction.
  final VolumeMeasure? volumeMeasure;

  // A measure of the sea height at the time of the transaction.
  final SeaHeightMeasure? seaHeightMeasure;

  // A measure for the salinity of the water in the tank.
  final SalinityMeasure? salinityMeasure;

  // The date when this ballast water transaction takes place.
  final TransactionDate? transactionDate;

  // The location where this ballast water transaction takes place.
  final Location? location;

  // The temperature of the ballast water at time of transaction.
  final BallastWaterTemperature? ballastWaterTemperature;

  DischargeBallastWaterTransaction ({
    this.uBLExtensions,
    this.tankID,
    this.tankTypeCode,
    this.exchangeMethodCode,
    this.exchangedPercent,
    this.volumeMeasure,
    this.seaHeightMeasure,
    this.salinityMeasure,
    this.transactionDate,
    this.location,
    this.ballastWaterTemperature,
  });

  static DischargeBallastWaterTransaction? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return DischargeBallastWaterTransaction (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      tankID: TankID.fromJson(json['tankID'] as Map<String, dynamic>?),
      tankTypeCode: TankTypeCode.fromJson(json['tankTypeCode'] as Map<String, dynamic>?),
      exchangeMethodCode: ExchangeMethodCode.fromJson(json['exchangeMethodCode'] as Map<String, dynamic>?),
      exchangedPercent: ExchangedPercent.fromJson(json['exchangedPercent'] as Map<String, dynamic>?),
      volumeMeasure: VolumeMeasure.fromJson(json['volumeMeasure'] as Map<String, dynamic>?),
      seaHeightMeasure: SeaHeightMeasure.fromJson(json['seaHeightMeasure'] as Map<String, dynamic>?),
      salinityMeasure: SalinityMeasure.fromJson(json['salinityMeasure'] as Map<String, dynamic>?),
      transactionDate: TransactionDate.fromJson(json['transactionDate'] as Map<String, dynamic>?),
      location: Location.fromJson(json['location'] as Map<String, dynamic>?),
      ballastWaterTemperature: BallastWaterTemperature.fromJson(json['ballastWaterTemperature'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'tankID': tankID?.toJson(),
      'tankTypeCode': tankTypeCode?.toJson(),
      'exchangeMethodCode': exchangeMethodCode?.toJson(),
      'exchangedPercent': exchangedPercent?.toJson(),
      'volumeMeasure': volumeMeasure?.toJson(),
      'seaHeightMeasure': seaHeightMeasure?.toJson(),
      'salinityMeasure': salinityMeasure?.toJson(),
      'transactionDate': transactionDate?.toJson(),
      'location': location?.toJson(),
      'ballastWaterTemperature': ballastWaterTemperature?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static DischargeBallastWaterTransaction? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return DischargeBallastWaterTransaction (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      tankID: TankID.fromXml(xml.findElements('cbc:TankID').singleOrNull),
      tankTypeCode: TankTypeCode.fromXml(xml.findElements('cbc:TankTypeCode').singleOrNull),
      exchangeMethodCode: ExchangeMethodCode.fromXml(xml.findElements('cbc:ExchangeMethodCode').singleOrNull),
      exchangedPercent: ExchangedPercent.fromXml(xml.findElements('cbc:ExchangedPercent').singleOrNull),
      volumeMeasure: VolumeMeasure.fromXml(xml.findElements('cbc:VolumeMeasure').singleOrNull),
      seaHeightMeasure: SeaHeightMeasure.fromXml(xml.findElements('cbc:SeaHeightMeasure').singleOrNull),
      salinityMeasure: SalinityMeasure.fromXml(xml.findElements('cbc:SalinityMeasure').singleOrNull),
      transactionDate: TransactionDate.fromXml(xml.findElements('cbc:TransactionDate').singleOrNull),
      location: Location.fromXml(xml.findElements('cac:Location').singleOrNull),
      ballastWaterTemperature: BallastWaterTemperature.fromXml(xml.findElements('cac:BallastWaterTemperature').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      tankID?.toXml(),
      tankTypeCode?.toXml(),
      exchangeMethodCode?.toXml(),
      exchangedPercent?.toXml(),
      volumeMeasure?.toXml(),
      seaHeightMeasure?.toXml(),
      salinityMeasure?.toXml(),
      transactionDate?.toXml(),
      location?.toXml(),
      ballastWaterTemperature?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'DischargeBallastWaterTransaction',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

