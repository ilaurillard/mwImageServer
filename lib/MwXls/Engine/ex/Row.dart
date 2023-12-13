import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';

import 'Cell.dart';
import 'Model/CellIndex.dart';
import 'Model/CellStyle.dart';
import 'Model/ColIndex.dart';
import 'Model/RowStyle.dart';
import 'Styles.dart';

class Row {
  List<Cell?> cells;
  List<CellStyle?> cellStyles;
  RowStyle? style;
  final CellStyle? defaultCellStyle;

  Row({
    this.cells = const [],
    this.cellStyles = const [],
    this.style,
    this.defaultCellStyle,
  }) {
    if (cells.isEmpty) {
      cells = [];
    }
  }

  String toXml(
    int rowIndex, // 1..n
    {
    required List<CellStyle?> sheetCellStyles,
    required RowStyle? sheetRowStyle,
    required CellStyle? sheetCellStyle,
    required Styles styles,
  }) {
    String xml = '';
    RowStyle rowStyle = style ?? sheetRowStyle ?? styles.defaultRowStyle;

    String collapsed = rowStyle.collapsed ? 'true' : 'false';
    String customFormat = rowStyle.customFormat ? 'true' : 'false';
    String customHeight = rowStyle.customHeight ? 'true' : 'false';
    String hidden = rowStyle.hidden ? 'true' : 'false';
    int outlineLevel = 0;
    xml +=
        '<row collapsed="$collapsed" customFormat="$customFormat" customHeight="$customHeight" hidden="$hidden" ht="${rowStyle.height}" outlineLevel="$outlineLevel" r="$rowIndex">\n';
    int i = 0;
    for (Cell? c in cells) {
      if (c != null) {
        xml += c.toXml(
          CellIndex.fromColAndRow(
            ColIndex.fromValue(i),
            rowIndex,
          ),
          style: (cellStyles.length > i && cellStyles[i] != null
              ? cellStyles[i]!
              : (defaultCellStyle != null
                  ? defaultCellStyle!
                  : (sheetCellStyles.length > i && sheetCellStyles[i] != null
                      ? sheetCellStyles[i]!
                      : (sheetCellStyle ?? styles.defaultCellStyle)))),
          styles: styles,
        );
      }
      i++;
    }
    xml += '</row>\n';
    return xml;
  }

  static Row fromJson(
    Dict json, {
    required State state,
  }) {
    Dict? style = json['style'] as Dict?;
    Dict? defaultCellStyle = json['defaultCellStyle'] as Dict?;
    return Row(
      cells: (json['cells'] as List<dynamic>? ?? [])
          .map((dynamic e) => Cell.fromJson(
                e as Dict? ?? {},
                state: state,
              ))
          .toList(),
      style: style != null
          ? RowStyle.fromJson(
              style,
              state: state,
            )
          : null,
      cellStyles: (json['cellStyles'] as List<dynamic>? ?? [])
          .map((dynamic e) => CellStyle.fromJson(
                e as Dict? ?? {},
                state: state,
              ))
          .toList(),
      defaultCellStyle: defaultCellStyle != null
          ? CellStyle.fromJson(
              defaultCellStyle,
              state: state,
            )
          : null,
    );
  }
}
