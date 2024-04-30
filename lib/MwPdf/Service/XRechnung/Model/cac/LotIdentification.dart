import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../ext/UBLExtensions.dart';
import '../cbc/LotNumberID.dart';
import '../cbc/ExpiryDate.dart';
import '../cac/AdditionalItemProperty.dart';

// A class for defining a lot identifier (the identifier of a set of item instances that would be used in case of a recall of that item).
class LotIdentification {


  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  // An identifier for the lot.
  final LotNumberID? lotNumberID;

  // The expiry date of the lot.
  final ExpiryDate? expiryDate;

  // An additional property of the lot.
  final List<AdditionalItemProperty> additionalItemProperty;

  LotIdentification ({
    this.uBLExtensions,
    this.lotNumberID,
    this.expiryDate,
    this.additionalItemProperty = const [],
  });

  static LotIdentification? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return LotIdentification (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      lotNumberID: LotNumberID.fromJson(json['lotNumberID'] as Map<String, dynamic>?),
      expiryDate: ExpiryDate.fromJson(json['expiryDate'] as Map<String, dynamic>?),
      additionalItemProperty: (json['additionalItemProperty'] as List? ?? []).map((dynamic d) => AdditionalItemProperty.fromJson(d as Map<String, dynamic>?)!).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'lotNumberID': lotNumberID?.toJson(),
      'expiryDate': expiryDate?.toJson(),
      'additionalItemProperty': additionalItemProperty.map((e) => e.toJson()).toList(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static LotIdentification? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return LotIdentification (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      lotNumberID: LotNumberID.fromXml(xml.findElements('cbc:LotNumberID').singleOrNull),
      expiryDate: ExpiryDate.fromXml(xml.findElements('cbc:ExpiryDate').singleOrNull),
      additionalItemProperty: xml.findElements('cac:AdditionalItemProperty').map((XmlElement e) => AdditionalItemProperty.fromXml(e)!).toList(),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      lotNumberID?.toXml(),
      expiryDate?.toXml(),
      ...additionalItemProperty.map((AdditionalItemProperty e) => e.toXml()).toList(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'LotIdentification',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

