import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class EmptyAddress implements QrCodeableInterface {
  // ignore: constant_identifier_names
  static const String ADDRESS_TYPE = '';

  @override
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
