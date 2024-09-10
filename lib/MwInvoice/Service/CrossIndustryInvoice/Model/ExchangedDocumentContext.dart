import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DocumentContextParameter.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class ExchangedDocumentContext {
  final DocumentContextParameter parameter;

  ExchangedDocumentContext({
    required this.parameter,
  });

  void toXml(
    XmlBuilder builder,
  ) {
    builder.element(
      'rsm:ExchangedDocumentContext',
      nest: () {
        parameter.toXml(builder);
      },
    );
  }

  static ExchangedDocumentContext fromJson(Dict json) {
    return ExchangedDocumentContext(
      parameter: DocumentContextParameter.fromJson(
          json['parameter'] as Dict? ?? {}),
    );
  }
}
