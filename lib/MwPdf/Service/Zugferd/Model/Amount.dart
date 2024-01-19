import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class Amount {
  final String value;
  final String? currency;
  Amount({
    required this.value,
    this.currency,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        builder.text(value);
        builder.attribute('currencyID', currency);
      },
    );
  }

  static Amount? fromJson(Dict json)
  {
    if (json.isNotEmpty) {
      return Amount(
        value: json['value'] as String? ?? '0',
        currency: json['currency'] as String?,
      );
    }
    return null;
  }

  static Amount empty() {
    return Amount(value: '0');
  }
}
