import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/ID.dart';
import '../cbc/Name.dart';
import '../ext/ExtensionAgencyID.dart';
import '../ext/ExtensionAgencyName.dart';
import '../ext/ExtensionVersionID.dart';
import '../ext/ExtensionAgencyURI.dart';
import '../ext/ExtensionURI.dart';
import '../ext/ExtensionReasonCode.dart';
import '../ext/ExtensionReason.dart';

// A single extension for private use.
class UBLExtension {


  // The definition of the extension content.
  final extensionContent; // missing type ExtensionContent

  // An identifier for the Extension assigned by the creator of the extension.
  final ID? iD;

  // A name for the Extension assigned by the creator of the extension.
  final Name? name;

  // An agency that maintains one or more Extensions.
  final ExtensionAgencyID? extensionAgencyID;

  // The name of the agency that maintains the Extension.
  final ExtensionAgencyName? extensionAgencyName;

  // The version of the Extension.
  final ExtensionVersionID? extensionVersionID;

  // A URI for the Agency that maintains the Extension.
  final ExtensionAgencyURI? extensionAgencyURI;

  // A URI for the Extension.
  final ExtensionURI? extensionURI;

  // A code for reason the Extension is being included.
  final ExtensionReasonCode? extensionReasonCode;

  // A description of the reason for the Extension.
  final ExtensionReason? extensionReason;

  UBLExtension ({
    required this.extensionContent,
    this.iD,
    this.name,
    this.extensionAgencyID,
    this.extensionAgencyName,
    this.extensionVersionID,
    this.extensionAgencyURI,
    this.extensionURI,
    this.extensionReasonCode,
    this.extensionReason,
  });

  static UBLExtension? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return UBLExtension (
      iD: ID.fromJson(json['iD'] as Map<String, dynamic>?),
      name: Name.fromJson(json['name'] as Map<String, dynamic>?),
      extensionAgencyID: ExtensionAgencyID.fromJson(json['extensionAgencyID'] as Map<String, dynamic>?),
      extensionAgencyName: ExtensionAgencyName.fromJson(json['extensionAgencyName'] as Map<String, dynamic>?),
      extensionVersionID: ExtensionVersionID.fromJson(json['extensionVersionID'] as Map<String, dynamic>?),
      extensionAgencyURI: ExtensionAgencyURI.fromJson(json['extensionAgencyURI'] as Map<String, dynamic>?),
      extensionURI: ExtensionURI.fromJson(json['extensionURI'] as Map<String, dynamic>?),
      extensionReasonCode: ExtensionReasonCode.fromJson(json['extensionReasonCode'] as Map<String, dynamic>?),
      extensionReason: ExtensionReason.fromJson(json['extensionReason'] as Map<String, dynamic>?),
      extensionContent: null, // missing type!!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'iD': iD?.toJson(),
      'name': name?.toJson(),
      'extensionAgencyID': extensionAgencyID?.toJson(),
      'extensionAgencyName': extensionAgencyName?.toJson(),
      'extensionVersionID': extensionVersionID?.toJson(),
      'extensionAgencyURI': extensionAgencyURI?.toJson(),
      'extensionURI': extensionURI?.toJson(),
      'extensionReasonCode': extensionReasonCode?.toJson(),
      'extensionReason': extensionReason?.toJson(),
      'extensionContent': extensionContent.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static UBLExtension? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return UBLExtension (
      iD: ID.fromXml(xml.findElements('cbc:ID').singleOrNull),
      name: Name.fromXml(xml.findElements('cbc:Name').singleOrNull),
      extensionAgencyID: ExtensionAgencyID.fromXml(xml.findElements('ext:ExtensionAgencyID').singleOrNull),
      extensionAgencyName: ExtensionAgencyName.fromXml(xml.findElements('ext:ExtensionAgencyName').singleOrNull),
      extensionVersionID: ExtensionVersionID.fromXml(xml.findElements('ext:ExtensionVersionID').singleOrNull),
      extensionAgencyURI: ExtensionAgencyURI.fromXml(xml.findElements('ext:ExtensionAgencyURI').singleOrNull),
      extensionURI: ExtensionURI.fromXml(xml.findElements('ext:ExtensionURI').singleOrNull),
      extensionReasonCode: ExtensionReasonCode.fromXml(xml.findElements('ext:ExtensionReasonCode').singleOrNull),
      extensionReason: ExtensionReason.fromXml(xml.findElements('ext:ExtensionReason').singleOrNull),
      extensionContent: null, // missing type!!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      iD?.toXml(),
      name?.toXml(),
      extensionAgencyID?.toXml(),
      extensionAgencyName?.toXml(),
      extensionVersionID?.toXml(),
      extensionAgencyURI?.toXml(),
      extensionURI?.toXml(),
      extensionReasonCode?.toXml(),
      extensionReason?.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'UBLExtension',
        'ext',
      ),
      attributes,
      children,
    );
  }
}

