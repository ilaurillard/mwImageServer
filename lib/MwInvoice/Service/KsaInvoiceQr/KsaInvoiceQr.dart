import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/MwMs/Etc/Types.dart';

class KsaInvoiceQr {
  final String sellerName;
  final String sellerTRN;
  final String vatPrice;
  final String totalWithVat;

  const KsaInvoiceQr({
    required this.sellerName,
    required this.sellerTRN,
    required this.vatPrice,
    required this.totalWithVat,
  });

  String value() {
    DateTime dateTime = DateTime.now();
    String invoiceDate = dateTime.toString();
    //
    BytesBuilder bytesBuilder = BytesBuilder();
    // 1. Seller Name
    bytesBuilder.addByte(1);
    Uint8List sellerNameBytes = utf8.encode(sellerName);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);
    // 2. VAT Registration
    bytesBuilder.addByte(2);
    Uint8List vatRegistrationBytes = utf8.encode(sellerTRN);
    bytesBuilder.addByte(vatRegistrationBytes.length);
    bytesBuilder.add(vatRegistrationBytes);
    // 3. Time
    bytesBuilder.addByte(3);
    Uint8List time = utf8.encode(invoiceDate);
    bytesBuilder.addByte(time.length);
    bytesBuilder.add(time);
    // 4. total with vat
    bytesBuilder.addByte(4);
    Uint8List p1 = utf8.encode(totalWithVat);
    bytesBuilder.addByte(p1.length);
    bytesBuilder.add(p1);
    // 5.  vat
    bytesBuilder.addByte(5);
    Uint8List p2 = utf8.encode(vatPrice);
    bytesBuilder.addByte(p2.length);
    bytesBuilder.add(p2);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    return Base64Encoder().convert(qrCodeAsBytes);
  }

  static KsaInvoiceQr fromJson(
    Dict json,
  ) {
    return KsaInvoiceQr(
      sellerName: json['sellerName'] as String? ?? '',
      sellerTRN: json['sellerTRN'] as String? ?? '',
      vatPrice: json['vatPrice'] as String? ?? '',
      totalWithVat: json['totalWithVat'] as String? ?? '',
    );
  }
}
