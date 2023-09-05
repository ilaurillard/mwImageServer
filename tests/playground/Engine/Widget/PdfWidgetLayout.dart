import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetLayout {
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
      child: PdfWidget.parse(json['child'] as Dict? ?? {}),
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
      child: PdfWidget.parse(json['child'] as Dict? ?? {}),
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
      child: PdfWidget.parse(json['child'] as Dict? ?? {}),
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
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parse(e as Dict))
          .toList(),
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
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parse(e as Dict))
          .toList(),
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
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parse(e as Dict))
          .toList(),
    );
  }

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
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parse(e as Dict))
          .toList(),
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
      child: PdfWidget.parse(json['child'] as Dict? ?? {}),
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
      child: PdfWidget.parse(json['child'] as Dict? ?? {}),
    );
  }
}
