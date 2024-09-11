import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class DocumentContextParameter {
  final String id;

  DocumentContextParameter({
    required this.id,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'ram:GuidelineSpecifiedDocumentContextParameter',
      nest: () {
        builder.element(
          'ram:ID',
          nest: () {
            builder.text(id);
          },
        );
      },
    );
  }

  static DocumentContextParameter? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return DocumentContextParameter(
      id: xml.findElements('ram:ID').singleOrNull?.innerText ?? '',
    );
  }

  static DocumentContextParameter fromJson(
    Dict json,
  ) {
    return DocumentContextParameter(
      id: json['id'] as String? ?? '?',
    );
  }
}
