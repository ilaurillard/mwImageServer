import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ProcuringProject.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeParty.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

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

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
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
        sellerTradeParty.toXml(
          builder,
          'ram:SellerTradeParty',
        );
        buyerTradeParty.toXml(
          builder,
          'ram:BuyerTradeParty',
        );
        if (buyerOrderReferencedDocument != null) {
          buyerOrderReferencedDocument!.toXml(
            builder,
            'ram:BuyerOrderReferencedDocument',
          );
        }
        for (ReferencedDocument d in additionalReferencedDocuments) {
          d.toXml(
            builder,
            'ram:AdditionalReferencedDocument',
          );
        }
        if (specifiedProcuringProject != null) {
          specifiedProcuringProject!.toXml(
            builder,
            'ram:SpecifiedProcuringProject',
          );
        }
      },
    );
  }

  static HeaderTradeAgreement fromJson(Dict json) {
    return HeaderTradeAgreement(
      buyerReference: json['buyerReference'] as String?,
      buyerTradeParty: TradeParty.fromJson(
            json['buyerTradeParty'] as Dict? ?? {},
          ) ??
          TradeParty.empty(),
      sellerTradeParty:
          TradeParty.fromJson(json['sellerTradeParty'] as Dict? ?? {}) ??
              TradeParty.empty(),
      buyerOrderReferencedDocument: ReferencedDocument.fromJson(
          json['buyerOrderReferencedDocument'] as Dict? ?? {}),
      additionalReferencedDocuments:
          (json['additionalReferencedDocuments'] as List<dynamic>? ?? [])
              .map((dynamic e) =>
                  ReferencedDocument.fromJson(e as Dict) ??
                  ReferencedDocument.empty())
              .toList(),
      specifiedProcuringProject: ProcuringProject.fromJson(
          json['specifiedProcuringProject'] as Dict? ?? {}),
    );
  }
}
