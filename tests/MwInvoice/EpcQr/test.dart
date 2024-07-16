import 'package:mwcdn/MwInvoice/Service/EpcQr/Service/EpcQr.dart';

Future<void> main() async {
  EpcQr epcQr = EpcQr(
    iban: 'at 611904 3002345 73201',
    beneficiaryName: 'Peter',
    amount: 123123
  );

  String qr = epcQr.qrString();
  if (qr.isEmpty) {
    print(epcQr.errors);
  }
  else {
    print(qr);
  }

}
