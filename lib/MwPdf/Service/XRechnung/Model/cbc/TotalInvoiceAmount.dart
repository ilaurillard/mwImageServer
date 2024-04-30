import 'dart:convert';
import '../../Etc/Util.dart';
import 'package:xml/xml.dart';

// A number of monetary units specified using a given unit of currency.
class TotalInvoiceAmount {

  final double value; // (decimal)

  // The currency of the amount.
  final String currencyID; // (normalizedString)

  // The VersionID of the UN/ECE Rec9 code list.
  final String? currencyCodeListVersionID; // (normalizedString)

  TotalInvoiceAmount ({
    required this.value,
    required this.currencyID,
    this.currencyCodeListVersionID,
  }) {
    assert(currencyID.isNotEmpty);
  }

  static TotalInvoiceAmount? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return TotalInvoiceAmount (
      value: double.tryParse(json['value'].toString()) ?? 0,
      currencyID: json['currencyID'] as String? ?? '',
      currencyCodeListVersionID: json['currencyCodeListVersionID'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'value': value.toString(),
      'currencyID': currencyID.toString(),
      'currencyCodeListVersionID': currencyCodeListVersionID.toString(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static TotalInvoiceAmount? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return TotalInvoiceAmount (
      value: double.tryParse(xml.innerText.toString()) ?? 0,
      currencyID: xml.getAttribute('currencyID') ?? '',
      currencyCodeListVersionID: xml.getAttribute('currencyCodeListVersionID'),
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      XmlText(value.toString()),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [

      XmlAttribute(XmlName('currencyID'), currencyID.toString(),),
      currencyCodeListVersionID != null ? XmlAttribute(XmlName('currencyCodeListVersionID'), currencyCodeListVersionID.toString(),) : null,

    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'TotalInvoiceAmount',
        'cbc',
      ),
      attributes,
      children,
    );
  }
}

