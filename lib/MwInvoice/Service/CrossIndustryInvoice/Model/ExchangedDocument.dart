import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DateTime.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Note.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class ExchangedDocument {
  final String id;
  final String? name;
  final String typeCode;
  final DateTime issueDateTime;
  final List<String> languageId;
  final List<Note> notes;

  // EffectiveSpecifiedPeriod?
  // CopyIndicator?

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

  static ExchangedDocument? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return ExchangedDocument(
      id: xml.findElements('ram:ID').singleOrNull?.innerText ?? '',
      typeCode: xml.findElements('ram:TypeCode').singleOrNull?.innerText ?? '',
      issueDateTime:
          DateTime.fromXml(xml.findElements('ram:IssueDateTime').singleOrNull)!,
      name: xml.findElements('ram:Name').singleOrNull?.innerText,
      languageId: xml
          .findElements('ram:LanguageID')
          .map((XmlElement e) => e.innerText)
          .toList(),
      notes: xml
          .findElements('ram:IncludedNote')
          .map((XmlElement e) => Note.fromXml(e)!)
          .toList(),
    );
  }

  static ExchangedDocument fromJson(
    Dict json,
  ) {
    return ExchangedDocument(
      id: json['id'] as String? ?? '?',
      name: json['name'] as String?,
      typeCode: json['typeCode'] as String? ?? '?',
      issueDateTime: DateTime.fromJson(json['issueDateTime'] as Dict? ?? {}) ??
          DateTime.empty(),
      languageId: (json['languageId'] as List<dynamic>? ?? [])
          .map((dynamic e) => e as String? ?? '')
          .toList(),
      notes: (json['notes'] as List<dynamic>? ?? [])
          .map((dynamic e) => Note.fromJson(e as Dict))
          .toList(),
    );
  }
}
