import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/VisitDate.dart';
import '../cac/WHOAffectedAreaPortLocation.dart';
import '../ext/UBLExtensions.dart';

// A class to describe a visit to a port located in a geographical area considered an âaffected areaâ by the World Health Organization (WHO).
class WHOAffectedAreaVisit {


  // The date that the WHO Affected Area was visited.
  final VisitDate visitDate;

  // The location of the port of the visited WHO Affected Area.
  final WHOAffectedAreaPortLocation wHOAffectedAreaPortLocation;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  WHOAffectedAreaVisit ({
    required this.visitDate,
    required this.wHOAffectedAreaPortLocation,
    this.uBLExtensions,
  });

  static WHOAffectedAreaVisit? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return WHOAffectedAreaVisit (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      visitDate: VisitDate.fromJson(json['visitDate'] as Map<String, dynamic>?)!,
      wHOAffectedAreaPortLocation: WHOAffectedAreaPortLocation.fromJson(json['wHOAffectedAreaPortLocation'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'visitDate': visitDate.toJson(),
      'wHOAffectedAreaPortLocation': wHOAffectedAreaPortLocation.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static WHOAffectedAreaVisit? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return WHOAffectedAreaVisit (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      visitDate: VisitDate.fromXml(xml.findElements('cbc:VisitDate').singleOrNull)!,
      wHOAffectedAreaPortLocation: WHOAffectedAreaPortLocation.fromXml(xml.findElements('cac:WHOAffectedAreaPortLocation').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      visitDate.toXml(),
      wHOAffectedAreaPortLocation.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'WHOAffectedAreaVisit',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

