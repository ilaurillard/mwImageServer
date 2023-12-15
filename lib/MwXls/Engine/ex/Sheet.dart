import 'package:archive/src/archive_file.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';

import 'Model/CellIndex.dart';
import 'Model/ColIndex.dart';
import 'Model/SheetStyle.dart';
import 'Row.dart';
import 'Styles.dart';

class Sheet {
  final String name;
  final SheetStyle sheetStyle;
  List<Row> rows;

  final String filename = 'xl/worksheets/sheet{nr}.xml';

  Sheet({
    this.name = 'Sheet1',
    this.sheetStyle = const SheetStyle(),
    this.rows = const [],
  }) {
    if (rows.isEmpty) {
      rows = [];
    }
  }

  String nameSanitized() {
    // TODO
    return name;
  }

  String rowsToXml(
    Styles styles,
  ) {
    String xml = '';
    int i = 0;
    for (Row row in rows) {
      xml += row.toXml(
        i + 1,
        sheetCellStyles: sheetStyle.cellStyles,
        sheetRowStyle: sheetStyle.defaultRowStyle,
        sheetCellStyle: sheetStyle.defaultCellStyle,
        styles: styles,
      );
      i++;
    }
    return xml;
  }

  String toXml(
    int amountSheets,
    Styles styles,
  ) {
    String maxCellName = maxCell().name;
    String rightToLeftValue = 'false'; // NTH?
    String tabselected = amountSheets == 1 ? 'true' : 'false';

    String xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">\n';
    xml += '<sheetPr filterMode="false">\n';
    xml += '<pageSetUpPr fitToPage="false"/>\n';
    xml += '</sheetPr>\n';

    xml += '<dimension ref="A1:$maxCellName"/>';
    xml += '<sheetViews>';
    xml +=
        '<sheetView colorId="64" defaultGridColor="true" rightToLeft="$rightToLeftValue" showFormulas="false" showGridLines="true" showOutlineSymbols="true" showRowColHeaders="true" showZeros="true" tabSelected="$tabselected" topLeftCell="A1" view="normal" windowProtection="false" workbookViewId="0" zoomScale="100" zoomScaleNormal="100" zoomScalePageLayoutView="100">';

    // ---------------

    xml += sheetStyle.freezeXml();

    // ---------------

    xml += '</sheetView>\n';
    xml += '</sheetViews>\n';

    xml += '<cols>\n';

    int i = 0;
    if (sheetStyle.columnWidths.isNotEmpty) {
      for (double width in sheetStyle.columnWidths) {
        xml += '<col '
            'collapsed="${width == 0 ? 'true' : 'false'}" '
            'hidden="${width == 0 ? 'true' : 'false'}" '
            'max="${i + 1}" '
            'min="${i + 1}" '
            'style="0" '
            'customWidth="true" '
            'width="$width" />\n';
        i++;
      }
    }

    xml += '<col '
        'collapsed="false" '
        'hidden="false" '
        'max="1024" '
        'min="${i + 1}" '
        'style="0" '
        'customWidth="false" '
        'width="11.5" />\n';
    xml += '</cols>\n';

    xml += '<sheetData>\n';

    xml += rowsToXml(
      styles,
    );

    xml += '</sheetData>\n';

    if (sheetStyle.autoFilterRow > -1) {
      xml +=
          '<autoFilter ref="A${sheetStyle.autoFilterRow + 1}:$maxCellName"/>';
    }

    // print(xml);

    // ---------------

    xml += sheetStyle.mergeCellsXml();

    // ---------------

    xml +=
        '<printOptions headings="false" gridLines="false" gridLinesSet="true" horizontalCentered="false" verticalCentered="false"/>\n';
    xml +=
        '<pageMargins left="0.5" right="0.5" top="1.0" bottom="1.0" header="0.5" footer="0.5"/>';
    xml +=
        '<pageSetup blackAndWhite="false" cellComments="none" copies="1" draft="false" firstPageNumber="1" fitToHeight="1" fitToWidth="1" horizontalDpi="300" orientation="portrait" pageOrder="downThenOver" paperSize="1" scale="100" useFirstPageNumber="true" usePrinterDefaults="false" verticalDpi="300"/>';
    xml += '<headerFooter differentFirst="false" differentOddEven="false">\n';
    xml +=
        '<oddHeader>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12&amp;A</oddHeader>\n';
    xml +=
        '<oddFooter>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12Page &amp;P</oddFooter>\n';

    xml += '</headerFooter>\n';
    xml += '</worksheet>\n';

    return xml;
  }

  CellIndex maxCell() {
    int row = rows.length;
    int cell = rows
        .reduce((Row m, Row row) => row.cells.length > m.cells.length ? row : m)
        .cells
        .length;
    return CellIndex.fromColAndRow(
      ColIndex.fromValue(cell - 1),
      row,
    );
  }

  static Sheet fromJson(
    Dict json, {
    required State state,
  }) {
    List<Row> rows = (json['headers'] as List<dynamic>? ?? [])
        .map((dynamic e) => Row.fromJson(
              e as Dict? ?? {},
              state: state,
            ))
        .toList();
    rows.addAll(
      (json['rows'] as List<dynamic>? ?? [])
          .map((dynamic e) => Row.fromJson(
                e as Dict? ?? {},
                state: state,
              ))
          .toList(),
    );

    return Sheet(
      name: json['name'] as String? ?? 'Sheet1',
      sheetStyle: SheetStyle.fromJson(
        json['style'] as Dict? ?? {},
        state: state,
      ),
      rows: rows,
    );
  }

  ArchiveFile file(
    int amountSheets,
    Styles styles,
    int nr,
  ) {
    String xml = toXml(
      amountSheets,
      styles,
    );
    return ArchiveFile(
      filename.replaceAll('{nr}', nr.toString()),
      xml.length,
      xml,
    );
  }
}
