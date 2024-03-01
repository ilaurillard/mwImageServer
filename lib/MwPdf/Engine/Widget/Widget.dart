import 'package:mwcdn/MwMs/Etc/Console.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/MultiPage.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Datasource.dart';
import 'Annotation.dart';
import 'Barcode.dart';
import 'Basic.dart';
import 'Chart.dart';
import 'Clip.dart';
import 'Container.dart';
import 'Content.dart';
import 'Util.dart';
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
  final Dict json;

  Widget({
    required this.json,
  });

  pw.Widget build(
    State state,
  ) {
    return parse(
      json,
      state,
    );
  }

  static pw.Widget child(
    Dict json,
    State state,
  ) {
    return Widget.parse(
      json['child'] as Dict? ?? {},
      state,
    );
  }

  static List<pw.Widget> children(
    Dict json,
    State state,
  ) {
    return (json['children'] as List<dynamic>? ?? [])
        .map((e) => Widget.parse(
              e as Dict,
              state,
            ))
        .toList();
  }

  static pw.Widget parse(
    Dict json,
    State state,
  ) {
    if (json.entries.isNotEmpty) {
      MapEntry<String, dynamic> widget = json.entries.first;

      String key = widget.key;
      Dict data = widget.value as Dict;

      // print('W: $key');
      // print(widget);

      switch (key) {
        case 'Comment':
          return pw.Container();
        // ------------
        case 'Switch':
          return Util.switchCases(
            data,
            state,
          );
        case 'ShowIf':
          return Util.showIf(
            data,
            state,
          );
        // ----------
        case 'Center':
          return Basic.center(
            data,
            state,
          );
        case 'Align':
          return Basic.align(
            data,
            state,
          );
        case 'FittedBox':
          return Basic.fittedBox(
            data,
            state,
          );
        case 'SizedBox':
          return Basic.sizedBox(
            data,
            state,
          );
        case 'LimitedBox':
          return Basic.limitedBox(
            data,
            state,
          );
        case 'ConstrainedBox':
          return Basic.constrainedBox(
            data,
            state,
          );
        case 'OverflowBox':
          return Basic.overflowBox(
            data,
            state,
          );
        case 'AspectRatio':
          return Basic.aspectRatio(
            data,
            state,
          );
        case 'Divider':
          return Basic.divider(
            data,
            state,
          );
        case 'VerticalDivider':
          return Basic.verticalDivider(data);
        case 'Opacity':
          return Basic.opacity(
            data,
            state,
          );
        case 'Transform':
          return Basic.transform(
            data,
            state,
          );
        case 'FullPage':
          return Basic.fullPage(
            data,
            state,
          );
        // ----------
        case 'Container':
          return Container.container(
            data,
            state,
          );
        case 'DecoratedBox':
          return Container.decoratedBox(
            data,
            state,
          );
        case 'Padding':
          return Container.padding(
            data,
            state,
          );
        // ----------
        case 'Spacer':
          return Flex.spacer(data);
        // case 'Flex':
        //   return Flex.flex(
        //     data,
        //     state,
        //   );
        case 'Row':
          return Flex.row(
            data,
            state,
          );
        case 'Column':
          return Flex.column(
            data,
            state,
          );
        case 'Expanded':
          return Flex.expanded(
            data,
            state,
          );
        case 'Flexible':
          return Flex.flexible(
            data,
            state,
          );

        case 'ListView':
          return Flex.listView(
            data,
            state,
          );
        // ----------
        case 'Stack':
          return Stack.stack(
            data,
            state,
          );
        case 'Positioned':
          return Stack.positioned(
            data,
            state,
          );
        // ----------
        case 'Wrap':
          return Wrap.wrap(
            data,
            state,
          );
        // ----------
        case 'GridView':
          return GridView.gridView(
            data,
            state,
          );
        // ----------
        case 'Header':
          return Content.header(
            data,
            state,
          );
        case 'Footer':
          return Content.footer(
            data,
            state,
          );
        case 'Bullet':
          return Content.bullet(
            data,
            state,
          );
        case 'TableOfContent':
          return Content.tableOfContent(
            data,
            state,
          );
        // ----------
        case 'Partitions':
          return Partition.partitions(
            data,
            state,
          );
        // ----------
        case 'Table':
          return Table.table(
            data,
            state,
          );
        case 'TableAuto':
          return Table.tableAuto(
            data,
            state,
          );
        // ----------
        case 'Text':
          return Text.text(
            data,
            state,
          );
        case 'RichText':
          return Text.richText(
            data,
            state,
          );
        // ----------
        case 'Paragraph':
          return Content.paragraph(
            data,
            state,
          );
        case 'Watermark':
          return Content.watermark(
            data,
            state,
          );
        // ----------
        case 'Placeholder':
          return Placeholders.placeholder(data);
        case 'LoremText':
          return Placeholders.loremText(
            data,
            state,
          );
        case 'LoremParagraph':
          return Placeholders.loremParagraph(
            data,
            state,
          );
        case 'PdfLogo':
          return Placeholders.pdfLogo(data);
        // ----------
        case 'Image':
          return Image.image(
            data,
            state,
          );
        case 'SvgImage':
          return Image.svgImage(
            data,
            state,
          );
        case 'Icon':
          return Image.icon(
            data,
            state,
          );
        case 'Shape':
          return Image.shape(
            data,
            state,
          );
        // ----------
        case 'Chart':
          return Chart.chart(
            data,
            state,
          );
        case 'ChartLegend':
          return Chart.chartLegend(
            data,
            state,
          );
        // ----------
        case 'BarcodeWidget':
          return Barcode.barcode(
            data,
            state,
          );
        // -----------
        case 'Circle':
          return Shape.circle(data);
        case 'Polygon':
          return Shape.polygon(data);
        case 'Rectangle':
          return Shape.rectangle(data);
        case 'InkList':
          return Shape.inkList(data);
        // ----------
        case 'GridPaper':
          return GridPaper.gridPaper(
            data,
            state,
          );
        // -----------
        case 'ClipRect':
          return Clip.clipRect(
            data,
            state,
          );
        case 'ClipRRect':
          return Clip.clipRRect(
            data,
            state,
          );
        case 'ClipOval':
          return Clip.clipOval(
            data,
            state,
          );
        // -----------
        // case 'TextField':
        //   return Form.textField(data);
        // -----------
        case 'Anchor':
          return Annotation.anchor(
            data,
            state,
          );
        case 'Link':
          return Annotation.link(
            data,
            state,
          );
        case 'UrlLink':
          return Annotation.urlLink(
            data,
            state,
          );
        case 'Outline':
          return Annotation.outline(
            data,
            state,
          );
        // case 'SquareAnnotation':
        //   return Annotation.squareAnnotation(
        //     data,
        //     state,
        //   );
        // -----------
        case 'Widget':
          return Widget.widget(
            data,
            state,
          );
        // -----------
        case 'NewPage':
          return MultiPage.newPage(
            data,
            state,
          );
        // ----------
        case 'Calendar':
          return Custom.calendar(
            data,
            state,
          );


        // ----------
        /*
          TODO not yet implemented widgets
          ----

          basic:
            CustomPaint
          forms:
            ChoiceField
            Checkbox
            FlatButton
            Signature
            TextField
          annotations:
            SquareAnnotation
            CircleAnnotation
            PolygonAnnotation
            PolyLineAnnotation
            InkAnnotation
        */
      }

      Console.error(' !!! widget $key not supported');
    }
    return pw.SizedBox();
  }

  // referring/importing a widget from resources ("@identifier")
  static pw.Widget widget(
    Dict json,
    State state,
  ) {
    Datasource source = state.source(
      json['source'] as String?,
    );
    return source.widget ?? pw.SizedBox();
  }
}
