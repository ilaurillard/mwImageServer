import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/URI.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/SocialMediaTypeCode.dart';

// A class to describe a social media profile.
class SocialMediaProfile {


  // The Uniform Resource Identifier (URI) of a party profile in the social media; i.e., its Uniform Resource Locator (URL).
  final URI uRI;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for a specific social media.
  final ID? iD;

  // The common name of the social media.
  final Name? name;

  // A code that specifies the type of social media.
  final SocialMediaTypeCode? socialMediaTypeCode;

  SocialMediaProfile ({
    required this.uRI,
    this.uBLExtensions,
    this.iD,
    this.name,
    this.socialMediaTypeCode,
  });

  static SocialMediaProfile? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SocialMediaProfile (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      socialMediaTypeCode: SocialMediaTypeCode.fromJson(json['socialMediaTypeCode'] as Map<String, dynamic>?),
      uRI: URI.fromJson(json['uRI'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'socialMediaTypeCode': socialMediaTypeCode?.toJson(),
      'uRI': uRI.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SocialMediaProfile? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SocialMediaProfile (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      socialMediaTypeCode: SocialMediaTypeCode.fromXml(xml.findElements('cbc:SocialMediaTypeCode').singleOrNull),
      uRI: URI.fromXml(xml.findElements('cbc:URI').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      name?.toXml(),
      socialMediaTypeCode?.toXml(),
      uRI.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SocialMediaProfile',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

