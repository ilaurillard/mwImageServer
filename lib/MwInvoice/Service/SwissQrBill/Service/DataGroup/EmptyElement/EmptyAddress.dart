import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class EmptyAddress implements QrCodeableInterface {
  static const String ADDRESS_TYPE = '';

  List<String> getQrCodeData() {
    return [
      EmptyAddress.ADDRESS_TYPE,
      '',
      '',
      '',
      '',
      '',
      '',
    ];
  }
}
