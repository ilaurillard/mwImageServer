import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/Widget.dart';

class Footer {
  final Dict json;

  Footer({
    required this.json,
  });

  pw.Widget build(
    pw.Context context,
    Resources resources,
  ) {
    resources.pageNumber = context.pageNumber;
    resources.pagesCount = context.pagesCount;
    return Widget(
      json: json,
    ).build(resources);
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
