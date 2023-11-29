import 'package:collection/collection.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';

class Barcode {
  static pw.BarcodeWidget barcode(
    Dict json,
      State state,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());
    double? textPadding = double.tryParse(json['textPadding'].toString());

    return pw.BarcodeWidget(
      data: json['value'] as String? ?? '',
      color: Util.color(json['color'] as String?) ?? PdfColors.black,
      backgroundColor: Util.color(json['backgroundColor'] as String?),
      decoration: Util.boxDecoration((json['decoration'] as Dict?) ?? {},
        state,
      ),
      textStyle: Util.textStyle((json['textStyle'] as Dict?) ?? {}, state,),
      barcode: pw.Barcode.fromType(type(json['barcode'] as String?)),
      drawText: json['drawText'] as bool? ?? true,
      textPadding: textPadding != null ? textPadding * PdfPageFormat.mm : 0,
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      margin: Util.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: Util.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
    );
  }

  static pw.BarcodeType type(
    String? type,
  ) {
    return pw.BarcodeType.values.firstWhereOrNull((e) => e.name == type) ??
        pw.BarcodeType.QrCode;
  }
}
