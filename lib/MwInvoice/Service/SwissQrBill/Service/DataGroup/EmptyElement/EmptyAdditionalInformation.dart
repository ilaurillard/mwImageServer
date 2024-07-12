import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class EmptyAdditionalInformation implements QrCodeableInterface {
  static const String TRAILER_EPD = 'EPD';

  @override
  List<String> getQrCodeData() {
    return [
      '',
      EmptyAdditionalInformation.TRAILER_EPD,
    ];
  }
}
