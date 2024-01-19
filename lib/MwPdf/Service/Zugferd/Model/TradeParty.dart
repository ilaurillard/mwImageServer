import 'package:mwcdn/MwPdf/Service/Zugferd/Model/Id.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TaxRegistration.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeAddress.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeContact.dart';
import 'package:xml/src/xml/builder.dart';

class TradeParty {
  final Id? id;
  final List<Id> globalID;
  final String name;
  final TradeContact? definedTradeContact;
  final TradeAddress? postalTradeAddress;
  final List<TaxRegistration> taxRegistrations;

  TradeParty({
    this.id,
    this.globalID = const [],
    required this.name,
    this.definedTradeContact,
    this.postalTradeAddress,
    this.taxRegistrations = const [],
  });

  void toXml(XmlBuilder builder, String name) {
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
        if (definedTradeContact != null) {
          definedTradeContact!.toXml(builder, 'ram:DefinedTradeContact');
        }
        if (postalTradeAddress != null) {
          postalTradeAddress!.toXml(builder, 'ram:PostalTradeAddress');
        }
        for (TaxRegistration t in taxRegistrations) {
          t.toXml(builder, 'ram:SpecifiedTaxRegistration');
        }
      },
    );
  }
}
