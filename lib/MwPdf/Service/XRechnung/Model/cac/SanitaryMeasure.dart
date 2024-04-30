import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/SanitaryMeasureTypeCode.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ApplicationDate.dart';

// A class describing a plan, action or meassure that has been implemented for sanitary reasons.
class SanitaryMeasure {


  // A code decribing the type of sanitary meassure.
  final SanitaryMeasureTypeCode sanitaryMeasureTypeCode;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The date this sanitary meassure was applied.
  final ApplicationDate? applicationDate;

  SanitaryMeasure ({
    required this.sanitaryMeasureTypeCode,
    this.uBLExtensions,
    this.applicationDate,
  });

  static SanitaryMeasure? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SanitaryMeasure (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      sanitaryMeasureTypeCode: SanitaryMeasureTypeCode.fromJson(json['sanitaryMeasureTypeCode'] as Map<String, dynamic>?)!,
      applicationDate: ApplicationDate.fromJson(json['applicationDate'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'sanitaryMeasureTypeCode': sanitaryMeasureTypeCode.toJson(),
      'applicationDate': applicationDate?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SanitaryMeasure? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SanitaryMeasure (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      sanitaryMeasureTypeCode: SanitaryMeasureTypeCode.fromXml(xml.findElements('cbc:SanitaryMeasureTypeCode').singleOrNull)!,
      applicationDate: ApplicationDate.fromXml(xml.findElements('cbc:ApplicationDate').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      sanitaryMeasureTypeCode.toXml(),
      applicationDate?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SanitaryMeasure',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

