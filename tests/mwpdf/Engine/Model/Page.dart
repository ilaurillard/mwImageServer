import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/PdfWidget.dart';

class Page {
  final bool multi;
  final String theme;
  final String header;
  final String footer;

  final List<dynamic> content;

  Page({
    this.multi = false,
    this.theme = '',
    this.header = '',
    this.footer = '',
    required this.content,
  });

  List<pw.Widget> build(
    pw.Context context,
  ) {
    return content
        .map(
          (e) => PdfWidget(
            json: e as Dict,
            context: context,
          ).build(),
        )
        .toList();
  }

  static Page fromJson(
    Dict json,
  ) {
    // print('Page: $json');

    return Page(
      multi: Types.boolFromDict(json, 'multi'),
      theme: json['theme'] as String? ?? '',
      header: json['header'] as String? ?? '',
      footer: json['footer'] as String? ?? '',
      content: json['content'] as List<dynamic>? ?? [],
    );
  }

  static List<Page> fromJsonAll(
    List<dynamic> json,
  ) {
    return json
        .map((i) => Page.fromJson(
              i as Dict,
            ))
        .toList();
  }
}
