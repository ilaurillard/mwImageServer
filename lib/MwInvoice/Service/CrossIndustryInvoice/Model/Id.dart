import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class Id {
  final String value;
  final String? schemeID;

  Id({
    required this.value,
    this.schemeID,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        builder.text(value);
        if (schemeID != null && schemeID!.isNotEmpty) {
          builder.attribute(
            'schemeID',
            schemeID!,
          );
        }
      },
    );
  }

  static Id? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return Id(
      value: xml.innerText,
      schemeID: xml.getAttribute('schemeID'),
    );
  }

  static Id empty() {
    return Id(value: '?');
  }

  static Id? fromJson(Dict json) {
    if (json.isEmpty) {
      return null;
    }
    return Id(
      value: json['value'] as String? ?? '0',
      schemeID: json['schemeID'] as String?,
    );
  }
}
