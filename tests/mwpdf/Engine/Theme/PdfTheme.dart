import 'package:collection/collection.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../engine.dart';
import '../Widget/PdfWidgetUtil.dart';

class PdfTheme {
  final pw.PageTheme theme;

  PdfTheme(this.theme);

  static PdfTheme fromJson(
    Dict json,
  ) {
    // print('Theme: $json');

    String o = json['orientation'] as String? ?? '';
    pw.PageOrientation? orientation =
        pw.PageOrientation.values.firstWhereOrNull((e) => e.name == o);

    pw.PageTheme theme = pw.PageTheme(
      pageFormat: pageFormat((json['format'] as Dict?) ?? {}),
      // TODO
      buildBackground: null,
      // TODO
      buildForeground: null,
      theme: styles((json['styles'] as Dict?) ?? {}),
      orientation: orientation,
      margin: PdfWidgetUtil.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      clip: Types.boolFromDict(json, 'clip'),
      textDirection: PdfWidgetUtil.textDirection(
        json['textDirection'] as String? ?? '',
      ),
    );

    return PdfTheme(theme);
  }

  static pw.ThemeData styles(
    Dict json,
  ) {
    // print('Styles: $json');

    String to = json['overflow'] as String? ?? '';
    pw.TextOverflow? overflow =
        pw.TextOverflow.values.firstWhereOrNull((e) => e.name == to);

    return pw.ThemeData(
      defaultTextStyle: PdfWidgetUtil.textStyle((json['text'] as Dict?) ?? {}),
      paragraphStyle:
          PdfWidgetUtil.textStyle((json['paragraph'] as Dict?) ?? {}),
      header0: PdfWidgetUtil.textStyle((json['header0'] as Dict?) ?? {}),
      header1: PdfWidgetUtil.textStyle((json['header1'] as Dict?) ?? {}),
      header2: PdfWidgetUtil.textStyle((json['header2'] as Dict?) ?? {}),
      header3: PdfWidgetUtil.textStyle((json['header3'] as Dict?) ?? {}),
      header4: PdfWidgetUtil.textStyle((json['header4'] as Dict?) ?? {}),
      header5: PdfWidgetUtil.textStyle((json['header5'] as Dict?) ?? {}),
      bulletStyle:
          PdfWidgetUtil.textStyle((json['bulletStyle'] as Dict?) ?? {}),
      tableHeader:
          PdfWidgetUtil.textStyle((json['tableHeader'] as Dict?) ?? {}),
      tableCell: PdfWidgetUtil.textStyle((json['tableCell'] as Dict?) ?? {}),
      softWrap: json['softWrap'] as bool?,
      textAlign: PdfWidgetUtil.textAlign(json['textAlign'] as String?),
      overflow: overflow,
      maxLines: json['maxLines'] as int?,
      iconTheme: iconTheme(
        (json['iconTheme'] as Dict?) ?? {},
      ),
    );
  }

  static pw.IconThemeData? iconTheme(
    Dict json,
  ) {
    // print('IconTheme: $json');

    return pw.IconThemeData(
      color: PdfWidgetUtil.color(json['color'] as String?),
      opacity: double.tryParse(json['opacity'].toString()),
      size: double.tryParse(json['size'].toString()),
      font: PdfWidgetUtil.font(json['font'] as String?) ??
          fontRegistry['material'],
    );
  }

  static PdfPageFormat pageFormat(
    Dict json,
  ) {
    // print('Format: $json');

    PdfPageFormat format = PdfPageFormat.a4;
    String preset = json['preset'] as String? ?? '';
    switch (preset) {
      case 'a3':
        format = PdfPageFormat.a3;
        break;
      case 'a5':
        format = PdfPageFormat.a5;
        break;
      case 'a6':
        format = PdfPageFormat.a6;
        break;
    }

    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    double? marginAll = double.tryParse(json['marginAll'].toString());
    double? marginTop =
        double.tryParse(json['marginTop'].toString()) ?? marginAll;
    double? marginBottom =
        double.tryParse(json['marginBottom'].toString()) ?? marginAll;
    double? marginLeft =
        double.tryParse(json['marginLeft'].toString()) ?? marginAll;
    double? marginRight =
        double.tryParse(json['marginRight'].toString()) ?? marginAll;

    format = format.copyWith(
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      marginTop: marginTop != null ? marginTop * PdfPageFormat.mm : null,
      marginBottom:
          marginBottom != null ? marginBottom * PdfPageFormat.mm : null,
      marginLeft: marginLeft != null ? marginLeft * PdfPageFormat.mm : null,
      marginRight: marginRight != null ? marginRight * PdfPageFormat.mm : null,
    );

    return format;
  }

  static Map<String, PdfTheme> fromJsonAll(
    Dict json,
  ) {
    return json.map((k, v) {
      return MapEntry(
          k,
          PdfTheme.fromJson(
            v as Dict,
          ));
    });
  }
}
