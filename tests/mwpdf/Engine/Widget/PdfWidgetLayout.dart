import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetLayout {
  static pw.Center center(
    Dict json,
  ) {
    return pw.Center(
      child: PdfWidget.child(json),
    );
  }

  static pw.Align align(
    Dict json,
  ) {
    double? widthFactor = double.tryParse(json['widthFactor'].toString());
    double? heightFactor = double.tryParse(json['heightFactor'].toString());
    return pw.Align(
      alignment: PdfWidgetUtil.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: PdfWidget.child(json),
      widthFactor: widthFactor != null ? widthFactor * PdfPageFormat.mm : null,
      heightFactor:
          heightFactor != null ? heightFactor * PdfPageFormat.mm : null,
    );
  }

  static pw.FittedBox fittedBox(
    Dict json,
  ) {
    return pw.FittedBox(
      fit: PdfWidgetUtil.boxFit(
            json['fit'] as String?,
          ) ??
          pw.BoxFit.contain,
      alignment: PdfWidgetUtil.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: PdfWidget.child(json),
    );
  }

  static pw.Container container(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    // TODO  transform
    return pw.Container(
      constraints: PdfWidgetUtil.boxConstraints(
        json['constraints'] as Dict?,
      ),
      alignment: PdfWidgetUtil.alignment(
        json['alignment'] as String?,
      ),
      padding: PdfWidgetUtil.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: PdfWidgetUtil.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      color: PdfWidgetUtil.color(
        json['color'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      decoration:
          PdfWidgetUtil.boxDecoration((json['decoration'] as Dict?) ?? {}),
      foregroundDecoration: PdfWidgetUtil.boxDecoration(
          (json['foregroundDecoration'] as Dict?) ?? {}),
      child: PdfWidget.child(json),
    );
  }

  static pw.SizedBox sizedBox(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.SizedBox(
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      child: PdfWidget.child(json),
    );
  }

  static pw.DecoratedBox decoratedBox(
    Dict json,
  ) {
    return pw.DecoratedBox(
      decoration:
          PdfWidgetUtil.boxDecoration((json['decoration'] as Dict?) ?? {}) ??
              pw.BoxDecoration(),
      position: PdfWidgetUtil.decorationPosition(
          json['decorationPosition'] as String?),
      child: PdfWidget.child(json),
    );
  }

  static pw.Wrap wrap(
    Dict json,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    double? runSpacing = double.tryParse(json['runSpacing'].toString());
    return pw.Wrap(
      direction: PdfWidgetUtil.axis(
            json['direction'] as String?,
          ) ??
          pw.Axis.horizontal,
      alignment: PdfWidgetUtil.wrapAlignment(
        json['alignment'] as String?,
      ),
      spacing: spacing != null ? spacing * PdfPageFormat.mm : 0.0,
      runAlignment: PdfWidgetUtil.wrapAlignment(
        json['runAlignment'] as String?,
      ),
      runSpacing: runSpacing != null ? runSpacing * PdfPageFormat.mm : 0.0,
      crossAxisAlignment: PdfWidgetUtil.wrapCrossAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      verticalDirection: PdfWidgetUtil.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: PdfWidget.children(json),
    );
  }

  static pw.Row row(
    Dict json,
  ) {
    return pw.Row(
      mainAxisAlignment: PdfWidgetUtil.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: PdfWidgetUtil.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: PdfWidgetUtil.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: PdfWidgetUtil.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: PdfWidget.children(json),
    );
  }

  static pw.Column column(
    Dict json,
  ) {
    return pw.Column(
      mainAxisAlignment: PdfWidgetUtil.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: PdfWidgetUtil.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: PdfWidgetUtil.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: PdfWidgetUtil.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: PdfWidget.children(json),
    );
  }

  // (obsolete) parent of row/col ..
  static pw.Flex flex(
    Dict json,
  ) {
    return pw.Flex(
      direction: PdfWidgetUtil.axis(
            json['direction'] as String?,
          ) ??
          pw.Axis.horizontal,
      mainAxisAlignment: PdfWidgetUtil.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: PdfWidgetUtil.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: PdfWidgetUtil.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: PdfWidgetUtil.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: PdfWidget.children(json),
    );
  }

  static pw.Expanded expanded(
    Dict json,
  ) {
    return pw.Expanded(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: PdfWidgetUtil.flexFit(
        json['fit'] as String?,
      ),
      child: PdfWidget.child(json),
    );
  }

  static pw.Padding padding(
    Dict json,
  ) {
    return pw.Padding(
      padding: PdfWidgetUtil.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero,
      child: PdfWidget.child(json),
    );
  }

  static pw.LimitedBox limitedBox(
    Dict json,
  ) {
    double? maxWidth = double.tryParse(json['maxWidth'].toString());
    double? maxHeight = double.tryParse(json['maxHeight'].toString());
    return pw.LimitedBox(
      maxWidth:
          maxWidth != null ? maxWidth * PdfPageFormat.mm : double.infinity,
      maxHeight:
          maxHeight != null ? maxHeight * PdfPageFormat.mm : double.infinity,
      child: PdfWidget.child(json),
    );
  }

  static pw.ConstrainedBox constrainedBox(
    Dict json,
  ) {
    return pw.ConstrainedBox(
      constraints: PdfWidgetUtil.boxConstraints(
            json['constraints'] as Dict?,
          ) ??
          pw.BoxConstraints(),
      child: PdfWidget.child(json),
    );
  }

  static pw.OverflowBox overflowBox(
    Dict json,
  ) {
    return pw.OverflowBox(
      alignment: PdfWidgetUtil.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      minWidth: double.tryParse(json['minWidth'].toString()),
      maxWidth: double.tryParse(json['maxWidth'].toString()),
      minHeight: double.tryParse(json['minHeight'].toString()),
      maxHeight: double.tryParse(json['maxHeight'].toString()),
      child: PdfWidget.child(json),
    );
  }

  static pw.Flexible flexible(
    Dict json,
  ) {
    return pw.Flexible(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: PdfWidgetUtil.flexFit(
        json['fit'] as String? ?? 'loose',
      ),
      child: PdfWidget.child(json),
    );
  }

  static pw.AspectRatio aspectRatio(
    Dict json,
  ) {
    return pw.AspectRatio(
      aspectRatio: double.tryParse(json['aspectRatio'].toString()) ?? 1,
      child: PdfWidget.child(json),
    );
  }

  static pw.ListView listView(
    Dict json,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    return pw.ListView(
      direction:
          PdfWidgetUtil.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      children: PdfWidget.children(json),
      padding: PdfWidgetUtil.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      spacing: spacing != null ? spacing * PdfPageFormat.mm : 0,
      reverse: json['reverse'] as bool? ?? false,
    );
  }

  static pw.GridView gridView(
    Dict json,
  ) {
    double? mainAxisSpacing =
        double.tryParse(json['mainAxisSpacing'].toString());
    double? crossAxisSpacing =
        double.tryParse(json['crossAxisSpacing'].toString());
    return pw.GridView(
      direction:
          PdfWidgetUtil.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      crossAxisCount: int.tryParse(json['crossAxisCount'].toString()) ?? 3,
      children: PdfWidget.children(json),
      padding: PdfWidgetUtil.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero,
      mainAxisSpacing:
          mainAxisSpacing != null ? mainAxisSpacing * PdfPageFormat.mm : 0.0,
      crossAxisSpacing:
          crossAxisSpacing != null ? crossAxisSpacing * PdfPageFormat.mm : 0.0,
      childAspectRatio: double.tryParse(json['childAspectRatio'].toString()) ??
          double.infinity,
    );
  }

  static pw.Stack stack(
    Dict json,
  ) {
    return pw.Stack(
      alignment: PdfWidgetUtil.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.topLeft,
      children: PdfWidget.children(json),
      overflow: PdfWidgetUtil.overflow(json['overflow'] as String?) ??
          pw.Overflow.clip,
      fit: PdfWidgetUtil.stackFit(json['fit'] as String?) ?? pw.StackFit.loose,
    );
  }

  static pw.Positioned positioned(
    Dict json,
  ) {
    double? left = double.tryParse(json['left'].toString());
    double? top = double.tryParse(json['top'].toString());
    double? right = double.tryParse(json['right'].toString());
    double? bottom = double.tryParse(json['bottom'].toString());
    return pw.Positioned(
      child: PdfWidget.child(json),
      left: left != null ? left * PdfPageFormat.mm : null,
      top: top != null ? top * PdfPageFormat.mm : null,
      right: right != null ? right * PdfPageFormat.mm : null,
      bottom: bottom != null ? bottom * PdfPageFormat.mm : null,
    );
  }
}
