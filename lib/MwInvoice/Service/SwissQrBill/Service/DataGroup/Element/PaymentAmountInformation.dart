import 'package:intl/intl.dart';
import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

import '../SelfValidatableInterface.dart';

final class PaymentAmountInformation
    implements QrCodeableInterface, SelfValidatableInterface {
  // use SelfValidatableTrait;

  // ignore: constant_identifier_names
  static const String CURRENCY_CHF = 'CHF';
  // ignore: constant_identifier_names
  static const String CURRENCY_EUR = 'EUR';

  //
  /// The payment amount due
  final double? amount;

  /// Payment currency code (ISO 4217)
  final String currency;

  NumberFormat formatter = NumberFormat.currency(
    decimalDigits: 2,
    symbol: '',
    customPattern: '#,##0.00',
  );

  PaymentAmountInformation({
    this.amount,
    required this.currency,
  });

  String getFormattedAmount({String sep = ' '}) {
    if (null == amount) {
      return '';
    }

    return formatter.format(amount).replaceAll(',', sep);
  }

  @override
  List<String> getQrCodeData() {
    String amountOutput;

    if (null != amount) {
      amountOutput = getFormattedAmount(sep: '');
    } else {
      amountOutput = '';
    }

    return [amountOutput, currency];
  }

  @override
  List<String> errors() {
    List<String> errors = [];

    if (amount != null && (amount! < 0 || amount! > 999999999.99)) {
      errors.add('Invalid amount');
    }

    if (currency != PaymentAmountInformation.CURRENCY_CHF &&
        currency != PaymentAmountInformation.CURRENCY_EUR) {
      errors.add('Invalid currency');
    }

    return errors;
  }

  static PaymentAmountInformation fromJson(
    Dict json,
  ) {
    return PaymentAmountInformation(
      amount: double.tryParse(json['amount'].toString()),
      currency: json['currency'] as String? ?? '',
    );
  }
}
