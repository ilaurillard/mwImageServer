import 'dart:convert';

class CellStyle {
  late String format;
  late CellType type;
  final bool applyAlignment;
  final bool applyBorder;
  final bool wrapText;
  final bool applyFont;
  final HorizontalAlignment halign;
  final VerticalAlignment valign;
  final String fill;
  final String color;
  final double fontSize;
  final String font;
  final String fontStyle;
  final List<BorderSide> borderSides;
  final BorderStyle borderStyle;
  final String borderColor;

  late final String hash;
  int index = -1;

  static const defaultFormat = 'GENERAL';

  CellStyle({
    this.format = defaultFormat,
    this.applyAlignment = false,
    this.applyBorder = false,
    this.wrapText = false,
    this.applyFont = true,
    this.halign = HorizontalAlignment.general,
    this.valign = VerticalAlignment.bottom,
    this.fill = '',
    this.color = '',
    this.font = '',
    this.fontSize = 10,
    this.fontStyle = '',
    this.borderSides = const [],
    this.borderStyle = BorderStyle.none,
    this.borderColor = '',
  }) {
    format = _formatStandardized(
      format,
    );
    type = _type(
      format,
    );
    hash = createHash();
    // print(hash);
  }

  CellStyle copyWith({
    String? format,
    bool? applyAlignment,
    bool? applyBorder,
    bool? wrapText,
    bool? applyFont,
    HorizontalAlignment? halign,
    VerticalAlignment? valign,
    String? fill,
    String? color,
    String? font,
    double? fontSize,
    String? fontStyle,
  }) {
    return CellStyle(
      format: format ?? this.format,
      applyAlignment: applyAlignment ?? this.applyAlignment,
      applyBorder: applyBorder ?? this.applyBorder,
      wrapText: wrapText ?? this.wrapText,
      applyFont: applyFont ?? this.applyFont,
      halign: halign ?? this.halign,
      valign: valign ?? this.valign,
      fill: fill ?? this.fill,
      color: color ?? this.color,
      font: font ?? this.font,
      fontSize: fontSize ?? this.fontSize,
      fontStyle: fontStyle ?? this.fontStyle,
    );
  }

  String _formatStandardized(
    String format,
  ) {
    if (format == 'money') {
      format = 'euro';
    } else if (format == 'number') {
      format = 'integer';
    }

    // ----------

    if (format == 'string') {
      format = '@';
    } else if (format == 'integer') {
      format = '0';
    } else if (format == 'date') {
      format = 'YYYY-MM-DD';
    } else if (format == 'datetime') {
      format = 'YYYY-MM-DD HH:MM:SS';
    } else if (format == 'time') {
      format = 'HH:MM:SS';
    } else if (format == 'price') {
      format = '#,##0.00';
    } else if (format == 'dollar') {
      format = '[\$\$-1009]#,##0.00;[RED]-[\$\$-1009]#,##0.00';
    } else if (format == 'euro') {
      format = '#,##0.00 [\$€-407];[RED]-#,##0.00 [\$€-407]';
    } else if (format == 'chf') {
      format = '#,##0.00 [\$CHF];[RED]-#,##0.00 [\$CHF]';
    }

    // -----------

    String ignoreUntil = '';
    String escaped = '';
    for (int i = 0; i < format.length; i++) {
      String c = format[i];
      if (ignoreUntil == '' && c == '[') {
        ignoreUntil = ']';
      } else {
        if (ignoreUntil == '' && c == '"') {
          ignoreUntil = '"';
        } else {
          if (ignoreUntil == c) {
            ignoreUntil = '';
          }
        }
      }
      if (ignoreUntil == '' &&
          (c == ' ' || c == '-' || c == '(' || c == ')') &&
          (i == 0 || format[i - 1] != '_')) {
        escaped += '\\$c';
      } else {
        escaped += c;
      }
    }
    return escaped;
  }

  CellType _type(
    String format,
  ) {
    format = format.replaceAll(
      RegExp(
        r'\[(Black|Blue|Cyan|Green|Magenta|Red|White|Yellow)\]',
        caseSensitive: false,
      ),
      '',
    );
    if (format == CellStyle.defaultFormat) {
      return CellType.nAuto;
    }
    if (format == '@') {
      return CellType.nString;
    }
    if (format == '0') {
      return CellType.nNumeric;
    }

    if (format.contains(
      RegExp(r'M{1,2}:S{1,2}(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nDatetime;
    }
    if (format.contains(
      RegExp(r'Y{2,4}(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nDate;
    }
    if (format.contains(
      RegExp(r'D{1,2}(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nDate;
    }
    if (format.contains(
      RegExp(r'M{1,2}(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nDate;
    }
    if (format.contains(
      RegExp(r'$(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nNumeric;
    }
    if (format.contains(
      RegExp(r'%(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nNumeric;
    }
    if (format.contains(
      RegExp(r'0(?![^"]*")', caseSensitive: false),
    )) {
      return CellType.nNumeric;
    }
    return CellType.nAuto;
  }

  String createHash() {
    return json.encode({
      'format': format,
      'type': type.name,
      'applyAlignment': applyAlignment,
      'applyBorder': applyBorder,
      'wrapText': wrapText,
      'applyFont': applyFont,
      'halign': halign.name,
      'valign': valign.name,
      'fill': fill,
      'color': color,
      'font': font,
      'fontSize': fontSize,
      'fontStyle': fontStyle,
    });
  }
}

enum CellType {
  nAuto,
  nString,
  nNumeric,
  nDatetime,
  nDate,
}

extension CellTypeLabel on CellType {
  String get name {
    switch (this) {
      case CellType.nAuto:
        return 'n_auto';
      case CellType.nString:
        return 'n_string';
      case CellType.nNumeric:
        return 'n_numeric';
      case CellType.nDatetime:
        return 'n_datetime';
      case CellType.nDate:
        return 'n_date';
    }
  }
}

enum BorderSide {
  left,
  right,
  top,
  bottom,
}

enum BorderStyle {
  none,
  thin,
  medium,
  thick,
  dashDot,
  dashDotDot,
  dashed,
  dotted,
  double,
  hair,
  mediumDashDot,
  mediumDashDotDot,
  mediumDashed,
  slantDashDot,
}

enum HorizontalAlignment {
  general,
  left,
  right,
  justify,
  center,
}

enum VerticalAlignment {
  bottom,
  center,
  distributed,
  top,
}
