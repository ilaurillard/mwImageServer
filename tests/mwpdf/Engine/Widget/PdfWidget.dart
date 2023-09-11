import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidgetBarcode.dart';
import 'PdfWidgetBasic.dart';
import 'PdfWidgetChart.dart';
import 'PdfWidgetGrid.dart';
import 'PdfWidgetImage.dart';
import 'PdfWidgetLayout.dart';
import 'PdfWidgetPartition.dart';
import 'PdfWidgetShape.dart';
import 'PdfWidgetTable.dart';

class PdfWidget {
  static late pw.Context context;
  static int pageNumber = 0;
  static int pagesCount = 0;

  final Dict json;

  PdfWidget({
    required this.json,
    required pw.Context context,
    int pageNumber = 0,
    int pagesCount = 0,
  }) {
    // ignore: prefer_initializing_formals
    PdfWidget.pageNumber = pageNumber;
    // ignore: prefer_initializing_formals
    PdfWidget.pagesCount = pagesCount;
  }

  pw.Widget build() {
    return parse(json);
  }

  static pw.Widget child(
    Dict json,
  ) {
    return PdfWidget.parse(json['child'] as Dict? ?? {});
  }

  static List<pw.Widget> children(
    Dict json,
  ) {
    return (json['children'] as List<dynamic>? ?? [])
        .map((e) => PdfWidget.parse(e as Dict))
        .toList();
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
        case 'Center':
          return PdfWidgetLayout.center(data);
        case 'Align':
          return PdfWidgetLayout.align(data);
        case 'FittedBox':
          return PdfWidgetLayout.fittedBox(data);
        case 'SizedBox':
          return PdfWidgetLayout.sizedBox(data);
        case 'DecoratedBox':
          return PdfWidgetLayout.decoratedBox(data);
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
        case 'Padding':
          return PdfWidgetLayout.padding(data);
        case 'LimitedBox':
          return PdfWidgetLayout.limitedBox(data);
        case 'ConstrainedBox':
          return PdfWidgetLayout.constrainedBox(data);
        case 'OverflowBox':
          return PdfWidgetLayout.overflowBox(data);
        case 'AspectRatio':
          return PdfWidgetLayout.aspectRatio(data);
        case 'Flexible':
          return PdfWidgetLayout.flexible(data);
        case 'GridView':
          return PdfWidgetLayout.gridView(data);
        case 'ListView':
          return PdfWidgetLayout.listView(data);
        case 'Stack':
          return PdfWidgetLayout.stack(data);

        // ----------
        case 'Partitions':
          return PdfWidgetPartition.partitions(data);
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
        case 'VerticalDivider':
          return PdfWidgetBasic.verticalDivider(data);
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
        case 'Icon':
          return PdfWidgetImage.icon(data);
        // ----------

        case 'Chart':
          return PdfWidgetChart.chart(data);
        case 'ChartLegend':
          return PdfWidgetChart.chartLegend(data);

        // ----------

        case 'BarcodeWidget':
          return PdfWidgetBarcode.barcode(data);

        // -----------

        case 'Circle':
          return PdfWidgetShape.circle(data);
        case 'Polygon':
          return PdfWidgetShape.polygon(data);
        case 'Rectangle':
          return PdfWidgetShape.rectangle(data);

        // -----------

        case 'GridPaper':
          return PdfWidgetGrid.gridPaper(data);

        // -----------

        /*

          TODO
          ----

          annotations:
            ...

          basic:
            Transform
            CustomPaint
            FullPage

          clip:
            ClipRect
            ClipRRect
            ClipOval

          content:
            Header
            Footer
            TableOfContent
            Bullet
            Watermark

          forms:
            ChoiceField
            Checkbox
            FlatButton
            TextField
            Signature

          image:
            Shape

          shape:
            Inklist

          stack:
            Positioned

          text:
            RichText

        */
      }

      print(' !!! widget $key not supported');
    }
    return pw.Placeholder();
  }
}
