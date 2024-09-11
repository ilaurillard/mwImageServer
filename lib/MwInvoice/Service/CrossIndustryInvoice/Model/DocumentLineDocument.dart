import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Note.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class DocumentLineDocument {
  final String lineId;
  final List<Note> notes;

  DocumentLineDocument({
    required this.lineId,
    this.notes = const [],
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'ram:LineID',
      nest: () {
        builder.text(lineId);
      },
    );

    for (Note n in notes) {
      n.toXml(
        builder,
        'ram:IncludedNote',
      );
    }
  }

  static DocumentLineDocument? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return DocumentLineDocument(
      lineId: Util.innerTextOf(xml, 'ram:LineID') ?? '',
      notes: xml
          .findElements('ram:IncludedNote')
          .map(
            (XmlElement e) => Note.fromXml(e)!,
          )
          .toList(),
    );
  }

  static DocumentLineDocument? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return DocumentLineDocument(
        lineId: json['lineId'] as String? ?? '?',
        notes: (json['notes'] as List<dynamic>? ?? [])
            .map((dynamic e) => Note.fromJson(e as Dict))
            .toList(),
      );
    }
    return null;
  }
}
