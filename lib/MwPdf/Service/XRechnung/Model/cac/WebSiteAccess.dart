import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/Password.dart';
import '../cbc/Login.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/URI.dart';

// A class to describe access to a web site.
class WebSiteAccess {


  // A password to the web site.
  final Password password;

  // Text describing login details.
  final Login login;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The Uniform Resource Identifier (URI) for this web site; i.e., its Uniform Resource Locator (URL).
  final URI? uRI;

  WebSiteAccess ({
    required this.password,
    required this.login,
    this.uBLExtensions,
    this.uRI,
  });

  static WebSiteAccess? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return WebSiteAccess (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      uRI: URI.fromJson(json['uRI'] as Map<String, dynamic>?),
      password: Password.fromJson(json['password'] as Map<String, dynamic>?)!,
      login: Login.fromJson(json['login'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'uRI': uRI?.toJson(),
      'password': password.toJson(),
      'login': login.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static WebSiteAccess? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return WebSiteAccess (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      uRI: URI.fromXml(xml.findElements('cbc:URI').singleOrNull),
      password: Password.fromXml(xml.findElements('cbc:Password').singleOrNull)!,
      login: Login.fromXml(xml.findElements('cbc:Login').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      uRI?.toXml(),
      password.toXml(),
      login.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'WebSiteAccess',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

