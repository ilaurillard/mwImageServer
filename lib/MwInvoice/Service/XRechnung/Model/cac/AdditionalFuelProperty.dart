// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/TypeID.dart';
import '../cbc/Value.dart';
import '../ext/UBLExtensions.dart';

// A class to describe a fuel property.
class AdditionalFuelProperty {


  // An identifier for the type of the fuel property.
  final TypeID typeID;

  // The value of this fuel property.
  final Value value;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  AdditionalFuelProperty ({
    required this.typeID,
    required this.value,
    this.uBLExtensions,
  });

  static AdditionalFuelProperty? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AdditionalFuelProperty (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      typeID: TypeID.fromJson(json['typeID'] as Map<String, dynamic>?)!,
      value: Value.fromJson(json['value'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'typeID': typeID.toJson(),
      'value': value.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AdditionalFuelProperty? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AdditionalFuelProperty (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      typeID: TypeID.fromXml(xml.findElements('cbc:TypeID').singleOrNull)!,
      value: Value.fromXml(xml.findElements('cbc:Value').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      typeID.toXml(),
      value.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'AdditionalFuelProperty',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

