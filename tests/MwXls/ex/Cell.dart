import 'Excel.dart';
import 'Model/CellIndex.dart';
import 'Model/CellStyle.dart';
import 'Styles.dart';

class Cell {
  final dynamic value;

  final CellStyle? style;

  Cell({
    this.value,
    this.style,
  });

  String toXml(
    CellIndex index, {
    required CellStyle style,
    required Styles styles,
  }) {
    if (this.style != null) {
      style = this.style!;
    }
    styles.registerStyle(style);

    // print('${style.index}');
    // print('${style.comment} ${style.index}');

    // print(style.type);
    String asString = value.toString();
    if (value.runtimeType == bool) {
      int asBool = value as bool ? 1 : 0;
      return '<c r="${index.name}" s="${style.index}" t="b"><v>$asBool</v></c>\n';
    } else if (value == '') {
      return '<c r="${index.name}" s="${style.index}" />\n';
    } else if (asString.isNotEmpty && asString[0] == '=') {
      return '<c r="${index.name}" s="${style.index}" t="s"><f>${Excel.escapeXml(asString)}</f></c>\n';
    } else if (style.type == CellType.nDate) {
      // TODO .. plus intval
      String asDateTime = value.toString();
      return '<c r="${index.name}" s="${style.index}" t="n"><v>$asDateTime</v></c>\n';
    } else if (style.type == CellType.nDatetime) {
      // TODO
      String asDateTime = value.toString();
      return '<c r="${index.name}" s="${style.index}" t="n"><v>$asDateTime</v></c>\n';
    } else if (style.type == CellType.nNumeric) {
      return '<c r="${index.name}" s="${style.index}" t="n"><v>$value</v></c>\n';
    } else if (style.type == CellType.nString) {
      return '<c r="${index.name}" s="${style.index}" t="inlineStr"><is><t>${Excel.escapeXml(asString)}</t></is></c>\n';
    } else if (style.type == CellType.nAuto || true) {
      if (value.runtimeType != String ||
          (asString.isNotEmpty &&
              asString[0] != '0' &&
              asString.contains(RegExp(r'^[0-9]+$'))) ||
          asString.contains(RegExp(r'^\-?(0|[1-9][0-9]*)(\.[0-9]+)?$'))) {
        return '<c r="${index.name}" s="${style.index}" t="n"><v>$value</v></c>\n';
      }

      return '<c r="${index.name}" s="${style.index}" t="inlineStr"><is><t>${Excel.escapeXml(asString)}</t></is></c>\n';
    }
  }
}
