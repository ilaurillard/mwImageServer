import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AttributeID.dart';
import '../cbc/PositionCode.dart';
import '../cbc/DescriptionCode.dart';
import '../cbc/Description.dart';

// A class to describe a physical attribute.
class PhysicalAttribute {


  // An identifier for this physical attribute.
  final AttributeID attributeID;

  // A code signifying the position of this physical attribute.
  final PositionCode? positionCode;

  // A description of the physical attribute, expressed as a code.
  final DescriptionCode? descriptionCode;

  // A description of the physical attribute, expressed as text.
  final List<Description> description;

  PhysicalAttribute ({
    required this.attributeID,
    this.positionCode,
    this.descriptionCode,
    this.description = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'attributeID': attributeID.toJson(),
      'positionCode': positionCode?.toJson(),
      'descriptionCode': descriptionCode?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static PhysicalAttribute? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return PhysicalAttribute (
      attributeID: AttributeID.fromJson(json['attributeID'] as Map<String, dynamic>?)!,
      positionCode: PositionCode.fromJson(json['positionCode'] as Map<String, dynamic>?),
      descriptionCode: DescriptionCode.fromJson(json['descriptionCode'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static PhysicalAttribute? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return PhysicalAttribute (
      attributeID: null,
      positionCode: null,
      descriptionCode: null,
      description: null,
    );
  }

}

