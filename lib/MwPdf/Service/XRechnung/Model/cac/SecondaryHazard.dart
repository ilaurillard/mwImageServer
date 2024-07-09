// do not edit
// ignore_for_file: unused_import

import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/ID.dart';
import '../cbc/PlacardNotation.dart';
import '../cbc/PlacardEndorsement.dart';
import '../cbc/EmergencyProceduresCode.dart';
import '../cbc/Extension.dart';

// A class to describe a secondary hazard associated with a hazardous item.
class SecondaryHazard {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for this secondary hazard.
  final ID? iD;

  // Text of the placard notation corresponding to the hazard class of this secondary hazard. Can also be the hazard identification number of the orange placard (upper part) required on the means of transport.
  final PlacardNotation? placardNotation;

  // Text of the placard endorsement for this secondary hazard that is to be shown on the shipping papers for a hazardous item. Can also be used for the number of the orange placard (lower part) required on the means of transport.
  final PlacardEndorsement? placardEndorsement;

  // A code signifying the emergency procedures for this secondary hazard.
  final EmergencyProceduresCode? emergencyProceduresCode;

  // Additional information about the hazardous substance, which can be used (for example) to specify the type of regulatory requirements that apply to this secondary hazard.
  final List<Extension> extension;

  SecondaryHazard ({
    this.uBLExtensions,
    this.iD,
    this.placardNotation,
    this.placardEndorsement,
    this.emergencyProceduresCode,
    this.extension = const [],
  });

  static SecondaryHazard? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return SecondaryHazard (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      placardNotation: PlacardNotation.fromJson(json['placardNotation'] as Map<String, dynamic>?),
      placardEndorsement: PlacardEndorsement.fromJson(json['placardEndorsement'] as Map<String, dynamic>?),
      emergencyProceduresCode: EmergencyProceduresCode.fromJson(json['emergencyProceduresCode'] as Map<String, dynamic>?),
      extension: (json['extension'] as List? ?? []).map((dynamic d) => Extension.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'iD': iD?.toJson(),
      'placardNotation': placardNotation?.toJson(),
      'placardEndorsement': placardEndorsement?.toJson(),
      'emergencyProceduresCode': emergencyProceduresCode?.toJson(),
      'extension': extension.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static SecondaryHazard? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return SecondaryHazard (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      placardNotation: PlacardNotation.fromXml(xml.findElements('cbc:PlacardNotation').singleOrNull),
      placardEndorsement: PlacardEndorsement.fromXml(xml.findElements('cbc:PlacardEndorsement').singleOrNull),
      emergencyProceduresCode: EmergencyProceduresCode.fromXml(xml.findElements('cbc:EmergencyProceduresCode').singleOrNull),
      extension: xml.findElements('cbc:Extension').map((XmlElement e) => Extension.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      iD?.toXml(),
      placardNotation?.toXml(),
      placardEndorsement?.toXml(),
      emergencyProceduresCode?.toXml(),
      ...extension.map((Extension e) => e.toXml()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'SecondaryHazard',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

