import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/LocaleCode.dart';

// A class to describe a language.
class Language {


  // An identifier for this language.
  final ID? iD;

  // The name of this language.
  final Name? name;

  // A code signifying the locale in which this language is used.
  final LocaleCode? localeCode;

  Language ({
    this.iD,
    this.name,
    this.localeCode,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'localeCode': localeCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Language? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Language (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      localeCode: LocaleCode.fromJson(json['localeCode'] as Map<String, dynamic>?),
    );
  }

  static Language? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    XmlNodeList<XmlAttribute> attr = xml.attributes;
    return Language (
      iD: null,
      name: null,
      localeCode: null,
    );
  }

}

