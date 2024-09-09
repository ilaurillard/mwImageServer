import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeCountry {
  final String id;

  TradeCountry({
    required this.id,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'ram:ID',
      nest: () {
        builder.text(id);
      },
    );
  }

  static TradeCountry? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return TradeCountry(
        id: json['id'] as String? ?? '?',
      );
    }
    return null;
  }
}
