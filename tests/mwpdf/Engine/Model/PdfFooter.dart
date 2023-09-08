import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/PdfWidget.dart';

class PdfFooter {
  final Dict json;

  PdfFooter({
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

  static PdfFooter fromJson(
    Dict json,
  ) {
    return PdfFooter(
      json: json,
    );
  }

  static Map<String, PdfFooter> fromJsonAll(
    Dict json,
  ) {
    return json.map((k, v) {
      return MapEntry(
          k,
          PdfFooter.fromJson(
            v as Dict,
          ));
    });
  }
}
