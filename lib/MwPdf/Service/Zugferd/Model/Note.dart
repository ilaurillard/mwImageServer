import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
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
        Util.stringElement(builder, contentCode, 'ram:ContentCode');
        Util.stringElement(builder, content, 'ram:Content');
        Util.stringElement(builder, subjectCode, 'ram:SubjectCode');
      },
    );
  }
}
