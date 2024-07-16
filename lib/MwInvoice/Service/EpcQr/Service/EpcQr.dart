import 'package:iban/iban.dart';
import 'package:intl/intl.dart';
import 'package:mwcdn/MwInvoice/Service/EpcQr/Service/CharacterSet.dart';
import 'package:mwcdn/MwInvoice/Service/EpcQr/Service/Purpose.dart';
import 'package:mwcdn/MwInvoice/Service/StringModifier.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

class EpcQr {
  final String iban;
  final int characterSet;
  final String bic;
  final String beneficiaryName;
  final double amount;
  final String purpose;
  final String creditorReference;
  final String remittanceText;
  final String information;
  final String currency;

  List<String> errors = [];

  NumberFormat formatter = NumberFormat.currency(
    decimalDigits: 2,
    symbol: '',
    customPattern: '#,##0.00',
  );

  EpcQr({
    required this.iban,
    required this.beneficiaryName,
    this.bic = '',
    this.creditorReference = '',
    this.remittanceText = '',
    this.information = '',
    this.purpose = '',
    this.amount = 0.0,
    this.characterSet = CharacterSet.UTF_8,
    this.currency = 'EUR',
  });

  String qrString() {
    if (!validate()) {
      return '';
    }

    List<String> result = [];

    result.add('BCD');
    result.add('002');
    result.add(characterSet.toString());
    result.add('SCT');
    result.add(StringModifier.stripWhitespace(bic).toUpperCase());
    result.add(StringModifier.stripWhitespace(beneficiaryName));
    result.add(StringModifier.stripWhitespace(iban).toUpperCase());
    result.add(
        currency.toUpperCase() + formatter.format(amount).replaceAll(',', ''));
    result.add(StringModifier.stripWhitespace(purpose));
    result.add(StringModifier.stripWhitespace(creditorReference).toUpperCase());
    result.add(StringModifier.stripWhitespace(remittanceText));
    result.add(StringModifier.stripWhitespace(information));

    String data = result.join('\n');

    int byteLength = data.codeUnits.length * 2;
    if (byteLength > 331) {
      errors.add(
        'The resulting QR string is limited to 331 bytes, yours has {$byteLength} bytes',
      );
      return '';
    }

    return data;
  }

  void _checkLength(
    String what,
    String string,
    int max,
    int min,
  ) {
    if (string.length > max) {
      errors.add('Overflow ($max) $what');
    }
    if (string.length < min) {
      errors.add('Underflow ($min) $what');
    }
  }

  bool validate() {
    errors = [];

    if (amount < 0.0 || amount > 999999999.99) {
      errors.add('Amount error');
    }
    _checkLength(
      'beneficiaryName',
      beneficiaryName,
      70,
      1,
    );
    if (bic.isNotEmpty) {
      _checkLength('bic', bic, 11, 8);
    }
    _checkLength('purpose', purpose, 4, 0);
    _checkLength('creditorReference', creditorReference, 35, 0);
    _checkLength('information', information, 70, 0);
    _checkLength('remittanceText', remittanceText, 140, 0);
    _checkLength('currency', currency, 3, 3);
    if (remittanceText.isNotEmpty && creditorReference.isNotEmpty) {
      errors.add(
          'Only creditor reference or remittance text or neither can be set but not both');
    }
    if (!CharacterSet.valid.contains(characterSet)) {
      errors.add('Invalid characterSet');
    }
    if (purpose.isNotEmpty && !Purpose.valid.contains(purpose)) {
      errors.add('Invalid purpose');
    }
    if (!isValid(iban)) {
      errors.add('Invalid iban');
    }

    return errors.isEmpty;
  }

  static EpcQr fromJson(
    Dict json,
  ) {



    return EpcQr(
        iban: 'at 611904 3002345 73201',
        beneficiaryName: 'Peter',
        amount: 123123
    );
  }
}
