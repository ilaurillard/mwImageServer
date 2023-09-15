import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Barcode.dart';
import 'Content.dart';
import 'Chart.dart';
import 'Grid.dart';
import 'Annotation.dart';
import 'Image.dart';
import 'Layout.dart';
import 'Partition.dart';
import 'Shape.dart';
import 'Table.dart';
import 'Etc.dart';

class Widget {
  static late pw.Context context;

  static int pageNumber = 0;
  static int pagesCount = 0;
  static Map<String, String> parameters = {};

  final Dict json;

  Widget({
    required this.json,
    required pw.Context context,
    int pageNumber = 0,
    int pagesCount = 0,
  }) {
    // ignore: prefer_initializing_formals
    Widget.pageNumber = pageNumber;
    // ignore: prefer_initializing_formals
    Widget.pagesCount = pagesCount;
  }

  pw.Widget build() {
    return parse(json);
  }

  static pw.Widget child(
    Dict json,
  ) {
    return Widget.parse(json['child'] as Dict? ?? {});
  }

  static List<pw.Widget> children(
    Dict json,
  ) {
    return (json['children'] as List<dynamic>? ?? [])
        .map((e) => Widget.parse(e as Dict))
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

        case 'Switch':
          return Etc.switchCases(data);

        case 'Container':
          return Layout.container(data);
        case 'Center':
          return Layout.center(data);
        case 'Align':
          return Layout.align(data);
        case 'FittedBox':
          return Layout.fittedBox(data);
        case 'SizedBox':
          return Layout.sizedBox(data);
        case 'DecoratedBox':
          return Layout.decoratedBox(data);
        case 'Wrap':
          return Layout.wrap(data);
        case 'Flex':
          return Layout.flex(data);
        case 'Row':
          return Layout.row(data);
        case 'Column':
          return Layout.column(data);

        case 'Expanded':
          return Layout.expanded(data);
        case 'Padding':
          return Layout.padding(data);
        case 'LimitedBox':
          return Layout.limitedBox(data);
        case 'ConstrainedBox':
          return Layout.constrainedBox(data);
        case 'OverflowBox':
          return Layout.overflowBox(data);
        case 'AspectRatio':
          return Layout.aspectRatio(data);
        case 'Flexible':
          return Layout.flexible(data);
        case 'GridView':
          return Layout.gridView(data);
        case 'ListView':
          return Layout.listView(data);
        case 'Stack':
          return Layout.stack(data);
        case 'Positioned':
          return Layout.positioned(data);

        // ----------
        case 'Header':
          return Annotation.header(data);

        // ----------
        case 'Partitions':
          return Partition.partitions(data);
        // ----------
        case 'Table':
          return Table.table(data);
        case 'Table3':
          return Table.table3(data);
        // ----------

        case 'Text':
          return Content.text(data);
        case 'Paragraph':
          return Content.paragraph(data);
        case 'Spacer':
          return Content.spacer(data);
        case 'Placeholder':
          return Content.placeholder(data);
        case 'Divider':
          return Content.divider(data);
        case 'VerticalDivider':
          return Content.verticalDivider(data);
        case 'Opacity':
          return Content.opacity(data);
        case 'LoremText':
          return Content.loremText(data);
        case 'LoremParagraph':
          return Content.loremParagraph(data);

        // ----------

        case 'Image':
          return Image.image(data);
        case 'SvgImage':
          return Image.svgImage(data);
        case 'Icon':
          return Image.icon(data);
        // ----------

        case 'Chart':
          return Chart.chart(data);
        case 'ChartLegend':
          return Chart.chartLegend(data);

        // ----------

        case 'BarcodeWidget':
          return Barcode.barcode(data);

        // -----------

        case 'Circle':
          return Shape.circle(data);
        case 'Polygon':
          return Shape.polygon(data);
        case 'Rectangle':
          return Shape.rectangle(data);
        case 'PdfLogo':
          return Shape.pdfLogo(data);

        // -----------

        case 'GridPaper':
          return Grid.gridPaper(data);

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

          text:
            RichText

        */
      }

      print(' !!! widget $key not supported');
    }
    return pw.SizedBox();
  }
}
