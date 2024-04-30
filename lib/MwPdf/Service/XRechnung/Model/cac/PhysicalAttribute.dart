import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AttributeID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/PositionCode.dart';
import '../cbc/DescriptionCode.dart';
import '../cbc/Description.dart';

// A class to describe a physical attribute.
class PhysicalAttribute {


  // An identifier for this physical attribute.
  final AttributeID attributeID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // A code signifying the position of this physical attribute.
  final PositionCode? positionCode;

  // A description of the physical attribute, expressed as a code.
  final DescriptionCode? descriptionCode;

  // A description of the physical attribute, expressed as text.
  final List<Description> description;

  PhysicalAttribute ({
    required this.attributeID,
    this.uBLExtensions,
    this.positionCode,
    this.descriptionCode,
    this.description = const [],
  });

  static PhysicalAttribute? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PhysicalAttribute (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      attributeID: AttributeID.fromJson(json['attributeID'] as Map<String, dynamic>?)!,
      positionCode: PositionCode.fromJson(json['positionCode'] as Map<String, dynamic>?),
      descriptionCode: DescriptionCode.fromJson(json['descriptionCode'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'attributeID': attributeID.toJson(),
      'positionCode': positionCode?.toJson(),
      'descriptionCode': descriptionCode?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PhysicalAttribute? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return PhysicalAttribute (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      attributeID: AttributeID.fromXml(xml.findElements('cbc:AttributeID').singleOrNull)!,
      positionCode: PositionCode.fromXml(xml.findElements('cbc:PositionCode').singleOrNull),
      descriptionCode: DescriptionCode.fromXml(xml.findElements('cbc:DescriptionCode').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      attributeID.toXml(),
      positionCode?.toXml(),
      descriptionCode?.toXml(),
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
        'PhysicalAttribute',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

