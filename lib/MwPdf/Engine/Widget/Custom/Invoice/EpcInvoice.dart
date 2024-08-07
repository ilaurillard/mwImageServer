import 'package:mwcdn/MwInvoice/Service/EpcQr/Service/EpcQr.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class EpcInvoice {
  static pw.Widget build(
    Dict json,
    State state,
  ) {
    EpcQr epcQr = EpcQr.fromJson(json);

    String tmp = epcQr.qrString();
    if (tmp.isEmpty) {
      print(
        'Invalid epc qr bill: ${epcQr.errors.join(' / ')}',
      );
      return pw.Container();
    }

    pw.Widget qr = _qr(
      epcQr: epcQr,
    );

    return pw.SizedBox(
      width: 54 * PdfPageFormat.mm,
      child: pw.AspectRatio(
        aspectRatio: 1.0,
        child: pw.Container(
          decoration: pw.BoxDecoration(
            border: pw.Border.all(
              width: 1 * PdfPageFormat.mm,
            ),
            borderRadius: pw.BorderRadius.all(
              pw.Radius.circular(4 * PdfPageFormat.mm),
            ),
          ),
          child: pw.Padding(
            padding: pw.EdgeInsets.all(4 * PdfPageFormat.mm),
            child: qr,
          ),
        ),
      ),
    );
  }

  static pw.Widget _qr({
    required EpcQr epcQr,
  }) {
    return pw.SizedBox(
      width: 50 * PdfPageFormat.mm,
      child: pw.AspectRatio(
        aspectRatio: 1.0,
        child: pw.BarcodeWidget(
          data: epcQr.qrString(),
          barcode: pw.Barcode.fromType(
            pw.BarcodeType.QrCode,
          ),
        ),
      ),
    );
  }
}
