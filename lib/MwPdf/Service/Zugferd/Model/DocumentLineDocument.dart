import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Note.dart';
import 'package:xml/src/xml/builder.dart';

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
}
