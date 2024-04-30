import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A counted number of non-monetary units, possibly including a fractional part.
class TotalPackagesQuantity {

  final double value; // (decimal)

  // The unit of the quantity
  final String? unitCode; // (normalizedString)

  // The quantity unit code list.
  final String? unitCodeListID; // (normalizedString)

  // The identification of the agency that maintains the quantity unit code list
  final String? unitCodeListAgencyID; // (normalizedString)

  // The name of the agency which maintains the quantity unit code list.
  final String? unitCodeListAgencyName; // (string)

  TotalPackagesQuantity ({
    required this.value,
    this.unitCode,
    this.unitCodeListID,
    this.unitCodeListAgencyID,
    this.unitCodeListAgencyName,
  });

  static TotalPackagesQuantity? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TotalPackagesQuantity (
      value: double.tryParse(json['value'].toString()) ?? 0,
      unitCode: json['unitCode'] as String?,
      unitCodeListID: json['unitCodeListID'] as String?,
      unitCodeListAgencyID: json['unitCodeListAgencyID'] as String?,
      unitCodeListAgencyName: json['unitCodeListAgencyName'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
      'unitCode': unitCode?.toString(),
      'unitCodeListID': unitCodeListID?.toString(),
      'unitCodeListAgencyID': unitCodeListAgencyID?.toString(),
      'unitCodeListAgencyName': unitCodeListAgencyName?.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TotalPackagesQuantity? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TotalPackagesQuantity (
      value: double.tryParse(xml.innerText.toString()) ?? 0,
      unitCode: xml.getAttribute('unitCode'),
      unitCodeListID: xml.getAttribute('unitCodeListID'),
      unitCodeListAgencyID: xml.getAttribute('unitCodeListAgencyID'),
      unitCodeListAgencyName: xml.getAttribute('unitCodeListAgencyName'),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [

      unitCode != null ? XmlAttribute(XmlName('unitCode'), unitCode.toString(),) : null,
      unitCodeListID != null ? XmlAttribute(XmlName('unitCodeListID'), unitCodeListID.toString(),) : null,
      unitCodeListAgencyID != null ? XmlAttribute(XmlName('unitCodeListAgencyID'), unitCodeListAgencyID.toString(),) : null,
      unitCodeListAgencyName != null ? XmlAttribute(XmlName('unitCodeListAgencyName'), unitCodeListAgencyName.toString(),) : null,

    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TotalPackagesQuantity',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

