import 'package:mwcdn/MwXls/Engine/ex/Model/CellStyle.dart';

class Util {
  static String color(
    String color,
  ) {
    return color.isNotEmpty ? '#$color' : '';
  }

  static HorizontalAlignment? horizontalAlignment(
    String? json,
  ) {
    if (json != null) {
      return HorizontalAlignment.values.byName(json);
    }
    return null;
  }

  static VerticalAlignment? verticalAlignment(
    String? json,
  ) {
    if (json != null) {
      return VerticalAlignment.values.byName(json);
    }
    return null;
  }

  static BorderStyle? borderStyle(
    String? json,
  ) {
    if (json != null) {
      return BorderStyle.values.byName(json);
    }
    return null;
  }

  static List<BorderSide> borderSides(
      List<String>? sides
      ) {
    if (sides != null) {
      return sides.map((String e) => BorderSide.values.byName(e)).toList();
    }
    return [];
  }

  static List<FontStyle> fontStyles(
      List<String>? styles
      ) {
    if (styles != null) {
      return styles.map((String e) => FontStyle.values.byName(e)).toList();
    }
    return [];
  }

  static String escapeXml(
      String input,
      ) {
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      switch (char) {
        case '&':
          buffer.write('&amp;');
          break;
        case '<':
          buffer.write('&lt;');
          break;
        case '>':
          buffer.write('&gt;');
          break;
        case '"':
          buffer.write('&quot;');
          break;
        case "'":
          buffer.write('&apos;');
          break;
        default:
          buffer.write(char);
          break;
      }
    }

    return buffer.toString();
  }
}
