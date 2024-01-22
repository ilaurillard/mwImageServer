import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Facturx/Model/Note.dart';
import 'package:xml/xml.dart';

class DocumentLineDocument {
  final String lineId;
  final List<Note> notes;

  DocumentLineDocument({
    required this.lineId,
    this.notes = const [],
  });

  void toXml(XmlBuilder builder) {
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

  static DocumentLineDocument fromJson(Dict json) {
    return DocumentLineDocument(
      lineId: json['lineId'] as String? ?? '?',
      notes: (json['notes'] as List<dynamic>? ?? [])
          .map((dynamic e) => Note.fromJson(e as Dict))
          .toList(),
    );
  }
}
