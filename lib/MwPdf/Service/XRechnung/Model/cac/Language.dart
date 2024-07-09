// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/LocaleCode.dart';

// A class to describe a language.
class Language {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this language.
  final ID? iD;

  // The name of this language.
  final Name? name;

  // A code signifying the locale in which this language is used.
  final LocaleCode? localeCode;

  Language ({
    this.uBLExtensions,
    this.iD,
    this.name,
    this.localeCode,
  });

  static Language? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return Language (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      localeCode: LocaleCode.fromJson(json['localeCode'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'localeCode': localeCode?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static Language? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return Language (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      localeCode: LocaleCode.fromXml(xml.findElements('cbc:LocaleCode').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      name?.toXml(),
      localeCode?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'Language',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

