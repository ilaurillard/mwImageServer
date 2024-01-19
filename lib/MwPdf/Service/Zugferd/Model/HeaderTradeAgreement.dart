import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ProcuringProject.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeParty.dart';
import 'package:xml/src/xml/builder.dart';

class HeaderTradeAgreement {
  final String? buyerReference;
  final TradeParty sellerTradeParty;
  final TradeParty buyerTradeParty;
  final ReferencedDocument? buyerOrderReferencedDocument;
  final List<ReferencedDocument> additionalReferencedDocuments;
  final ProcuringProject? specifiedProcuringProject;

  HeaderTradeAgreement({
    this.buyerReference,
    required this.sellerTradeParty,
    required this.buyerTradeParty,
    this.buyerOrderReferencedDocument,
    this.additionalReferencedDocuments = const [],
    this.specifiedProcuringProject,
  });

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        if (buyerReference != null) {
          builder.element(
            'ram:BuyerReference',
            nest: () {
              builder.text(buyerReference!);
            },
          );
        }
        sellerTradeParty.toXml(builder, 'ram:SellerTradeParty');
        buyerTradeParty.toXml(builder, 'ram:BuyerTradeParty');
        if (buyerOrderReferencedDocument != null) {
          buyerOrderReferencedDocument!.toXml(builder, 'ram:BuyerOrderReferencedDocument');
        }
        for (ReferencedDocument d in additionalReferencedDocuments) {
          d.toXml(builder, 'ram:AdditionalReferencedDocument');
        }
        if (specifiedProcuringProject != null) {
          specifiedProcuringProject!.toXml(builder, 'ram:SpecifiedProcuringProject');
        }
      },
    );
  }
}
