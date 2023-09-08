import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/PdfWidget.dart';

class PdfHeader {
  final Dict json;

  PdfHeader({
    required this.json,
  });

  pw.Widget build(
    pw.Context context,
  ) {
    return PdfWidget(
      json: json,
      context: context,
      pageNumber: context.pageNumber,
      pagesCount: context.pagesCount,
    ).build();
  }

  static PdfHeader fromJson(
    Dict json,
  ) {
    return PdfHeader(
      json: json,
    );
  }

  static Map<String, PdfHeader> fromJsonAll(
    Dict json,
  ) {
    return json.map((k, v) {
      return MapEntry(
          k,
          PdfHeader.fromJson(
            v as Dict,
          ));
    });
  }
}
