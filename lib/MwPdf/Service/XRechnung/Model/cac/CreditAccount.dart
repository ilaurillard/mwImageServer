import '../../Etc/Util.dart';
import 'package:xml/xml.dart';
import '../cbc/AccountID.dart';
import '../ext/UBLExtensions.dart';

// A class to identify a credit account for sales on account.
class CreditAccount {


  // An identifier for this credit account.
  final AccountID accountID;

  // A container for extensions foreign to the document.
  final UBLExtensions? uBLExtensions;

  CreditAccount ({
    required this.accountID,
    this.uBLExtensions,
  });

  static CreditAccount? fromJson(Map<String, dynamic>? json) {
    if (json == null) { return null; }
    return CreditAccount (
      uBLExtensions: UBLExtensions.fromJson(json['uBLExtensions'] as Map<String, dynamic>?),
      accountID: AccountID.fromJson(json['accountID'] as Map<String, dynamic>?)!,
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'uBLExtensions': uBLExtensions?.toJson(),
      'accountID': accountID.toJson(),
    };
    map.removeWhere((String key, dynamic value) => value == null || (value is List && value.isEmpty));
    return map;
  }

  static CreditAccount? fromXml(XmlElement? xml) {
    if (xml == null) { return null; }
    return CreditAccount (
      uBLExtensions: UBLExtensions.fromXml(xml.findElements('ext:UBLExtensions').singleOrNull),
      accountID: AccountID.fromXml(xml.findElements('cbc:AccountID').singleOrNull)!,
    );
  }

  XmlNode toXml() {

    List<XmlNode?> c2 = [
      uBLExtensions?.toXml(),
      accountID.toXml(),

    ];
    c2.removeWhere((e) => e == null);
    List<XmlNode> children = c2.cast<XmlNode>().toList();

    List<XmlAttribute?> a2 = [


    ];
    a2.removeWhere((e) => e == null);
    List<XmlAttribute> attributes = a2.cast<XmlAttribute>().toList();

    return XmlElement(
      XmlName(
        'CreditAccount',
        'cac',
      ),
      attributes,
      children,
    );
  }
}

