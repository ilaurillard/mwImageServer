import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidgetBasic.dart';
import 'PdfWidgetChart.dart';
import 'PdfWidgetImage.dart';
import 'PdfWidgetLayout.dart';
import 'PdfWidgetTable.dart';

class PdfWidget {
  final pw.Context context;
  final Dict json;

  PdfWidget({
    required this.context,
    required this.json,
  });

  pw.Widget build() {
    return parse(json);
  }

  static pw.Widget parse(
    Dict json,
  ) {
    if (json.entries.isNotEmpty) {
      MapEntry<String, dynamic> widget = json.entries.first;

      String key = widget.key;
      Dict data = widget.value as Dict;

      // print('W: $key');
      // print(widget);

      switch (key) {
        case 'Container':
          return PdfWidgetLayout.container(data);

        case 'SizedBox':
          return PdfWidgetLayout.sizedBox(data);

        case 'Wrap':
          return PdfWidgetLayout.wrap(data);

        case 'Flex':
          return PdfWidgetLayout.flex(data);
        case 'Row':
          return PdfWidgetLayout.row(data);
        case 'Column':
          return PdfWidgetLayout.column(data);
        case 'Expanded':
          return PdfWidgetLayout.expanded(data);
        case 'Flexible':
          return PdfWidgetLayout.flexible(data);

        // ----------

        case 'Table':
          return PdfWidgetTable.table(data);

        // ----------

        case 'Text':
          return PdfWidgetBasic.text(data);

        case 'Paragraph':
          return PdfWidgetBasic.paragraph(data);

        case 'Spacer':
          return PdfWidgetBasic.spacer(data);

        case 'Placeholder':
          return PdfWidgetBasic.placeholder(data);

        case 'Divider':
          return PdfWidgetBasic.divider(data);

        case 'Opacity':
          return PdfWidgetBasic.opacity(data);

        case 'LoremText':
          return PdfWidgetBasic.loremText(data);

        case 'LoremParagraph':
          return PdfWidgetBasic.loremParagraph(data);

        // ----------

        case 'Image':
          return PdfWidgetImage.image(data);

        case 'SvgImage':
          return PdfWidgetImage.svgImage(data);

        // ----------

        case 'Chart':
          return PdfWidgetChart.chart(data);
        case 'ChartLegend':
          return PdfWidgetChart.chartLegend(data);
      }

      print(' !!! widget $key not supported');
    }
    return pw.SizedBox();
  }

}
