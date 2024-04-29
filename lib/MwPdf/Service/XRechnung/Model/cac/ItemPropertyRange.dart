import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/MinimumValue.dart';
import '../cbc/MaximumValue.dart';

// A class to describe a range of values for an item property.
class ItemPropertyRange {


  // The minimum value in this range of values.
  final MinimumValue? minimumValue;

  // The maximum value in this range of values.
  final MaximumValue? maximumValue;

  ItemPropertyRange ({
    this.minimumValue,
    this.maximumValue,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'minimumValue': minimumValue?.toJson(),
      'maximumValue': maximumValue?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static ItemPropertyRange? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return ItemPropertyRange (
      minimumValue: MinimumValue.fromJson(json['minimumValue'] as Map<String, dynamic>?),
      maximumValue: MaximumValue.fromJson(json['maximumValue'] as Map<String, dynamic>?),
    );
  }

  static ItemPropertyRange? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return ItemPropertyRange (
      minimumValue: null,
      maximumValue: null,
    );
  }

}

