import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetEnums.dart';

class PdfWidgetLayout {
  static pw.Container parseContainer(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    // TODO decoration, constraints, foregroundDecoration, transform
    return pw.Container(
      alignment: PdfWidgetEnums.parseAlignment(
        json['alignment'] as String?,
      ),
      padding: PdfWidgetEnums.parseEdgeInsets(
        json['padding'] as List<dynamic>?,
      ),
      margin: PdfWidgetEnums.parseEdgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      color: PdfWidgetEnums.parseColor(
        json['color'] as String?,
      ),
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      child: PdfWidget.parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  static pw.SizedBox parseSizedBox(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.SizedBox(
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      child: PdfWidget.parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  static pw.Wrap parseWrap(
    Dict json,
  ) {
    double? spacing = double.tryParse(json['spacing'].toString());
    double? runSpacing = double.tryParse(json['runSpacing'].toString());
    return pw.Wrap(
      direction: PdfWidgetEnums.parseAxis(
        json['direction'] as String?,
      ),
      alignment: PdfWidgetEnums.parseWrapAlignment(
        json['alignment'] as String?,
      ),
      spacing: spacing != null ? spacing * PdfPageFormat.mm : 0.0,
      runAlignment: PdfWidgetEnums.parseWrapAlignment(
        json['runAlignment'] as String?,
      ),
      runSpacing: runSpacing != null ? runSpacing * PdfPageFormat.mm : 0.0,
      crossAxisAlignment: PdfWidgetEnums.parseWrapCrossAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      verticalDirection: PdfWidgetEnums.parseVerticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parseWidget(e as Dict))
          .toList(),
    );
  }

  static pw.Row parseRow(
    Dict json,
  ) {
    return pw.Row(
      mainAxisAlignment: PdfWidgetEnums.parseMainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: PdfWidgetEnums.parseCrossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: PdfWidgetEnums.parseMainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: PdfWidgetEnums.parseVerticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parseWidget(e as Dict))
          .toList(),
    );
  }

  static pw.Column parseColumn(
    Dict json,
  ) {
    return pw.Column(
      mainAxisAlignment: PdfWidgetEnums.parseMainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: PdfWidgetEnums.parseCrossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: PdfWidgetEnums.parseMainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: PdfWidgetEnums.parseVerticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parseWidget(e as Dict))
          .toList(),
    );
  }

  static pw.Flex parseFlex(
    Dict json,
  ) {
    return pw.Flex(
      direction: PdfWidgetEnums.parseAxis(
        json['direction'] as String?,
      ),
      mainAxisAlignment: PdfWidgetEnums.parseMainAxisAlignment(
        json['mainAxisAlignment'] as String?,
      ),
      crossAxisAlignment: PdfWidgetEnums.parseCrossAxisAlignment(
        json['crossAxisAlignment'] as String?,
      ),
      mainAxisSize: PdfWidgetEnums.parseMainAxisSize(
        json['mainAxisSize'] as String?,
      ),
      verticalDirection: PdfWidgetEnums.parseVerticalDirection(
        json['verticalDirection'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parseWidget(e as Dict))
          .toList(),
    );
  }

  static pw.Expanded parseExpanded(
    Dict json,
  ) {
    return pw.Expanded(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: PdfWidgetEnums.parseFlexFit(
        json['fit'] as String?,
      ),
      child: PdfWidget.parseWidget(json['child'] as Dict? ?? {}),
    );
  }

  static pw.Flexible parseFlexible(
    Dict json,
  ) {
    return pw.Flexible(
      flex: int.tryParse(json['flex'].toString()) ?? 1,
      fit: PdfWidgetEnums.parseFlexFit(
        json['fit'] as String? ?? 'loose',
      ),
      child: PdfWidget.parseWidget(json['child'] as Dict? ?? {}),
    );
  }
}
