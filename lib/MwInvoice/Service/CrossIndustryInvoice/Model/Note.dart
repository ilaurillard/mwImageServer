import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

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
        Util.stringElement(
          builder,
          contentCode,
          'ram:ContentCode',
        );
        Util.stringElement(
          builder,
          content,
          'ram:Content',
        );
        Util.stringElement(
          builder,
          subjectCode,
          'ram:SubjectCode',
        );
      },
    );
  }

  static Note? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return Note(
      contentCode: xml.findElements('ram:ContentCode').singleOrNull?.innerText,
      content: xml.findElements('ram:Content').singleOrNull?.innerText ?? '',
      subjectCode: xml.findElements('ram:SubjectCode').singleOrNull?.innerText,
    );
  }

  static Note fromJson(Dict json) {
    return Note(
      contentCode: json['contentCode'] as String?,
      content: json['content'] as String? ?? '?',
      subjectCode: json['subjectCode'] as String?,
    );
  }
}
