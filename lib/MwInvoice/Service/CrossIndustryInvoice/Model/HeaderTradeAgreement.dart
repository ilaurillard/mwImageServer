import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ProcuringProject.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/ReferencedDocument.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeParty.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class HeaderTradeAgreement {
  final String? buyerReference;
  final TradeParty sellerTradeParty;
  final TradeParty buyerTradeParty;
  final ReferencedDocument? referencedDocument;
  final List<ReferencedDocument> additionalReferencedDocuments;
  final ProcuringProject? procuringProject;

  HeaderTradeAgreement({
    this.buyerReference,
    required this.sellerTradeParty,
    required this.buyerTradeParty,
    this.referencedDocument,
    this.additionalReferencedDocuments = const [],
    this.procuringProject,
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
        if (referencedDocument != null) {
          referencedDocument!.toXml(
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
        if (procuringProject != null) {
          procuringProject!.toXml(
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
      referencedDocument: ReferencedDocument.fromJson(
          json['referencedDocument'] as Dict? ?? {}),
      additionalReferencedDocuments:
          (json['additionalReferencedDocuments'] as List<dynamic>? ?? [])
              .map((dynamic e) =>
                  ReferencedDocument.fromJson(e as Dict) ??
                  ReferencedDocument.empty())
              .toList(),
      procuringProject: ProcuringProject.fromJson(
          json['procuringProject'] as Dict? ?? {}),
    );
  }
}
