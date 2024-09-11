import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CreditorFinancialAccount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/CreditorFinancialInstitution.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/DebtorFinancialAccount.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Model/TradeSettlementFinancialCard.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:xml/xml.dart';

class TradeSettlementPaymentMeans {
  final String typeCode;
  final String? information;
  final CreditorFinancialAccount? payeePartyCreditorFinancialAccount;
  final CreditorFinancialInstitution?
      payeeSpecifiedCreditorFinancialInstitution;
  final DebtorFinancialAccount? payerPartyDebtorFinancialAccount;
  final TradeSettlementFinancialCard? applicableTradeSettlementFinancialCard;

  TradeSettlementPaymentMeans({
    required this.typeCode,
    this.information,
    this.payeePartyCreditorFinancialAccount,
    this.payeeSpecifiedCreditorFinancialInstitution,
    this.payerPartyDebtorFinancialAccount,
    this.applicableTradeSettlementFinancialCard,
  });

  void toXml(
    XmlBuilder builder,
    String name,
  ) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(
          builder,
          typeCode,
          'ram:TypeCode',
        );
        Util.stringElement(
          builder,
          information,
          'ram:Information',
        );
        if (payeePartyCreditorFinancialAccount != null) {
          payeePartyCreditorFinancialAccount!.toXml(
            builder,
            'ram:PayeePartyCreditorFinancialAccount',
          );
        }
        if (payeeSpecifiedCreditorFinancialInstitution != null) {
          payeeSpecifiedCreditorFinancialInstitution!.toXml(
            builder,
            'ram:PayeeSpecifiedCreditorFinancialInstitution',
          );
        }
        if (payerPartyDebtorFinancialAccount != null) {
          payerPartyDebtorFinancialAccount!.toXml(
            builder,
            'ram:PayerPartyDebtorFinancialAccount',
          );
        }
        if (applicableTradeSettlementFinancialCard != null) {
          applicableTradeSettlementFinancialCard!.toXml(
            builder,
            'ram:ApplicableTradeSettlementFinancialCard',
          );
        }
      },
    );
  }

  static TradeSettlementPaymentMeans? fromXml(
    XmlElement? xml,
  ) {
    if (xml == null) {
      return null;
    }
    return TradeSettlementPaymentMeans(
      typeCode: Util.innerTextOf(xml, 'ram:TypeCode') ?? '',
      information: Util.innerTextOf(xml, 'ram:Information'),
      payeePartyCreditorFinancialAccount: CreditorFinancialAccount.fromXml(
        xml.findElements('ram:PayeePartyCreditorFinancialAccount').singleOrNull,
      ),
      payeeSpecifiedCreditorFinancialInstitution:
          CreditorFinancialInstitution.fromXml(
        xml
            .findElements('ram:PayeeSpecifiedCreditorFinancialInstitution')
            .singleOrNull,
      ),
      payerPartyDebtorFinancialAccount: DebtorFinancialAccount.fromXml(
        xml.findElements('ram:PayerPartyDebtorFinancialAccount').singleOrNull,
      ),
      applicableTradeSettlementFinancialCard:
          TradeSettlementFinancialCard.fromXml(
        xml
            .findElements('ram:ApplicableTradeSettlementFinancialCard')
            .singleOrNull,
      ),
    );
  }

  static TradeSettlementPaymentMeans fromJson(
    Dict json,
  ) {
    return TradeSettlementPaymentMeans(
      typeCode: json['typeCode'] as String? ?? '?',
      information: json['information'] as String?,
      payeePartyCreditorFinancialAccount: CreditorFinancialAccount.fromJson(
          json['payeePartyCreditorFinancialAccount'] as Dict? ?? {}),
      payeeSpecifiedCreditorFinancialInstitution:
          CreditorFinancialInstitution.fromJson(
              json['payeeSpecifiedCreditorFinancialInstitution'] as Dict? ??
                  {}),
      payerPartyDebtorFinancialAccount: DebtorFinancialAccount.fromJson(
          json['payerPartyDebtorFinancialAccount'] as Dict? ?? {}),
      applicableTradeSettlementFinancialCard:
          TradeSettlementFinancialCard.fromJson(
              json['applicableTradeSettlementFinancialCard'] as Dict? ?? {}),
    );
  }
}
