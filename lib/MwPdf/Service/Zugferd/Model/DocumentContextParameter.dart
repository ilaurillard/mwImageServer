import 'package:xml/src/xml/builder.dart';

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
}
