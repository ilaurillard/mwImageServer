import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';
import 'Etc.dart';

class Layout {
  static pw.Center center(
    Dict json,
  ) {
    return pw.Center(
      child: Widget.child(json),
    );
  }

  static pw.Align align(
    Dict json,
  ) {
    double? widthFactor = double.tryParse(json['widthFactor'].toString());
    double? heightFactor = double.tryParse(json['heightFactor'].toString());
    return pw.Align(
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: Widget.child(json),
      widthFactor: widthFactor != null ? widthFactor * PdfPageFormat.mm : null,
      heightFactor:
          heightFactor != null ? heightFactor * PdfPageFormat.mm : null,
    );
  }

  static pw.FittedBox fittedBox(
    Dict json,
  ) {
    return pw.FittedBox(
      fit: Etc.boxFit(
            json['fit'] as String?,
          ) ??
          pw.BoxFit.contain,
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: Widget.child(json),
    );
  }

  static pw.Container container(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    // TODO  transform
    return pw.Container(
      constraints: Etc.boxConstraints(
        json['constraints'] as Dict?,
      ),
      alignment: Etc.alignment(
        json['alignment'] as String?,
      ),
      padding: Etc.edgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: Etc.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      color: Etc.color(
        json['color'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      decoration:
          Etc.boxDecoration((json['decoration'] as Dict?) ?? {}),
      foregroundDecoration: Etc.boxDecoration(
          (json['foregroundDecoration'] as Dict?) ?? {}),
      child: Widget.child(json),
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
      child: Widget.child(json),
    );
  }

  static pw.DecoratedBox decoratedBox(
    Dict json,
  ) {
    return pw.DecoratedBox(
      decoration:
          Etc.boxDecoration((json['decoration'] as Dict?) ?? {}) ??
              pw.BoxDecoration(),
      position: Etc.decorationPosition(
          json['decorationPosition'] as String?),
      child: Widget.child(json),
    );
  }

  static pw.Wrap wrap(
    Dict json,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    double? runSpacing = double.tryParse(json['runSpacing'].toString());
    return pw.Wrap(
      direction: Etc.axis(
            json['direction'] as String?,
          ) ??
          pw.Axis.horizontal,
      alignment: Etc.wrapAlignment(
        json['alignment'] as String?,
      ),
      spacing: spacing != null ? spacing * PdfPageFormat.mm : 0.0,
      runAlignment: Etc.wrapAlignment(
        json['runAlignment'] as String?,
      ),
      runSpacing: runSpacing != null ? runSpacing * PdfPageFormat.mm : 0.0,
      crossAxisAlignment: Etc.wrapCrossAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(json),
    );
  }

  static pw.Row row(
    Dict json,
  ) {
    return pw.Row(
      mainAxisAlignment: Etc.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: Etc.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: Etc.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(json),
    );
  }

  static pw.Column column(
    Dict json,
  ) {
    return pw.Column(
      mainAxisAlignment: Etc.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: Etc.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: Etc.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(json),
    );
  }

  // (obsolete) parent of row/col ..
  static pw.Flex flex(
    Dict json,
  ) {
    return pw.Flex(
      direction: Etc.axis(
            json['direction'] as String?,
          ) ??
          pw.Axis.horizontal,
      mainAxisAlignment: Etc.mainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: Etc.crossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: Etc.mainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: Etc.verticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: Widget.children(json),
    );
  }

  static pw.Expanded expanded(
    Dict json,
  ) {
    return pw.Expanded(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: Etc.flexFit(
        json['fit'] as String?,
      ),
      child: Widget.child(json),
    );
  }

  static pw.Padding padding(
    Dict json,
  ) {
    return pw.Padding(
      padding: Etc.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero,
      child: Widget.child(json),
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
      child: Widget.child(json),
    );
  }

  static pw.ConstrainedBox constrainedBox(
    Dict json,
  ) {
    return pw.ConstrainedBox(
      constraints: Etc.boxConstraints(
            json['constraints'] as Dict?,
          ) ??
          pw.BoxConstraints(),
      child: Widget.child(json),
    );
  }

  static pw.OverflowBox overflowBox(
    Dict json,
  ) {
    return pw.OverflowBox(
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      minWidth: double.tryParse(json['minWidth'].toString()),
      maxWidth: double.tryParse(json['maxWidth'].toString()),
      minHeight: double.tryParse(json['minHeight'].toString()),
      maxHeight: double.tryParse(json['maxHeight'].toString()),
      child: Widget.child(json),
    );
  }

  static pw.Flexible flexible(
    Dict json,
  ) {
    return pw.Flexible(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: Etc.flexFit(
        json['fit'] as String? ?? 'loose',
      ),
      child: Widget.child(json),
    );
  }

  static pw.AspectRatio aspectRatio(
    Dict json,
  ) {
    return pw.AspectRatio(
      aspectRatio: double.tryParse(json['aspectRatio'].toString()) ?? 1,
      child: Widget.child(json),
    );
  }

  static pw.ListView listView(
    Dict json,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    return pw.ListView(
      direction:
          Etc.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      children: Widget.children(json),
      padding: Etc.edgeInsets(
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
          Etc.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      crossAxisCount: int.tryParse(json['crossAxisCount'].toString()) ?? 3,
      children: Widget.children(json),
      padding: Etc.edgeInsets(
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
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.topLeft,
      children: Widget.children(json),
      overflow: Etc.overflow(json['overflow'] as String?) ??
          pw.Overflow.clip,
      fit: Etc.stackFit(json['fit'] as String?) ?? pw.StackFit.loose,
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
      child: Widget.child(json),
      left: left != null ? left * PdfPageFormat.mm : null,
      top: top != null ? top * PdfPageFormat.mm : null,
      right: right != null ? right * PdfPageFormat.mm : null,
      bottom: bottom != null ? bottom * PdfPageFormat.mm : null,
    );
  }
}
