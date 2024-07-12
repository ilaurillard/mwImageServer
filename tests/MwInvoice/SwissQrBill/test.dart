import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/QrBill.dart';

Future<void> main() async {
  // QrCode code = QrCode(
  //   data: 'xxx@€"',
  //   fileFormat: '',
  //   replacements: {'€' : 'EUR'}
  // );

  QrBill bill = QrBill.example();

  print(bill.errors());

  // print(bill.getQrCodeContent());
}
