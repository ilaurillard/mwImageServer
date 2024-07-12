import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/DataGroup/QrCodeableInterface.dart';

final class EmptyLine implements QrCodeableInterface {
  @override
  List<String> getQrCodeData() {
    return [''];
  }
}
