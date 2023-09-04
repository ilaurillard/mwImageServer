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
      context: context,
      json: json,
    ).build();
    // return pw.Text('FOOTER Page: ${context.pageNumber}');
  }

  static PdfFooter fromJson(
    Dict json,
  ) {
    // print('Footer: $json');

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
