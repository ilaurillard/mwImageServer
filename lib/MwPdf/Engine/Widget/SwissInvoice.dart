import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/QrBill.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SwissInvoice {
  static pw.BarcodeWidget swissInvoice(
    Dict json,
    State state,
  ) {
    QrBill bill = QrBill.example();

    return pw.BarcodeWidget(
      data: bill.getQrCodeContent(),
      barcode: pw.Barcode.fromType(
        pw.BarcodeType.QrCode,
      ),
      width: 50 * PdfPageFormat.mm,
      height: 50 * PdfPageFormat.mm,
    );
  }
}
