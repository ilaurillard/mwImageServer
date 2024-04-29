import '../cac/EmbeddedDocumentBinaryObject.dart';
import '../cac/ExternalReference.dart';

// A class to describe an attached document. An attachment can refer to an external document or be included with the document being exchanged.
class Attachment {


  // A binary large object containing an attached document.
  final EmbeddedDocumentBinaryObject? embeddedDocumentBinaryObject;

  // A reference to an attached document that is external to the document(s) being exchanged.
  final ExternalReference? externalReference;

  Attachment ({
    this.embeddedDocumentBinaryObject,
    this.externalReference,
  });
}

