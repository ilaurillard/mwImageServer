import 'package:xml/src/xml/builder.dart';

class Note {
  final String? contentCode;
  final String content;
  final String? subjectCode;

  Note({
    required this.content,
    this.contentCode,
    this.subjectCode,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        builder.element(
          'ram:Content',
          nest: () {
            builder.text(content);
          },
        );
        if (subjectCode != null) {
          builder.element('ram:SubjectCode', nest: () {
            builder.text(subjectCode!);
          });
        }
      },
    );
  }
}
