import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/Id.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TaxRegistration.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeAddress.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeContact.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeParty {
  final Id? id;
  final List<Id> globalID;
  final String name;
  final TradeContact? tradeContact;
  final TradeAddress? tradeAddress;
  final List<TaxRegistration> taxRegistrations;

  TradeParty({
    this.id,
    this.globalID = const [],
    required this.name,
    this.tradeContact,
    this.tradeAddress,
    this.taxRegistrations = const [],
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

  static TradeParty? fromJson(Dict json) {
    if (json.isNotEmpty) {
      return TradeParty(
        id: Id.fromJson(json['id'] as Dict? ?? {}),
        globalID: (json['globalID'] as List<dynamic>? ?? [])
            .map((dynamic e) => Id.fromJson(e as Dict) ?? Id.empty())
            .toList(),
        name: json['name'] as String? ?? '?',
        tradeContact:
            TradeContact.fromJson(json['tradeContact'] as Dict? ?? {}),
        tradeAddress:
            TradeAddress.fromJson(json['tradeAddress'] as Dict? ?? {}),
        taxRegistrations: (json['taxRegistrations'] as List<dynamic>? ?? [])
            .map((dynamic e) => TaxRegistration.fromJson(e as Dict))
            .toList(),
      );
    }
    return null;
  }

  static TradeParty empty() {
    return TradeParty(name: '?');
  }
}
