import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class Quantity {
  final String unitCode;
  final String value;

  Quantity({
    required this.unitCode,
    required this.value,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        builder.text(value);
        if (unitCode.isNotEmpty) {
          builder.attribute(
            'unitCode',
            unitCode,
          );
        }
      },
    );
  }

  static Quantity? fromXml(
      XmlElement? xml,
      ) {
    if (xml == null) {
      return null;
    }
    return Quantity(
      unitCode: xml.getAttribute('unitCode') ?? '',
      value: xml.innerText,
    );
  }

  static Quantity? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return Quantity(
        unitCode: json['unitCode'] as String? ?? '',
        value: json['value'] as String? ?? '0',
      );
    }
    return null;
  }

  static Quantity empty() {
    return Quantity(
      unitCode: '',
      value: '0',
    );
  }
}
