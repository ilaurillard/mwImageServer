import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/PdfWidget.dart';

class Header {
  final Dict json;

  Header({
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

  static Header fromJson(
    Dict json,
  ) {
    return Header(
      json: json,
    );
  }

  static Map<String, Header> fromJsonAll(
    Dict json,
  ) {
    return json.map((k, v) {
      return MapEntry(
          k,
          Header.fromJson(
            v as Dict,
          ));
    });
  }
}
