import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/PdfWidget.dart';

class Footer {
  final Dict json;

  Footer({
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

  static Footer fromJson(
    Dict json,
  ) {
    return Footer(
      json: json,
    );
  }

  static Map<String, Footer> fromJsonAll(
    Dict json,
  ) {
    return json.map((k, v) {
      return MapEntry(
          k,
          Footer.fromJson(
            v as Dict,
          ));
    });
  }
}
