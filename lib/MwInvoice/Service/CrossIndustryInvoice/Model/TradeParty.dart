import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/LegalOrganization.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TaxRegistration.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAddress.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeContact.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeParty {
  final Id? id;
  final List<Id> globalID;
  final String name;
  final String? description;
  final TradeContact? tradeContact;
  final TradeAddress? tradeAddress;
  final List<TaxRegistration> taxRegistrations;
  final LegalOrganization? legalOrganization;

  TradeParty({
    this.id,
    this.globalID = const [],
    required this.name,
    this.description,
    this.tradeContact,
    this.tradeAddress,
    this.taxRegistrations = const [],
    this.legalOrganization,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        if (id != null) {
          id!.toXml(builder, 'ram:ID');
        }
        for (Id i in globalID) {
          i.toXml(builder, 'ram:GlobalID');
        }
        builder.element(
          'ram:Name',
          nest: () {
            builder.text(this.name);
          },
        );
        if (description != null) {
          builder.element(
            'ram:Description',
            nest: () {
              builder.text(description!);
            },
          );
        }
        if (legalOrganization != null) {
          legalOrganization!.toXml(
            builder,
            'ram:SpecifiedLegalOrganization',
          );
        }
        if (tradeContact != null) {
          tradeContact!.toXml(
            builder,
            'ram:DefinedTradeContact',
          );
        }
        if (tradeAddress != null) {
          tradeAddress!.toXml(
            builder,
            'ram:PostalTradeAddress',
          );
        }
        for (TaxRegistration t in taxRegistrations) {
          t.toXml(
            builder,
            'ram:SpecifiedTaxRegistration',
          );
        }

      },
    );
  }

  static TradeParty? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }

    return TradeParty(
      id: Id.fromXml(
        xml.findElements('ram:ID').singleOrNull,
      ),
      globalID: xml
          .findElements('ram:GlobalID')
          .map(
            (XmlElement e) => Id.fromXml(e)!,
          )
          .toList(),
      name: xml.findElements('ram:Name').singleOrNull?.innerText ?? '',
      description: xml.findElements('ram:Description').singleOrNull?.innerText,
      tradeContact: TradeContact.fromXml(
        xml.findElements('ram:DefinedTradeContact').singleOrNull,
      ),
      tradeAddress: TradeAddress.fromXml(
        xml.findElements('ram:PostalTradeAddress').singleOrNull,
      ),
      taxRegistrations: xml
          .findElements('ram:SpecifiedTaxRegistration')
          .map(
            (XmlElement e) => TaxRegistration.fromXml(e)!,
          )
          .toList(),
      legalOrganization: LegalOrganization.fromXml(
        xml.findElements('ram:SpecifiedLegalOrganization').singleOrNull,
      ),
    );
  }

  static TradeParty? fromJson(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      return TradeParty(
        id: Id.fromJson(json['id'] as Dict? ?? {}),
        globalID: (json['globalID'] as List<dynamic>? ?? [])
            .map((dynamic e) => Id.fromJson(e as Dict) ?? Id.empty())
            .toList(),
        name: json['name'] as String? ?? '?',
        description: json['description'] as String?,
        tradeContact:
            TradeContact.fromJson(json['tradeContact'] as Dict? ?? {}),
        tradeAddress:
            TradeAddress.fromJson(json['tradeAddress'] as Dict? ?? {}),
        taxRegistrations: (json['taxRegistrations'] as List<dynamic>? ?? [])
            .map((dynamic e) => TaxRegistration.fromJson(e as Dict))
            .toList(),
        legalOrganization: LegalOrganization.fromJson(
            json['legalOrganization'] as Dict? ?? {}),
      );
    }
    return null;
  }

  static TradeParty empty() {
    return TradeParty(name: '?');
  }
}
