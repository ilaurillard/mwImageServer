import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ExchangedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ExchangedDocumentContext.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/SupplyChainTradeTransaction.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class CrossIndustryInvoice {
  final ExchangedDocumentContext documentContext;
  final ExchangedDocument document;
  final SupplyChainTradeTransaction tradeTransaction;

  CrossIndustryInvoice({
    required this.documentContext,
    required this.document,
    required this.tradeTransaction,
  });

  XmlDocument toXml() {
    XmlBuilder builder = XmlBuilder();
    builder.processing('xml', 'version="1.0" encoding="utf-8"');
    builder.element(
      'rsm:CrossIndustryInvoice',
      namespaces: {
        'urn:un:unece:uncefact:data:standard:ReusableAggregateBusinessInformationEntity:100':
            'ram',
        'http://www.w3.org/2001/XMLSchema': 'xs',
        'urn:un:unece:uncefact:data:standard:UnqualifiedDataType:100': 'udt',
        'urn:un:unece:uncefact:data:standard:QualifiedDataType:100': 'qdt',
        'urn:un:unece:uncefact:data:standard:CrossIndustryInvoice:100': 'rsm',
      },
      nest: () {
        documentContext.toXml(builder);
        document.toXml(builder);
        tradeTransaction.toXml(builder);
      },
    );

    return builder.buildDocument();
  }

  static CrossIndustryInvoice fromJson(Dict json) {
    return CrossIndustryInvoice(
      documentContext: ExchangedDocumentContext.fromJson(
        json['documentContext'] as Dict? ?? {},
      ),
      document: ExchangedDocument.fromJson(
        json['document'] as Dict? ?? {},
      ),
      tradeTransaction: SupplyChainTradeTransaction.fromJson(
        json['tradeTransaction'] as Dict? ?? {},
      ),
    );
  }
}
