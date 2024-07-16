import 'package:mwcdn/MwInvoice/Service/KsaInvoiceQr/KsaInvoiceQr.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../Barcode.dart';

class KsaInvoice {
  static pw.BarcodeWidget ksaInvoice(
    Dict json,
    State state,
  ) {
    KsaInvoiceQr ksa = KsaInvoiceQr.fromJson(json);
    Dict data = json['barcode'] as Dict? ?? {};
    data['value'] = ksa.value();
    return Barcode.barcode(
      data,
      state,
    );
  }
}
