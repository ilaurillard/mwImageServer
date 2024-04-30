import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/URI.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../cbc/Description.dart';
import '../cbc/WebSiteTypeCode.dart';
import '../cac/WebSiteAccess.dart';

// A class to describe a web site.
class AdditionalWebSite {


  // The Uniform Resource Identifier (URI) of the web site; i.e., its Uniform Resource Locator (URL).
  final URI uRI;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for a specific web site.
  final ID? iD;

  // The common name of the web site.
  final Name? name;

  // Text describing the web site.
  final List<Description> description;

  // A code that specifies the type web site.
  final WebSiteTypeCode? webSiteTypeCode;

  // Access information for the website (e.g. guest credentials).
  final List<WebSiteAccess> webSiteAccess;

  AdditionalWebSite ({
    required this.uRI,
    this.uBLExtensions,
    this.iD,
    this.name,
    this.description = const [],
    this.webSiteTypeCode,
    this.webSiteAccess = const [],
  });

  static AdditionalWebSite? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return AdditionalWebSite (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      description: (json['description'] as List? ?? []).map((dynamic d) => Description.fromJson(d as Map<String, dynamic>?)!).toList(),
      webSiteTypeCode: WebSiteTypeCode.fromJson(json['webSiteTypeCode'] as Map<String, dynamic>?),
      uRI: URI.fromJson(json['uRI'] as Map<String, dynamic>?)!,
      webSiteAccess: (json['webSiteAccess'] as List? ?? []).map((dynamic d) => WebSiteAccess.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'description': description.map((e) => e.toJson()).toList(),
      'webSiteTypeCode': webSiteTypeCode?.toJson(),
      'uRI': uRI.toJson(),
      'webSiteAccess': webSiteAccess.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static AdditionalWebSite? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return AdditionalWebSite (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      description: xml.findElements('cbc:Description').map((XmlElement e) => Description.fromXml(e)!).toList(),
      webSiteTypeCode: WebSiteTypeCode.fromXml(xml.findElements('cbc:WebSiteTypeCode').singleOrNull),
      uRI: URI.fromXml(xml.findElements('cbc:URI').singleOrNull)!,
      webSiteAccess: xml.findElements('cac:WebSiteAccess').map((XmlElement e) => WebSiteAccess.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {
    return XmlElement(
      XmlName(
        'AdditionalWebSite',
        'cac',
      ),
    );
  }
}

