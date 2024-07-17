import 'package:mwcdn/MwInvoice/Service/SwissQrBill/Service/QrBill.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Etc/Snip.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class SwissInvoice {
  static pw.Widget swissInvoice(
    Dict json,
    State state,
  ) {
    bool codeOnly = json['widget']['codeOnly'] as bool? ?? false;
    String language = json['widget']['language'] as String? ?? 'DE';

    QrBill bill = QrBill.fromJson(json);

    List<String> errors = bill.errors();
    if (errors.isNotEmpty) {
      print(
        'Invalid swiss qr bill: ${errors.join(' / ')}',
      );
      return pw.Container();
    }

    pw.Widget qr = _qr(
      bill: bill,
    );

    if (!codeOnly) {
      return pw.Column(
        children: [
          Snip.build(
            padding: pw.EdgeInsets.only(
              top: 5 * PdfPageFormat.mm,
            ),
            direction: pw.Axis.horizontal,
            offset: 48,
          ),
          pw.Row(
            mainAxisSize: pw.MainAxisSize.max,
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 61,
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(
                    7 * PdfPageFormat.mm,
                    5 * PdfPageFormat.mm,
                    5 * PdfPageFormat.mm,
                    10 * PdfPageFormat.mm,
                  ),
                  child: pw.Column(
                    // mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Paragraph(
                        text: language == 'FR' ? 'Récépissé' : 'Empfangsschein',
                        margin: pw.EdgeInsets.only(
                          bottom: 3.5 * PdfPageFormat.mm,
                        ),
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 3.88 * PdfPageFormat.mm,
                          lineSpacing: 0,
                        ),
                      ),
                      _rechnungsDaten(
                        cc: language,
                        bill: bill,
                        fs1: 2.12,
                        fs2: 2.82,
                        m1: 2.82,
                      ),
                      pw.SizedBox(
                        height: 10 * PdfPageFormat.mm,
                      ),
                      _betragsDaten(
                        cc: language,
                        bill: bill,
                        fs1: 2.12,
                        fs2: 2.82,
                      ),
                      pw.SizedBox(
                        height: 5 * PdfPageFormat.mm,
                      ),
                      pw.Align(
                        alignment: pw.Alignment.centerRight,
                        child: pw.Text(
                          language == 'FR' ? 'Point de Dépôt' : 'Annahmestelle',
                          style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 2.5 * PdfPageFormat.mm,
                            lineSpacing: 0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.SizedBox(
                height: 105 * PdfPageFormat.mm,
                width: 1 * PdfPageFormat.mm,
                child: Snip.build(
                  direction: pw.Axis.vertical,
                  offset: 10.0,
                ),
              ),
              pw.Expanded(
                flex: 56,
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(
                    5 * PdfPageFormat.mm,
                    5 * PdfPageFormat.mm,
                    5 * PdfPageFormat.mm,
                    10 * PdfPageFormat.mm,
                  ),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Paragraph(
                        text: language == 'FR'
                            ? 'Section de paiement'
                            : 'Zahlteil',
                        margin: pw.EdgeInsets.only(
                          bottom: 3.5 * PdfPageFormat.mm,
                        ),
                        style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold,
                          fontSize: 3.88 * PdfPageFormat.mm,
                          lineSpacing: 0,
                        ),
                      ),
                      qr,
                      pw.SizedBox(
                        height: 5 * PdfPageFormat.mm,
                      ),
                      _betragsDaten(
                        cc: language,
                        bill: bill,
                        fs1: 2.82,
                        fs2: 3.53,
                      ),
                    ],
                  ),
                ),
              ),
              pw.Expanded(
                flex: 92,
                child: pw.Padding(
                  padding: pw.EdgeInsets.fromLTRB(
                    0 * PdfPageFormat.mm,
                    6 * PdfPageFormat.mm,
                    7 * PdfPageFormat.mm,
                    7 * PdfPageFormat.mm,
                  ),
                  child: _rechnungsDaten(
                    cc: language,
                    bill: bill,
                    fs1: 2.82,
                    fs2: 3.53,
                    m1: 3.53,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    return pw.FittedBox(
      fit: pw.BoxFit.contain,
      child: qr
    );
  }

  static pw.Widget _qr({
    required QrBill bill,
  }) {
    return pw.SizedBox(
      width: 46 * PdfPageFormat.mm,
      child: pw.AspectRatio(
        aspectRatio: 1.0,
        child: pw.Stack(
          children: [
            pw.BarcodeWidget(
              data: bill.getQrCodeContent(),
              barcode: pw.Barcode.fromType(
                pw.BarcodeType.QrCode,
              ),
            ),
            pw.SvgImage(
              svg: '<svg viewBox="0 0 53 53">'
                  '<path fill="FFFFFF" '
                  'd="M 22 22 h9 v9 h-9" />'
                  '<path fill="000000" '
                  'd="M 23 23 h7 v7 h-7" />'
                  '<path fill="FFFFFF" '
                  'd="M 24 25.8 h5 v1.4 h-5 M 25.8 24 h1.4 v5 h-1.4" />'
                  '</svg>',
            ),
          ],
        ),
      ),
    );
  }

  static pw.Row _betragsDaten({
    required String cc,
    required QrBill bill,
    required double fs1,
    required double fs2,
  }) {
    pw.TextStyle ts1 = pw.TextStyle(
      fontSize: fs2 * PdfPageFormat.mm,
      lineSpacing: 0,
    );

    pw.TextStyle ts2 = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: fs1 * PdfPageFormat.mm,
      lineSpacing: 0,
    );

    return pw.Row(
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                cc == 'FR' ? 'Monnaie' : 'Währung',
                style: ts2,
              ),
              pw.Text(
                bill.paymentAmountInformation?.currency ?? '',
                style: ts1,
              ),
            ],
          ),
        ),
        pw.Expanded(
          flex: 5,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                cc == 'FR' ? 'Montant' : 'Betrag',
                style: ts2,
              ),
              pw.Text(
                bill.paymentAmountInformation?.getFormattedAmount() ?? '',
                style: ts1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  static pw.Column _rechnungsDaten({
    required String cc,
    required QrBill bill,
    required double fs1,
    required double fs2,
    required double m1,
  }) {
    pw.TextStyle ts1 = pw.TextStyle(
      fontSize: fs2 * PdfPageFormat.mm,
      lineSpacing: 0,
    );

    pw.TextStyle ts2 = pw.TextStyle(
      fontWeight: pw.FontWeight.bold,
      fontSize: fs1 * PdfPageFormat.mm,
      lineSpacing: 0,
    );

    pw.EdgeInsets mrg1 = pw.EdgeInsets.only(
      bottom: m1 * PdfPageFormat.mm,
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          cc == 'FR' ? 'Compte / Payable à' : 'Konto / Zahlbar an',
          style: ts2,
        ),
        pw.Paragraph(
          textAlign: pw.TextAlign.left,
          text: bill.creditorInformation?.getFormattedIban(),
          margin: mrg1,
          style: ts1,
        ),
        pw.Paragraph(
          textAlign: pw.TextAlign.left,
          text: (bill.creditor?.getFullAddress(
                    forReceipt: true,
                  ) ??
                  '')
              .trim(),
          margin: mrg1,
          style: ts1,
        ),
        pw.Text(
          cc == 'FR' ? 'Référence' : 'Referenz',
          style: ts2,
        ),
        pw.Paragraph(
          textAlign: pw.TextAlign.left,
          text: bill.paymentReference?.getFormattedReference(),
          margin: mrg1,
          style: ts1,
        ),
        pw.Text(
          cc == 'FR' ? 'Payable par' : 'Zahlbar durch',
          style: ts2,
        ),
        pw.Paragraph(
          textAlign: pw.TextAlign.left,
          text: (bill.ultimateDebtor?.getFullAddress(
                    forReceipt: true,
                  ) ??
                  '')
              .trim(),
          margin: mrg1,
          style: ts1,
        ),
      ],
    );
  }
}
