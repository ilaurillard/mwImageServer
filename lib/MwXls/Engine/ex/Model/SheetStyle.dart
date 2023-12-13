import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/Range.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/RowStyle.dart';

import 'CellIndex.dart';
import 'CellStyle.dart';
import 'ColIndex.dart';

class SheetStyle {
  final int freezeRows;
  final int freezeColumns;
  final List<double> columnWidths;
  final List<CellStyle?> cellStyles;
  final int autoFilterRow;
  final List<Range> mergeCells;
  final CellStyle? defaultCellStyle;
  final RowStyle? defaultRowStyle;

  const SheetStyle({
    this.freezeRows = -1,
    this.freezeColumns = -1,
    this.columnWidths = const [],
    this.cellStyles = const [],
    this.autoFilterRow = -1,
    this.mergeCells = const [],
    this.defaultRowStyle,
    this.defaultCellStyle,
  });

  String freezeXml() {
    String xml = '';
    if (freezeRows > -1 && freezeColumns > -1) {
      xml +=
          '<pane ySplit="$freezeRows" xSplit="$freezeColumns" topLeftCell="${_xlsCell(
        freezeRows,
        freezeColumns,
      )}" activePane="bottomRight" state="frozen"/>\n';
      xml += '<selection activeCell="${_xlsCell(
        freezeRows,
        0,
      )}" activeCellId="0" pane="topRight" sqref="${_xlsCell(
        freezeRows,
        0,
      )}"/>\n';
      xml += '<selection activeCell="${_xlsCell(
        0,
        freezeColumns,
      )}" activeCellId="0" pane="bottomLeft" sqref="${_xlsCell(
        0,
        freezeColumns,
      )}"/>\n';
      xml += '<selection activeCell="${_xlsCell(
        freezeRows,
        freezeColumns,
      )}" activeCellId="0" pane="bottomRight" sqref="${_xlsCell(
        freezeRows,
        freezeColumns,
      )}"/>\n';
    } else if (freezeRows > -1) {
      xml += '<pane ySplit="$freezeRows" topLeftCell="${_xlsCell(
        freezeRows,
        0,
      )}" activePane="bottomLeft" state="frozen"/>\n';
      xml += '<selection activeCell="${_xlsCell(
        freezeRows,
        0,
      )}" activeCellId="0" pane="bottomLeft" sqref="${_xlsCell(
        freezeRows,
        0,
      )}"/>\n';
    } else if (freezeColumns > -1) {
      xml += '<pane xSplit="$freezeColumns" topLeftCell="${_xlsCell(
        0,
        freezeColumns,
      )}" activePane="topRight" state="frozen"/>\n';
      xml += '<selection activeCell="${_xlsCell(
        0,
        freezeColumns,
      )}" activeCellId="0" pane="topRight" sqref="${_xlsCell(
        0,
        freezeColumns,
      )}"/>\n';
    } else {
      // not frozen
      xml +=
          '<selection activeCell="A1" activeCellId="0" pane="topLeft" sqref="A1"/>\n';
    }
    return xml;
  }

  CellIndex _xlsCell(
    int rowIndex, // 1..n
    int colIndex, // 1..n
  ) {
    return CellIndex.fromColAndRow(
      ColIndex.fromValue(colIndex - 1),
      rowIndex,
    );
  }

  static SheetStyle fromJson(
    Dict json, {
    required State state,
  }) {
    Dict? defaultCellStyle = json['defaultCellStyle'] as Dict?;
    Dict? defaultRowStyle = json['defaultRowStyle'] as Dict?;

    return SheetStyle(
      freezeRows: int.tryParse(json['freezeRows'].toString()) ?? -1,
      freezeColumns: int.tryParse(json['freezeColumns'].toString()) ?? -1,
      columnWidths: (json['columnWidths'] as List<dynamic>? ?? [])
          .map((dynamic e) => double.tryParse(e.toString()) ?? 0.0)
          .toList(),
      cellStyles: (json['cellStyles'] as List<dynamic>? ?? [])
          .map((dynamic e) => CellStyle.fromJson(
                e as Dict? ?? {},
                state: state,
              ))
          .toList(),
      autoFilterRow: int.tryParse(json['autoFilterRow'].toString()) ?? -1,
      mergeCells: (json['mergeCells'] as List<dynamic>? ?? [])
          .map((dynamic e) => Range.fromJson(e as String? ?? ''))
          .toList(),
      defaultCellStyle: defaultCellStyle != null
          ? CellStyle.fromJson(
              defaultCellStyle,
              state: state,
            )
          : null,
      defaultRowStyle: defaultRowStyle != null
          ? RowStyle.fromJson(
              defaultRowStyle,
              state: state,
            )
          : null,
    );
  }

  String mergeCellsXml() {
    String xml = '';
    if (mergeCells.isNotEmpty) {
      xml += '<mergeCells>\n';
      for (Range range in mergeCells) {
        xml += '<mergeCell ref="$range"/>\n';
      }
      xml += '</mergeCells>\n';
    }
    return xml;
  }
}
