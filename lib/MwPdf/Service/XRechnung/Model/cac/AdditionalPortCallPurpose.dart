import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/PurposeTypeCode.dart';
import '../cbc/PurposeType.dart';
import '../cbc/Description.dart';

// A class to describe the purpose of a port call.
class AdditionalPortCallPurpose {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The purpose of this port call, expressed as a code.
  final PurposeTypeCode? purposeTypeCode;

  // The purpose of this port call, expressed as a text.
  final List<PurposeType> purposeType;

  // A description of the purpose of the port call.
  final List<Description> description;

  AdditionalPortCallPurpose ({
    this.uBLExtensions,
    this.purposeTypeCode,
    this.purposeType = const [],
    this.description = const [],
  });

  static AdditionalPortCallPurpose? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AdditionalPortCallPurpose (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      purposeTypeCode: PurposeTypeCode.fromJson(json['purposeTypeCode'] as Map<String, dynamic>?),
      purposeType: (json['purposeType'] as List? ?? []).map((dynamic d) => PurposeType.fromJson(d as Map<String, dynamic>?)!).toList(),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'purposeTypeCode': purposeTypeCode?.toJson(),
      'purposeType': purposeType.map((e) => e.toJson()).toList(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AdditionalPortCallPurpose? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AdditionalPortCallPurpose (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      purposeTypeCode: PurposeTypeCode.fromXml(xml.findElements('cbc:PurposeTypeCode').singleOrNull),
      purposeType: xml.findElements('cbc:PurposeType').map((XmlElement e) => PurposeType.fromXml(e)!).toList(),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      purposeTypeCode?.toXml(),
      ...purposeType.map((PurposeType e) => e.toXml()).toList(),
      ...description.map((Description e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'AdditionalPortCallPurpose',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

