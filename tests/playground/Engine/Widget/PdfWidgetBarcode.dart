import 'package:collection/collection.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidgetUtil.dart';

class PdfWidgetBarcode {
  static pw.BarcodeWidget barcode(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    double? textPadding = double.tryParse(json['textPadding'].toString());

    // TODO
    return pw.BarcodeWidget(
      // TODO
      data: '1234123412344',

      decoration: PdfWidgetUtil.decoration((json['decoration'] as Dict?) ?? {}),
      textStyle: PdfWidgetUtil.textStyle((json['textStyle'] as Dict?) ?? {}),
      barcode: pw.Barcode.fromType(type(json['barcode'] as String?)),
      drawText: json['drawText'] as bool? ?? true,
      textPadding: textPadding != null ? textPadding * PdfPageFormat.mm : 0,
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      margin: PdfWidgetUtil.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: PdfWidgetUtil.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      color: PdfWidgetUtil.color(json['color'] as String?) ?? PdfColors.black,
      backgroundColor: PdfWidgetUtil.color(json['backgroundColor'] as String?),
    );
  }

  static pw.BarcodeType type(
    String? type,
  ) {
    return pw.BarcodeType.values.firstWhereOrNull((e) => e.name == type) ??
        pw.BarcodeType.QrCode;
  }
}
