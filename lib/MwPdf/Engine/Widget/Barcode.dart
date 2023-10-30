import 'package:collection/collection.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';

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
      color: Etc.color(json['color'] as String?) ?? PdfColors.black,
      backgroundColor: Etc.color(json['backgroundColor'] as String?),
      decoration: Etc.boxDecoration((json['decoration'] as Dict?) ?? {}),
      textStyle: Etc.textStyle((json['textStyle'] as Dict?) ?? {}, state,),
      barcode: pw.Barcode.fromType(type(json['barcode'] as String?)),
      drawText: json['drawText'] as bool? ?? true,
      textPadding: textPadding != null ? textPadding * PdfPageFormat.mm : 0,
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      margin: Etc.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      padding: Etc.edgeInsets(
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
