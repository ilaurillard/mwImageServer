import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DocumentContextParameter.dart';
import 'package:xml/xml.dart';

class ExchangedDocumentContext {
  final DocumentContextParameter documentContextParameter;

  ExchangedDocumentContext({
    required this.documentContextParameter,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'rsm:ExchangedDocumentContext',
      nest: () {
        documentContextParameter.toXml(builder);
      },
    );
  }

  static ExchangedDocumentContext fromJson(Dict json) {
    return ExchangedDocumentContext(
      documentContextParameter: DocumentContextParameter.fromJson(
          json['documentContextParameter'] as Dict? ?? {}),
    );
  }
}
