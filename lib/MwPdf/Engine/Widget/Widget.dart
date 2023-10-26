import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Resource.dart';
import 'Annotation.dart';
import 'Barcode.dart';
import 'Basic.dart';
import 'Chart.dart';
import 'Clip.dart';
import 'Container.dart';
import 'Content.dart';
import 'Etc.dart';
import 'Flex.dart';
import 'Form.dart';
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
  // static String value = '';

  final Dict json;

  Widget({
    required this.json,
  });

  pw.Widget build(
    Resources resources,
  ) {
    return parse(
      json,
      resources,
    );
  }

  static pw.Widget child(
    Dict json,
    Resources resources,
  ) {
    return Widget.parse(
      json['child'] as Dict? ?? {},
      resources,
    );
  }

  static List<pw.Widget> children(
    Dict json,
    Resources resources,
  ) {
    return (json['children'] as List<dynamic>? ?? [])
        .map((e) => Widget.parse(
              e as Dict,
              resources,
            ))
        .toList();
  }

  static pw.Widget parse(
    Dict json,
    Resources resources,
  ) {
    if (json.entries.isNotEmpty) {
      MapEntry<String, dynamic> widget = json.entries.first;

      String key = widget.key;
      Dict data = widget.value as Dict;

      // print('W: $key');
      // print(widget);

      switch (key) {
        case 'Switch':
          return Etc.switchCases(
            data,
            resources,
          );
        // ----------
        case 'Center':
          return Basic.center(
            data,
            resources,
          );
        case 'Align':
          return Basic.align(
            data,
            resources,
          );
        case 'FittedBox':
          return Basic.fittedBox(
            data,
            resources,
          );
        case 'SizedBox':
          return Basic.sizedBox(
            data,
            resources,
          );
        case 'LimitedBox':
          return Basic.limitedBox(
            data,
            resources,
          );
        case 'ConstrainedBox':
          return Basic.constrainedBox(
            data,
            resources,
          );
        case 'OverflowBox':
          return Basic.overflowBox(
            data,
            resources,
          );
        case 'AspectRatio':
          return Basic.aspectRatio(
            data,
            resources,
          );
        case 'Divider':
          return Basic.divider(
            data,
            resources,
          );
        case 'VerticalDivider':
          return Basic.verticalDivider(data);
        case 'Opacity':
          return Basic.opacity(
            data,
            resources,
          );
        case 'Transform':
          return Basic.transform(
            data,
            resources,
          );
        case 'FullPage':
          return Basic.fullPage(
            data,
            resources,
          );
        // ----------
        case 'Container':
          return Container.container(
            data,
            resources,
          );
        case 'DecoratedBox':
          return Container.decoratedBox(
            data,
            resources,
          );
        case 'Padding':
          return Container.padding(
            data,
            resources,
          );
        // ----------
        case 'Spacer':
          return Flex.spacer(data);
        case 'Flex':
          return Flex.flex(
            data,
            resources,
          );
        case 'Row':
          return Flex.row(
            data,
            resources,
          );
        case 'Column':
          return Flex.column(
            data,
            resources,
          );
        case 'Expanded':
          return Flex.expanded(
            data,
            resources,
          );
        case 'Flexible':
          return Flex.flexible(
            data,
            resources,
          );
        case 'ListView':
          return Flex.listView(
            data,
            resources,
          );
        // ----------
        case 'Stack':
          return Stack.stack(
            data,
            resources,
          );
        case 'Positioned':
          return Stack.positioned(
            data,
            resources,
          );
        // ----------
        case 'Wrap':
          return Wrap.wrap(
            data,
            resources,
          );
        // ----------
        case 'GridView':
          return GridView.gridView(
            data,
            resources,
          );
        // ----------
        case 'Header':
          return Content.header(
            data,
            resources,
          );
        case 'Footer':
          return Content.footer(
            data,
            resources,
          );
        case 'Bullet':
          return Content.bullet(
            data,
            resources,
          );
        // ----------
        case 'Partitions':
          return Partition.partitions(
            data,
            resources,
          );
        // ----------
        case 'Table':
          return Table.table(
            data,
            resources,
          );
        case 'TableAuto':
          return Table.tableAuto(
            data,
            resources,
          );
        // ----------
        case 'Text':
          return Text.text(
            data,
            resources,
          );
        // case 'RichText':
        //   return Text.richText(data);
        case 'Paragraph':
          return Content.paragraph(
            data,
            resources,
          );
        case 'Watermark':
          return Content.watermark(
            data,
            resources,
          );
        // ----------
        case 'Placeholder':
          return Placeholders.placeholder(data);
        case 'LoremText':
          return Placeholders.loremText(
            data,
            resources,
          );
        case 'LoremParagraph':
          return Placeholders.loremParagraph(
            data,
            resources,
          );
        case 'PdfLogo':
          return Placeholders.pdfLogo(data);
        // ----------
        case 'Image':
          return Image.image(
            data,
            resources,
          );
        case 'SvgImage':
          return Image.svgImage(
            data,
            resources,
          );
        case 'Icon':
          return Image.icon(
            data,
            resources,
          );
        // ----------
        case 'Chart':
          return Chart.chart(
            data,
            resources,
          );
        case 'ChartLegend':
          return Chart.chartLegend(
            data,
            resources,
          );
        // ----------
        case 'BarcodeWidget':
          return Barcode.barcode(
            data,
            resources,
          );
        // -----------
        case 'Circle':
          return Shape.circle(data);
        case 'Polygon':
          return Shape.polygon(data);
        case 'Rectangle':
          return Shape.rectangle(data);
        // ----------
        case 'GridPaper':
          return GridPaper.gridPaper(
            data,
            resources,
          );
        // -----------
        case 'ClipRect':
          return Clip.clipRect(
            data,
            resources,
          );
        case 'ClipRRect':
          return Clip.clipRRect(
            data,
            resources,
          );
        case 'ClipOval':
          return Clip.clipOval(
            data,
            resources,
          );
        // -----------
        case 'TextField':
          return Form.textField(data);
        // -----------
        case 'Anchor':
          return Annotation.anchor(
            data,
            resources,
          );
        case 'Link':
          return Annotation.link(
            data,
            resources,
          );
        case 'UrlLink':
          return Annotation.urlLink(
            data,
            resources,
          );
        // -----------
        case 'Widget':
          return Widget.widget(
            data,
            resources,
          );
        /*

          TODO implement widgets
          ----

          multi_page:
            NewPage
          basic:
            CustomPaint
          content:
            TableOfContent
          image:
            Shape
          shape:
            Inklist
          text:
            RichText
          forms:
            ChoiceField
            Checkbox
            FlatButton
            TextField
            Signature
          annotations:
            SquareAnnotation
            CircleAnnotation
            PolygonAnnotation
            PolyLineAnnotation
            InkAnnotation
            Outline

        */
      }

      print(' !!! widget $key not supported');
    }
    return pw.SizedBox();
  }

  // referring/importing a widget from resources ("@identifier")
  static pw.Widget widget(
    Dict json,
    Resources resources,
  ) {
    Resource resource = resources.resource(json['resource'] as String?);
    return resource.widget ?? pw.SizedBox();
  }
}
