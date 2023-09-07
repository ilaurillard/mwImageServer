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
    // TODO
    return pw.Align(
      alignment: PdfWidgetUtil.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: PdfWidget.child(json),
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

    // TODO  constraints, transform
    return pw.Container(
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
      decoration: PdfWidgetUtil.decoration((json['decoration'] as Dict?) ?? {}),
      foregroundDecoration: PdfWidgetUtil.decoration(
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
          PdfWidgetUtil.decoration((json['decoration'] as Dict?) ?? {}) ??
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
      ),
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
      ),
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
}
