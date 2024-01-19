import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/CreditorFinancialAccount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/CreditorFinancialInstitution.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/DebtorFinancialAccount.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Model/TradeSettlementFinancialCard.dart';
import 'package:mwcdn/MwPdf/Service/Zugferd/Util.dart';
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

  void toXml(XmlBuilder builder, String name) {
    builder.element(
      name,
      nest: () {
        Util.stringElement(builder, typeCode, 'ram:TypeCode');
        Util.stringElement(builder, information, 'ram:Information');
        if (payeePartyCreditorFinancialAccount != null) {
          payeePartyCreditorFinancialAccount!
              .toXml(builder, 'ram:PayeePartyCreditorFinancialAccount');
        }
        if (payeeSpecifiedCreditorFinancialInstitution != null) {
          payeeSpecifiedCreditorFinancialInstitution!
              .toXml(builder, 'ram:PayeeSpecifiedCreditorFinancialInstitution');
        }
        if (payerPartyDebtorFinancialAccount != null) {
          payerPartyDebtorFinancialAccount!
              .toXml(builder, 'ram:PayerPartyDebtorFinancialAccount');
        }
        if (applicableTradeSettlementFinancialCard != null) {
          applicableTradeSettlementFinancialCard!
              .toXml(builder, 'ram:ApplicableTradeSettlementFinancialCard');
        }
      },
    );
  }

  static TradeSettlementPaymentMeans fromJson(Dict json) {
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
