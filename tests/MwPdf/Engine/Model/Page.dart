import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/Widget.dart';

class Page {
  final bool multi;
  final String theme;
  final String header;
  final String footer;

  final int amountColumns;
  final double gapWidth;

  final List<dynamic> content;

  Page({
    this.multi = false,
    this.theme = '',
    this.header = '',
    this.footer = '',
    required this.content,
    this.amountColumns = 1,
    this.gapWidth = 10,
  });

  List<pw.Widget> build(
    pw.Context context,
  ) {
    return content
        .map(
          (e) => Widget(
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

    bool multi = Types.boolFromDict(json, 'multi');
    int amountColumns = int.tryParse(json['amountColumns'].toString()) ?? 1;
    if (amountColumns > 1) {
      multi = true;
    }
    return Page(
      multi: multi,
      theme: json['theme'] as String? ?? '',
      header: json['header'] as String? ?? '',
      footer: json['footer'] as String? ?? '',
      content: json['content'] as List<dynamic>? ?? [],
      gapWidth: double.tryParse(json['gapWidth'].toString()) ?? 10,
      amountColumns: amountColumns,
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
