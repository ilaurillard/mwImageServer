import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Barcode.dart';
import 'Basic.dart';
import 'Chart.dart';
import 'Container.dart';
import 'Content.dart';
import 'Etc.dart';
import 'Flex.dart';
import 'GridPaper.dart';
import 'GridView.dart';
import 'Image.dart';
import 'Partition.dart';
import 'Placeholders.dart';
import 'Shape.dart';
import 'Stack.dart';
import 'Table.dart';
import 'Text.dart';
import 'Wrap.dart';

class Widget {
  static late pw.Context context;

  static int pageNumber = 0;
  static int pagesCount = 0;
  static Map<String, String> parameters = {};
  static String value = '';

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
        // ----------
        case 'Center':
          return Basic.center(data);
        case 'Align':
          return Basic.align(data);
        case 'FittedBox':
          return Basic.fittedBox(data);
        case 'SizedBox':
          return Basic.sizedBox(data);
        case 'LimitedBox':
          return Basic.limitedBox(data);
        case 'ConstrainedBox':
          return Basic.constrainedBox(data);
        case 'OverflowBox':
          return Basic.overflowBox(data);
        case 'AspectRatio':
          return Basic.aspectRatio(data);
        case 'Divider':
          return Basic.divider(data);
        case 'VerticalDivider':
          return Basic.verticalDivider(data);
        case 'Opacity':
          return Basic.opacity(data);
        // ----------
        case 'Container':
          return Container.container(data);
        case 'DecoratedBox':
          return Container.decoratedBox(data);
        case 'Padding':
          return Container.padding(data);
        // ----------
        case 'Spacer':
          return Flex.spacer(data);
        case 'Flex':
          return Flex.flex(data);
        case 'Row':
          return Flex.row(data);
        case 'Column':
          return Flex.column(data);
        case 'Expanded':
          return Flex.expanded(data);
        case 'Flexible':
          return Flex.flexible(data);
        case 'ListView':
          return Flex.listView(data);
        // ----------
        case 'Stack':
          return Stack.stack(data);
        case 'Positioned':
          return Stack.positioned(data);
        // ----------
        case 'Wrap':
          return Wrap.wrap(data);
        // ----------
        case 'GridView':
          return GridView.gridView(data);
        // ----------
        case 'Header':
          return Content.header(data);
        case 'Footer':
          return Content.footer(data);
        case 'Bullet':
          return Content.bullet(data);
        // ----------
        case 'Partitions':
          return Partition.partitions(data);
        // ----------
        case 'Table':
          return Table.table(data);
        case 'TableAuto':
          return Table.tableAuto(data);
        // ----------
        case 'Text':
          return Text.text(data);
        case 'Paragraph':
          return Content.paragraph(data);
        // ----------
        case 'Placeholder':
          return Placeholders.placeholder(data);
        case 'LoremText':
          return Placeholders.loremText(data);
        case 'LoremParagraph':
          return Placeholders.loremParagraph(data);
        case 'PdfLogo':
          return Placeholders.pdfLogo(data);
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
        // ----------
        case 'GridPaper':
          return GridPaper.gridPaper(data);
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
