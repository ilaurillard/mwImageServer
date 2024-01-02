import 'dart:convert';

import 'package:archive/src/archive_file.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';

import 'Model/CellStyle.dart';
import 'Model/RowStyle.dart';
import 'Util.dart';

class Styles {
  final String _filename = 'xl/styles.xml';

  List<String> numberFormats = [];
  List<CellStyle> cellStyles = [];
  List<String> fills = ['', '']; // none + gray125
  List<String> fonts = ['', '', '', ''];
  List<String> borders = [''];

  late final CellStyle defaultCellStyle;
  late final RowStyle defaultRowStyle;

  Map<String, String> defaultFont = {
    'size': '10.0',
    'name': 'Arial',
    'family': '2',
    'style': '',
    'color': '',
  };

  Map<String, String> defaultBorders = {
    'sides': '',
    'style': '',
    'color': '',
  };

  Styles({
    CellStyle? defaultCellStyle,
    RowStyle? defaultRowStyle,
  }) {
    this.defaultCellStyle = defaultCellStyle ?? CellStyle();
    registerStyle(
      this.defaultCellStyle,
    );
    this.defaultRowStyle = defaultRowStyle ?? RowStyle();
  }

  int registerBorder(
    List<BorderSide> borderSides,
    BorderStyle borderStyle,
    String borderColor,
  ) {
    Map<String, String> borderData = {...defaultBorders};

    borderData['sides'] =
        borderSides.map((BorderSide s) => s.name).toList().join(',');

    if (borderStyle != BorderStyle.none) {
      borderData['style'] = borderStyle.name;
    }
    if (borderColor.isNotEmpty && borderColor[0] == '#') {
      borderData['color'] = _normalizeColor(borderColor);
    }
    String bd = json.encode(borderData);
    if (bd == json.encode(defaultBorders)) {
      return 0;
    }
    int i = borders.indexWhere((borderData) => borderData == bd);
    if (i == -1) {
      borders.add(bd);
    }
    return i;
  }

  int registerFont(
    String color,
    double size,
    String font,
    List<FontStyle> styles,
  ) {
    Map<String, String> fontData = {...defaultFont};
    if (color.isNotEmpty && color[0] == '#') {
      fontData['color'] = _normalizeColor(color);
    }
    if (font.isNotEmpty) {
      fontData['name'] = font;
    }
    if (size.toString().isNotEmpty) {
      fontData['size'] = size.toString();
    }
    if (styles.isNotEmpty) {
      fontData['styles'] =
          styles.map((FontStyle e) => e.name).toList().join(',');
    }

    // print(fontData);

    String fd = json.encode(fontData);
    if (fd == json.encode(defaultFont)) {
      return 0;
    }
    int i = fonts.indexWhere((fontData) => fontData == fd);
    if (i == -1) {
      fonts.add(fd);
    }
    return i;
  }

  int registerFill(
    String color,
  ) {
    if (color.isEmpty || color[0] != '#') {
      return 0;
    }
    String tmp = _normalizeColor(color);
    int i = fills.indexOf(tmp);
    if (i == -1) {
      fills.add(tmp);
      // print(fills);
      return fills.length - 1;
    }
    return i;
  }

  int registerStyle(
    CellStyle cellStyle,
  ) {
    if (cellStyle.index > -1) {
      // already added
      return cellStyle.index;
    }

    registerNumberFormat(
      cellStyle.format,
    );

    String hash = cellStyle.hash;
    int i =
        cellStyles.indexWhere((CellStyle cellStyle) => cellStyle.hash == hash);
    if (i == -1) {
      cellStyles.add(cellStyle);
      i = cellStyles.length - 1;
    }
    cellStyle.index = i;
    return i;
  }

  int registerNumberFormat(
    String numberFormat,
  ) {
    int i = numberFormats.indexOf(numberFormat);
    if (i == -1) {
      numberFormats.add(numberFormat);
      return numberFormats.length - 1;
    }
    return i;
  }

  String _toXml() {
    String xml = '';

    xml += '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">\n';

    // number formats
    xml += '<numFmts count="${numberFormats.length}">\n';
    int i = 0;
    for (String f in numberFormats) {
      xml += '<numFmt numFmtId="${164 + i}" formatCode="$f" />\n';
      i++;
    }
    xml += '</numFmts>\n';

    // precalculate
    for (CellStyle s in cellStyles) {
      registerFill(s.fill);
      registerFont(
        s.color,
        s.fontSize,
        s.font,
        s.fontStyles,
      );
      registerBorder(
        s.borderSides,
        s.borderStyle,
        s.borderColor,
      );
    }

    xml += '<fonts count="${fonts.length}">\n';
    xml +=
        '<font><name val="Arial"/><charset val="1"/><family val="2"/><sz val="10"/></font>\n';
    xml += '<font><name val="Arial"/><family val="0"/><sz val="10"/></font>\n';
    xml += '<font><name val="Arial"/><family val="0"/><sz val="10"/></font>\n';
    xml += '<font><name val="Arial"/><family val="0"/><sz val="10"/></font>\n';
    for (String font in fonts) {
      if (font.isNotEmpty) {
        Dict f = json.decode(font) as Dict;
        xml += '<font>\n';
        xml += '<name val="${Util.escapeXml(f['name'].toString())}" />'
            '<charset val="1"/>'
            '<family val="${f['family']}"/>\n';
        xml += '<sz val="${f['size']}" />';
        String color = (f['color'] as String?) ?? '';
        if (color.isNotEmpty) {
          xml += '<color rgb="$color" />\n';
        }
        String style = (f['styles'] as String?) ?? '';
        if (style.contains('bold')) {
          xml += '<b val="true"/>\n';
        }
        if (style.contains('italic')) {
          xml += '<i val="true"/>\n';
        }
        if (style.contains('underline')) {
          xml += '<u val="true"/>\n';
        }
        if (style.contains('strike')) {
          xml += '<strike val="true"/>\n';
        }
        xml += '</font>\n';
      }
    }

    xml += '</fonts>\n';

    // ----------

    xml += '<fills count="${fills.length}">\n';
    xml += '<fill><patternFill patternType="none"/></fill>\n';
    xml += '<fill><patternFill patternType="gray125"/></fill>\n';
    for (String fill in fills) {
      if (fill.isNotEmpty) {
        xml +=
            '<fill><patternFill patternType="solid"><fgColor rgb="$fill"/><bgColor indexed="64"/></patternFill></fill>\n';
      }
    }
    xml += '</fills>\n';

    // ----------

    xml += '<borders count="${borders.length}">\n';
    xml +=
        '<border diagonalDown="false" diagonalUp="false"><left/><right/><top/><bottom/><diagonal/></border>\n';

    for (String border in borders) {
      if (border.isNotEmpty) {
        Dict b = json.decode(border) as Dict;

        xml += '<border diagonalDown="false" diagonalUp="false">\n';

        List<String> showSides = (b['sides'] as String? ?? '').split(',');
        for (String s in ['left', 'right', 'top', 'bottom']) {
          if (showSides.contains(s)) {
            String style = b['style'] as String? ?? '';
            String color = b['color'] as String? ?? '';
            xml += '<$s style="$style">$color</$s>\n';
          } else {
            xml += '<$s/>\n';
          }
        }

        xml += '<diagonal/></border>\n';
      }
    }

    xml += '</borders>\n';

    // print(xml);

    // ----------

    xml += '<cellStyleXfs count="20">\n';
    xml +=
        '<xf applyAlignment="true" applyBorder="true" applyFont="true" applyProtection="true" borderId="0" fillId="0" fontId="0" numFmtId="164">\n';
    xml +=
        '<alignment horizontal="general" indent="0" shrinkToFit="false" textRotation="0" vertical="bottom" wrapText="false"/>\n';
    xml += '<protection hidden="false" locked="true"/>\n';
    xml += '</xf>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="0"/>\n';

    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="0"/>\n';

    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="2" numFmtId="0"/>\n';

    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="2" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="0" numFmtId="0"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="43"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="41"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="44"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="42"/>\n';
    xml +=
        '<xf applyAlignment="false" applyBorder="false" applyFont="true" applyProtection="false" borderId="0" fillId="0" fontId="1" numFmtId="9"/>\n';
    xml += '</cellStyleXfs>\n';

    // --------------

    xml += '<cellXfs count="${cellStyles.length}">\n';
    i = 0;
    for (CellStyle s in cellStyles) {
      int fillIndex = registerFill(s.fill);
      int fontIndex = registerFont(
        s.color,
        s.fontSize,
        s.font,
        s.fontStyles,
      );
      int borderIndex = registerBorder(
        s.borderSides,
        s.borderStyle,
        s.borderColor,
      );
      int formatIdx = registerNumberFormat(
        s.format,
      );
      // ----
      xml +=
          '<xf applyAlignment="${s.applyAlignment}" applyBorder="${s.applyBorder}" applyFont="${s.applyFont}" applyProtection="false" borderId="$borderIndex" fillId="$fillIndex" fontId="$fontIndex" numFmtId="${164 + formatIdx}" xfId="0">\n';
      xml +=
          '	<alignment horizontal="${s.halign.name}" vertical="${s.valign.name}" textRotation="0" wrapText="${s.wrapText}" indent="0" shrinkToFit="false"/>\n';
      xml += '	<protection locked="true" hidden="false"/>\n';
      xml += '</xf>\n';
      i++;
    }
    xml += '</cellXfs>\n';

    // print(xml);

    // --------------

    xml += '<cellStyles count="6">\n';
    xml +=
        '<cellStyle builtinId="0" customBuiltin="false" name="Normal" xfId="0"/>\n';
    xml +=
        '<cellStyle builtinId="3" customBuiltin="false" name="Comma" xfId="15"/>\n';
    xml +=
        '<cellStyle builtinId="6" customBuiltin="false" name="Comma [0]" xfId="16"/>\n';
    xml +=
        '<cellStyle builtinId="4" customBuiltin="false" name="Currency" xfId="17"/>\n';
    xml +=
        '<cellStyle builtinId="7" customBuiltin="false" name="Currency [0]" xfId="18"/>\n';
    xml +=
        '<cellStyle builtinId="5" customBuiltin="false" name="Percent" xfId="19"/>\n';

    xml += '</cellStyles>\n';
    xml += '</styleSheet>\n';

    // print(xml);

    return xml;
  }

  String _normalizeColor(
    String color,
  ) {
    String tmp = color.substring(1);
    if (tmp.length == 3) {
      tmp = tmp[0] + tmp[0] + tmp[1] + tmp[1] + tmp[2] + tmp[2];
    }
    return 'FF$tmp';
  }

  ArchiveFile file() {
    String xml = _toXml();
    return ArchiveFile(
      _filename,
      xml.length,
      xml,
    );
  }
}
