import 'CellIndex.dart';
import 'CellStyle.dart';
import 'ColIndex.dart';

class SheetStyles {
  final int freezeRows;
  final int freezeColumns;
  final List<double> colWidths;
  final List<CellStyle?> cellStyles;
  final int autoFilterRow;

  const SheetStyles({
    this.freezeRows = -1,
    this.freezeColumns = -1,
    this.colWidths = const[],
    this.cellStyles = const[],
    this.autoFilterRow = -1,
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
}
