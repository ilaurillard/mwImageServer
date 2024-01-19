import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ExchangedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ExchangedDocumentContext.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/SupplyChainTradeTransaction.dart';
import 'package:xml/xml.dart';

class CrossIndustryInvoice {
  final ExchangedDocumentContext exchangedDocumentContext;
  final ExchangedDocument exchangedDocument;
  final SupplyChainTradeTransaction supplyChainTradeTransaction;

  CrossIndustryInvoice({
    required this.exchangedDocumentContext,
    required this.exchangedDocument,
    required this.supplyChainTradeTransaction,
  });

  XmlDocument toXml() {
    XmlBuilder builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="UTF-8"');
    builder.element(
      'rsm:CrossIndustryInvoice',
      namespaces: {
        'urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100': 'rsm',
        'urn:un:unece:uncefact:data:standard:QualifiedDataType:100': 'qdt',
        'urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100':
            'ram',
        'http://www.w3.org/2001/XMLSchema': 'xs',
        'urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100': 'udt',
      },
      nest: () {
        exchangedDocumentContext.toXml(builder);
        exchangedDocument.toXml(builder);
        supplyChainTradeTransaction.toXml(builder);
      },
    );

    return builder.buildDocument();
  }
}
