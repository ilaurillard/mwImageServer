import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';

class PdfPage {
  final String theme;
  final String header;
  final String footer;

  final List<dynamic> content;

  PdfPage({
    this.theme = '',
    this.header = '',
    this.footer = '',
    required this.content,
  });

  List<pw.Widget> build(
    pw.Context context,
  ) {
    return content
        .map((e) => PdfWidget(
              context: context,
              json: e as Dict,
            ).build())
        .toList();
  }

  static PdfPage fromJson(
    Dict json,
  ) {
    // print('Page: $json');

    return PdfPage(
      theme: json['theme'] as String? ?? '',
      header: json['header'] as String? ?? '',
      footer: json['footer'] as String? ?? '',
      content: json['content'] as List<dynamic>? ?? [],
    );
  }

  static List<PdfPage> fromJsonAll(
    List<dynamic> json,
  ) {
    return json
        .map((i) => PdfPage.fromJson(
              i as Dict,
            ))
        .toList();
  }
}
