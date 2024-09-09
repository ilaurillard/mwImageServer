import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class Indicator {
  final bool indicator;

  Indicator({
    required this.indicator,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        builder.element(
          'udt:Indicator',
          nest: () {
            builder.text(
              indicator ? 'true' : 'false',
            );
          },
        );
      },
    );
  }

  static Indicator? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return Indicator(
        indicator: json['indicator'] as bool? ?? false,
      );
    }
    return null;
  }
}
