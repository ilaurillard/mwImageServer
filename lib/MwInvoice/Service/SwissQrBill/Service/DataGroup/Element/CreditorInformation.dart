import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/SelfValidatableInterface.dart';
import 'package:mwcdn/MwInvoice/Service/StringModifier.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

class CreditorInformation
    implements QrCodeableInterface, SelfValidatableInterface {
  /// IBAN or QR-IBAN of the creditor
  late final String iban;

  CreditorInformation({
    required String iban,
  }) {
    this.iban = StringModifier.stripWhitespace(iban);
  }

  @override
  List<String> getQrCodeData() {
    return [
      iban,
    ];
  }

  String getFormattedIban() {
    return StringModifier.chunkSplit(iban, 4, ' ').trim();
  }

  bool containsQrIban() {
    int qrIid = int.tryParse(iban.substring(4, 5)) ?? -1;

    if (errors().isEmpty && qrIid >= 30000 && qrIid <= 31999) {
      return true;
    }

    return false;
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    if (iban.isEmpty) {
      errors.add('Missing iban');
    }

    // TODO validate IBAN

    if (!RegExp(r'^(CH|LI)').hasMatch(iban)) {
      errors.add('Only for CH/LI');
    }

    return errors;
  }

  static CreditorInformation fromJson(
    Dict json,
  ) {
    return CreditorInformation(
      iban: json['iban'] as String? ?? '',
    );
  }
}
