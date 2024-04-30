import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/MinimumValue.dart';
import '../cbc/MaximumValue.dart';

// A class to describe a range of values for an item property.
class ItemPropertyRange {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The minimum value in this range of values.
  final MinimumValue? minimumValue;

  // The maximum value in this range of values.
  final MaximumValue? maximumValue;

  ItemPropertyRange ({
    this.uBLExtensions,
    this.minimumValue,
    this.maximumValue,
  });

  static ItemPropertyRange? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ItemPropertyRange (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      minimumValue: MinimumValue.fromJson(json['minimumValue'] as Map<String, dynamic>?),
      maximumValue: MaximumValue.fromJson(json['maximumValue'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'minimumValue': minimumValue?.toJson(),
      'maximumValue': maximumValue?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ItemPropertyRange? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return ItemPropertyRange (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      minimumValue: MinimumValue.fromXml(xml.findElements('cbc:MinimumValue').singleOrNull),
      maximumValue: MaximumValue.fromXml(xml.findElements('cbc:MaximumValue').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      minimumValue?.toXml(),
      maximumValue?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'ItemPropertyRange',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

