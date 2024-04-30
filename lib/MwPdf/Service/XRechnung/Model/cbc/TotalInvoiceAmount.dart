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
      'value': value,
      'currencyID': currencyID,
      'currencyCodeListVersionID': currencyCodeListVersionID,
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
    return XmlElement(
      XmlName(
        'TotalInvoiceAmount',
        'cbc',
      ),
    );
  }
}

