import 'package:collection/collection.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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

    String td = json['textDirection'] as String? ?? '';
    pw.TextDirection? textDirection =
        pw.TextDirection.values.firstWhereOrNull((e) => e.name == td);

    pw.PageTheme theme = pw.PageTheme(
      pageFormat:
          fromJsonPageFormat((json['format'] as Dict?) ?? {}),
      // TODO
      buildBackground: null,
      // TODO
      buildForeground: null,
      theme: fromJsonStyles((json['styles'] as Dict?) ?? {}),
      orientation: orientation,
      // TODO EdgeInsets
      margin: null,
      clip: json['clip'] as bool? ?? false,
      textDirection: textDirection,
    );

    // print(theme.theme!.iconTheme.size);

    return PdfTheme(theme);
  }

  static pw.ThemeData fromJsonStyles(
    Dict json,
  ) {
    // print('Styles: $json');

    String ta = json['textAlign'] as String? ?? '';
    pw.TextAlign? textAlign =
        pw.TextAlign.values.firstWhereOrNull((e) => e.name == ta);

    String to = json['overflow'] as String? ?? '';
    pw.TextOverflow? overflow =
        pw.TextOverflow.values.firstWhereOrNull((e) => e.name == to);

    return pw.ThemeData(
      defaultTextStyle:
          fromJsonTextStyle((json['text'] as Dict?) ?? {}),
      paragraphStyle:
          fromJsonTextStyle((json['paragraph'] as Dict?) ?? {}),
      header0:
          fromJsonTextStyle((json['header0'] as Dict?) ?? {}),
      header1:
          fromJsonTextStyle((json['header1'] as Dict?) ?? {}),
      header2:
          fromJsonTextStyle((json['header2'] as Dict?) ?? {}),
      header3:
          fromJsonTextStyle((json['header3'] as Dict?) ?? {}),
      header4:
          fromJsonTextStyle((json['header4'] as Dict?) ?? {}),
      header5:
          fromJsonTextStyle((json['header5'] as Dict?) ?? {}),
      bulletStyle: fromJsonTextStyle(
          (json['bulletStyle'] as Dict?) ?? {}),
      tableHeader: fromJsonTextStyle(
          (json['tableHeader'] as Dict?) ?? {}),
      tableCell:
          fromJsonTextStyle((json['tableCell'] as Dict?) ?? {}),
      softWrap: json['softWrap'] as bool?,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: json['maxLines'] as int?,
      iconTheme: fromJsonIconTheme(
        (json['iconTheme'] as Dict?) ?? {},
      ),
    );
  }

  static pw.TextStyle? fromJsonTextStyle(
    Dict json,
  ) {
    if (json.isEmpty) {
      return null;
    }

    // print('TextStyle: $json');

    String fw = json['fontWeight'] as String? ?? '';
    pw.FontWeight? fontWeight =
        pw.FontWeight.values.firstWhereOrNull((e) => e.name == fw);

    String fs = json['fontStyle'] as String? ?? '';
    pw.FontStyle? fontStyle =
        pw.FontStyle.values.firstWhereOrNull((e) => e.name == fs);

    String ds = json['decorationStyle'] as String? ?? '';
    pw.TextDecorationStyle? decStyle =
        pw.TextDecorationStyle.values.firstWhereOrNull((e) => e.name == ds);

    String rm = json['renderingMode'] as String? ?? '';
    PdfTextRenderingMode? renderingMode =
        PdfTextRenderingMode.values.firstWhereOrNull((e) => e.name == rm);

    return pw.TextStyle(
      color: fromJsonColor(json['color'] as String?),
      font: fromJsonFont(json['font'] as String?),
      fontNormal: fromJsonFont(json['fontNormal'] as String?),
      fontBold: fromJsonFont(json['fontBold'] as String?),
      fontItalic: fromJsonFont(json['fontItalic'] as String?),
      fontBoldItalic: fromJsonFont(json['fontBoldItalic'] as String?),
      fontSize: double.tryParse(json['fontSize'].toString()),
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: double.tryParse(json['letterSpacing'].toString()),
      wordSpacing: double.tryParse(json['wordSpacing'].toString()),
      lineSpacing: double.tryParse(json['lineSpacing'].toString()),
      height: double.tryParse(json['height'].toString()),
      // TODO background
      background: null,
      // TODO decoration none, underline, ...
      decoration: pw.TextDecoration.none,
      decorationColor: fromJsonColor(json['decorationColor'] as String?),
      decorationStyle: decStyle,
      decorationThickness:
          double.tryParse(json['decorationThickness'].toString()),
      renderingMode: renderingMode,
    );
  }

  static pw.IconThemeData? fromJsonIconTheme(
    Dict json,
  ) {
    // print('IconTheme: $json');

    if (json.isEmpty) {
      return null;
    }

    return pw.IconThemeData(
      color: fromJsonColor(json['color'] as String?),
      opacity: double.tryParse(json['opacity'].toString()),
      size: double.tryParse(json['size'].toString()),
      font: fromJsonFont(json['font'] as String?),
    );
  }

  static pw.Font? fromJsonFont(String? json) {
    // print('Font: $json');

    // TODO

    // return pw.Font.courier();

    return null;
  }

  static PdfColor? fromJsonColor(String? json) {
    // print('PdfColor: $json');

    if (json != null) {
      return PdfColor.fromInt(int.parse(json, radix: 16));
    }
    return null;
  }

  static PdfPageFormat fromJsonPageFormat(
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
    double? marginTop = double.tryParse(json['marginTop'].toString()) ?? marginAll;
    double? marginBottom = double.tryParse(json['marginBottom'].toString()) ?? marginAll;
    double? marginLeft = double.tryParse(json['marginLeft'].toString()) ?? marginAll;
    double? marginRight = double.tryParse(json['marginRight'].toString()) ?? marginAll;

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
