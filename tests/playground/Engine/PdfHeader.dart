import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';

class PdfHeader {
  final Dict json;

  PdfHeader({
    required this.json,
  });

  pw.Widget build(
    pw.Context context,
  ) {
    return PdfWidget(
      context: context,
      json: json,
    ).build();
  }

  static PdfHeader fromJson(
    Dict json,
  ) {
    // print('Header: $json');

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
