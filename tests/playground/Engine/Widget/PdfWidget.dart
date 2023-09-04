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
    return parseWidget(json);
  }

  static pw.Widget parseWidget(
    Dict json,
  ) {
    if (json.entries.isNotEmpty) {
      MapEntry<String, dynamic> widget = json.entries.first;

      String key = widget.key;
      Dict data = widget.value as Dict;

      print('W: $key');
      print(widget);

      switch (key) {
        case 'Container':
          return PdfWidgetLayout.parseContainer(data);

        case 'SizedBox':
          return PdfWidgetLayout.parseSizedBox(data);

        case 'Wrap':
          return PdfWidgetLayout.parseWrap(data);

        case 'Flex':
          return PdfWidgetLayout.parseFlex(data);
        case 'Row':
          return PdfWidgetLayout.parseRow(data);
        case 'Column':
          return PdfWidgetLayout.parseColumn(data);
        case 'Expanded':
          return PdfWidgetLayout.parseExpanded(data);
        case 'Flexible':
          return PdfWidgetLayout.parseFlexible(data);

        // ----------

        case 'Table':
          return PdfWidgetTable.parseTable(data);

        // ----------

        case 'Text':
          return PdfWidgetBasic.parseText(data);

        case 'Paragraph':
          return PdfWidgetBasic.parseParagraph(data);

        case 'Spacer':
          return PdfWidgetBasic.parseSpacer(data);

        case 'Placeholder':
          return PdfWidgetBasic.parsePlaceholder(data);

        case 'Divider':
          return PdfWidgetBasic.parseDivider(data);

        case 'Opacity':
          return PdfWidgetBasic.parseOpacity(data);

        // ----------

        case 'Image':
          return PdfWidgetImage.parseImage(data);

        case 'SvgImage':
          return PdfWidgetImage.parseSvgImage(data);

        // ----------

        case 'Chart':
          return PdfWidgetChart.parseChart(data);
        case 'ChartLegend':
          return PdfWidgetChart.parseChartLegend(data);
      }

      print(' !!! widget $key not supported');
    }
    return pw.SizedBox();
  }

// ----------------
}
