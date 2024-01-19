import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DateTime.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Note.dart';
import 'package:xml/src/xml/builder.dart';

class ExchangedDocument {
  final String id;
  final String? name;
  final String typeCode;
  final DateTime issueDateTime;
  final List<String> languageId;
  final List<Note> notes;

  ExchangedDocument({
    required this.id,
    this.name,
    required this.typeCode,
    required this.issueDateTime,
    this.languageId = const [],
    this.notes = const [],
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'rsm:ExchangedDocument',
      nest: () {
        builder.element(
          'ram:ID',
          nest: () {
            builder.text(id);
          },
        );
        if (name != null) {
          builder.element(
            'ram:Name',
            nest: () {
              builder.text(name!);
            },
          );
        }
        builder.element(
          'ram:TypeCode',
          nest: () {
            builder.text(typeCode);
          },
        );
        issueDateTime.toXml(
          builder,
          'ram:IssueDateTime',
        );
        for (String l in languageId) {
          builder.element(
            'ram:LanguageID',
            nest: () {
              builder.text(l);
            },
          );
        }
        for (Note n in notes) {
          n.toXml(
            builder,
            'ram:IncludedNote',
          );
        }
      },
    );
  }
}
