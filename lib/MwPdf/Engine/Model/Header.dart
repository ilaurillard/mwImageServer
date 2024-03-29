import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/Widget.dart';

class Header {
  final Dict json;

  Header({
    required this.json,
  });

  pw.Widget build(
    pw.Context context,
    State state,
  ) {
    state.pageNumber = context.pageNumber;
    state.pagesCount = context.pagesCount;
    return Widget(
      json: json,
    ).build(
      state,
    );
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
