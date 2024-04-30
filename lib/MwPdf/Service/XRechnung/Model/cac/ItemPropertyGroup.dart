import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/Name.dart';
import '../cbc/ImportanceCode.dart';

// A class to describe a property group or classification.
class ItemPropertyGroup {


  // An identifier for this group of item properties.
  final ID iD;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The name of this item property group.
  final Name? name;

  // A code signifying the importance of this property group in using it to describe a required Item.
  final ImportanceCode? importanceCode;

  ItemPropertyGroup ({
    required this.iD,
    this.uBLExtensions,
    this.name,
    this.importanceCode,
  });

  static ItemPropertyGroup? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ItemPropertyGroup (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?)!,
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      importanceCode: ImportanceCode.fromJson(json['importanceCode'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD.toJson(),
      'name': name?.toJson(),
      'importanceCode': importanceCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ItemPropertyGroup? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ItemPropertyGroup (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull)!,
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      importanceCode: ImportanceCode.fromXml(xml.findElements('cbc:ImportanceCode').singleOrNull),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'ItemPropertyGroup',
        'cac',
      ),
    );
  }
}

