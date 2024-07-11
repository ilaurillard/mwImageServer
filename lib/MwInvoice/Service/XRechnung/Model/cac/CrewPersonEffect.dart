// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/EffectDescription.dart';
import '../ext/UBLExtensions.dart';
import '../cac/CrewPerson.dart';

// A class describing the effect or belonging of a Crew Person
class CrewPersonEffect {


  // The description of the crew effect.
  final List<EffectDescription> effectDescription;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // The crew person to whom the effect belongs.
  final CrewPerson? crewPerson;

  CrewPersonEffect ({
    required this.effectDescription,
    this.uBLExtensions,
    this.crewPerson,
  }) {
    assert(effectDescription.isNotEmpty);
  }

  static CrewPersonEffect? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CrewPersonEffect (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      effectDescription: (json['effectDescription'] as List? ?? []).map((dynamic d) => EffectDescription.fromJson(d as Map<String, dynamic>?)!).toList(),
      crewPerson: CrewPerson.fromJson(json['crewPerson'] as Map<String, dynamic>?),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'effectDescription': effectDescription.map((e) => e.toJson()).toList(),
      'crewPerson': crewPerson?.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CrewPersonEffect? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CrewPersonEffect (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      effectDescription: xml.findElements('cbc:EffectDescription').map((XmlElement e) => EffectDescription.fromXml(e)!).toList(),
      crewPerson: CrewPerson.fromXml(xml.findElements('cac:CrewPerson').singleOrNull),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      ...effectDescription.map((EffectDescription e) => e.toXml()),
      crewPerson?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'CrewPersonEffect',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

