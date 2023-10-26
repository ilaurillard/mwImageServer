import 'package:collection/collection.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Widget/Etc.dart';
import '../Widget/Widget.dart';

class Theme {
  final pw.PageTheme theme;

  Theme(this.theme);

  static Theme fromJson(
    Dict json,
    Resources resources,
  ) {
    // print('Theme: $json');

    String o = json['orientation'] as String? ?? '';
    pw.PageOrientation? orientation =
        pw.PageOrientation.values.firstWhereOrNull((e) => e.name == o);

    pw.Widget? foreground = json['foreground'] != null
        ? Widget.parse(
            json['foreground'] as Dict? ?? {},
            resources,
          )
        : null;
    pw.Widget? background = json['background'] != null
        ? Widget.parse(
            json['background'] as Dict? ?? {},
            resources,
          )
        : null;

    pw.PageTheme theme = pw.PageTheme(
      pageFormat: pageFormat((json['format'] as Dict?) ?? {}),
      theme: styles(
        (json['styles'] as Dict?) ?? {},
        resources,
      ),
      orientation: orientation,
      margin: Etc.edgeInsets(
        json['margin'] as List<dynamic>?,
      ),
      clip: Types.boolFromDict(json, 'clip'),
      textDirection: Etc.textDirection(
        json['textDirection'] as String? ?? '',
      ),
      buildBackground: background != null ? (context) => background : null,
      buildForeground: foreground != null ? (context) => foreground : null,
    );

    return Theme(theme);
  }

  static pw.ThemeData styles(
    Dict json,
    Resources resources,
  ) {
    // print('Styles: $json');

    String to = json['overflow'] as String? ?? '';
    pw.TextOverflow? overflow =
        pw.TextOverflow.values.firstWhereOrNull((e) => e.name == to);

    return pw.ThemeData(
      defaultTextStyle: Etc.textStyle(
        (json['text'] as Dict?) ?? {},
        resources,
      ),
      paragraphStyle: Etc.textStyle(
        (json['paragraph'] as Dict?) ?? {},
        resources,
      ),
      header0: Etc.textStyle(
        (json['header0'] as Dict?) ?? {},
        resources,
      ),
      header1: Etc.textStyle(
        (json['header1'] as Dict?) ?? {},
        resources,
      ),
      header2: Etc.textStyle(
        (json['header2'] as Dict?) ?? {},
        resources,
      ),
      header3: Etc.textStyle(
        (json['header3'] as Dict?) ?? {},
        resources,
      ),
      header4: Etc.textStyle(
        (json['header4'] as Dict?) ?? {},
        resources,
      ),
      header5: Etc.textStyle(
        (json['header5'] as Dict?) ?? {},
        resources,
      ),
      bulletStyle: Etc.textStyle(
        (json['bulletStyle'] as Dict?) ?? {},
        resources,
      ),
      tableHeader: Etc.textStyle(
        (json['tableHeader'] as Dict?) ?? {},
        resources,
      ),
      tableCell: Etc.textStyle(
        (json['tableCell'] as Dict?) ?? {},
        resources,
      ),
      softWrap: json['softWrap'] as bool?,
      textAlign: Etc.textAlign(json['textAlign'] as String?),
      overflow: overflow,
      maxLines: json['maxLines'] as int?,
      iconTheme: iconTheme(
        (json['iconTheme'] as Dict?) ?? {},
        resources,
      ),
    );
  }

  static pw.IconThemeData? iconTheme(
    Dict json,
    Resources resources,
  ) {
    // print('IconTheme: $json');

    return pw.IconThemeData(
      color: Etc.color(json['color'] as String?) ?? PdfColors.black,
      opacity: double.tryParse(json['opacity'].toString()),
      size: double.tryParse(json['size'].toString()),
      font: Etc.font(
            json['font'] as String?,
            resources,
          ) ??
          resources.materialFont(),
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

  static Map<String, Theme> fromJsonAll(
    Dict json,
    Resources resources,
  ) {
    return json.map((k, v) {
      return MapEntry(
          k,
          Theme.fromJson(
            v as Dict,
            resources,
          ));
    });
  }

  static pw.PageTheme defaultTheme(
    Resources resources,
  ) {
    return pw.PageTheme(
      theme: pw.ThemeData(
        iconTheme: iconTheme(
          {},
          resources,
        ),
      ),
    );
  }
}
