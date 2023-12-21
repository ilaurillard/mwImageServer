import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Unwrapped.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/Widget.dart';

class Page {
  final bool multi;
  final String theme;
  final String header;
  final String footer;

  final int columns;
  final double gapWidth;

  final List<dynamic> content;

  final int toc;

  Page({
    this.multi = false,
    this.theme = '',
    this.header = '',
    this.footer = '',
    required this.content,
    this.columns = 1,
    this.gapWidth = 10,
    this.toc = 0,
  });

  List<pw.Widget> build(
    State state,
  ) {
    List<pw.Widget> widgets = [];
    for (dynamic e in content) {
      pw.Widget w = Widget(
        json: e as Dict,
      ).build(
        state,
      );
      if (w.runtimeType == Unwrapped) {
        widgets.addAll((w as Unwrapped).children);
      }
      else {
        widgets.add(w);
      }
    }
    return widgets;
  }

  static Page fromJson(
    Dict json,
  ) {
    // print('Page: $json');

    bool multi = Types.boolFromDict(json, 'multi');
    int columns = int.tryParse(json['columns'].toString()) ?? 1;
    if (columns > 1) {
      multi = true;
    }
    return Page(
      multi: multi,
      theme: json['theme'] as String? ?? '',
      header: json['header'] as String? ?? '',
      footer: json['footer'] as String? ?? '',
      content: json['content'] as List<dynamic>? ?? [],
      gapWidth: double.tryParse(json['gapWidth'].toString()) ?? 10,
      columns: columns,
      toc: int.tryParse(json['toc'].toString()) ?? 0,
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
