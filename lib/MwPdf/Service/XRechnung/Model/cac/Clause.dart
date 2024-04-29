import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Content.dart';

// A class to define a clause (a distinct article or provision) in a contract, treaty, will, or other formal or legal written document requiring compliance.
class Clause {


  // An identifier for this clause.
  final ID? iD;

  // The text of this clause.
  final List<Content> content;

  Clause ({
    this.iD,
    this.content = const [],
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'content': content.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Clause? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Clause (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      content: (json['content'] as List? ?? []).map((dynamic d) => Content.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  static Clause? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Clause (
      iD: null,
      content: null,
    );
  }

}

