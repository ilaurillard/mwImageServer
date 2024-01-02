import 'dart:io';
import 'dart:math';

import 'package:archive/src/archive_file.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwXls/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';
import 'package:mwcdn/MwXls/Engine/ex/SheetStream.dart';

import 'Model/CellIndex.dart';
import 'Model/ColIndex.dart';
import 'Model/SheetStyle.dart';
import 'Row.dart';
import 'Styles.dart';

class Sheet {
  final String name;
  final SheetStyle sheetStyle;

  late List<Row> _rows;
  final String _filename = 'xl/worksheets/sheet{nr}.xml';

  CellIndex? _maxCell;

  Sheet({
    this.name = 'Sheet1',
    this.sheetStyle = const SheetStyle(),
    List<Row> rows = const [],
  }) {
    _rows = rows.isEmpty ? [] : rows;
  }

  String nameSanitized() {
    String s = name
        .replaceAll(
          RegExp(r'[\/\?\*\:\[\]]'),
          '',
        )
        .trim()
        .substring(0, min(31, name.length));
    return s.isNotEmpty ? s : 'Sheet${Random().nextInt(1000)}';
  }

  CellIndex maxCell() {
    if (_maxCell == null) {
      int row = _rows.length;
      int cell = row == 0
          ? 0
          : _rows
              .reduce((Row row1, Row row2) =>
                  row2.cells.length > row1.cells.length ? row2 : row1)
              .cells
              .length;
      if (row > 0 && cell > 0) {
        _maxCell = CellIndex.fromColAndRow(
          ColIndex.fromValue(cell - 1),
          row,
        );
      }
      else {
        _maxCell = CellIndex('A1');
      }
    }
    return _maxCell!;
  }

  Future<String> rowsToXml(
    Styles styles,
  ) async {
    String xml = '';
    int i = 0;
    for (Row row in _rows) {
      xml += row.toXml(
        i + 1,
        sheetCellStyles: sheetStyle.cellStyles,
        sheetRowStyle: sheetStyle.defaultRowStyle,
        sheetCellStyle: sheetStyle.defaultCellStyle,
        styles: styles,
      );
      i++;
    }
    return Future.value(xml);
  }

  Future<String> _toXml(
    int amountSheets,
    Styles styles,
  ) async {

    String rightToLeftValue = 'false'; // NTH?
    String tabselected = amountSheets == 1 ? 'true' : 'false';

    String xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">\n';

    // ---------------

    xml += '<sheetData>\n';

    xml += await rowsToXml(
      styles,
    );

    xml += '</sheetData>\n';

    // ---------------

    String maxCellName = maxCell().name;

    xml += '<sheetPr filterMode="false">\n';
    xml += '  <pageSetUpPr fitToPage="false"/>\n';
    xml += '</sheetPr>\n';

    xml += '<dimension ref="A1:$maxCellName"/>';

    // print(xml);

    xml += '<sheetViews>';
    xml +=
    '  <sheetView colorId="64" defaultGridColor="true" rightToLeft="$rightToLeftValue" showFormulas="false" showGridLines="true" showOutlineSymbols="true" showRowColHeaders="true" showZeros="true" tabSelected="$tabselected" topLeftCell="A1" view="normal" windowProtection="false" workbookViewId="0" zoomScale="100" zoomScaleNormal="100" zoomScalePageLayoutView="100">';
    xml += sheetStyle.freezeXml();
    xml += '  </sheetView>\n';
    xml += '</sheetViews>\n';

    xml += _colsXml();

    if (sheetStyle.autoFilterRow > -1) {
      xml +=
          '<autoFilter ref="A${sheetStyle.autoFilterRow + 1}:$maxCellName"/>';
    }

    xml += sheetStyle.mergeCellsXml();

    xml +=
        '  <printOptions headings="false" gridLines="false" gridLinesSet="true" horizontalCentered="false" verticalCentered="false"/>\n';
    xml +=
        '  <pageMargins left="0.5" right="0.5" top="1.0" bottom="1.0" header="0.5" footer="0.5"/>';
    xml +=
        '  <pageSetup blackAndWhite="false" cellComments="none" copies="1" draft="false" firstPageNumber="1" fitToHeight="1" fitToWidth="1" horizontalDpi="300" orientation="portrait" pageOrder="downThenOver" paperSize="1" scale="100" useFirstPageNumber="true" usePrinterDefaults="false" verticalDpi="300"/>';

    xml += _headerFooterXml();

    xml += '</worksheet>\n';

    return xml;
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

    String sourceName = json['source'] as String? ?? '';
    Datasource source = state.source(sourceName);
    for (List<dynamic> data in source.values) {
      rows.add(
        Row.fromValues(
          data,
          state,
        ),
      );
    }

    String name = json['name'] as String? ?? 'Sheet1';
    SheetStyle style = SheetStyle.fromJson(
      json['style'] as Dict? ?? {},
      state: state,
    );

    // String fileName = '${state.baseDir}/../../tests/MwXls/examples/ALLE.ndjson.gz';
    // File sourceFile = File(fileName);
    // return SheetStream(
    //   name: name,
    //   sheetStyle: style,
    //   sourceFile: sourceFile,
    //   state: state,
    // );

    return Sheet(
      name: name,
      sheetStyle: style,
      rows: rows,
    );
  }

  Future<ArchiveFile> file(
    int amountSheets,
    Styles styles,
    int nr,
  ) async {
    String xml = await _toXml(
      amountSheets,
      styles,
    );
    return ArchiveFile(
      _filename.replaceAll('{nr}', nr.toString()),
      xml.length,
      xml,
    );
  }

  String _colsXml() {
    String xml = '<cols>\n';

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

    return xml;
  }

  String _headerFooterXml() {
    String xml =
        '  <headerFooter differentFirst="false" differentOddEven="false">\n';
    xml +=
        '    <oddHeader>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12&amp;A</oddHeader>\n';
    xml +=
        '    <oddFooter>&amp;C&amp;&quot;Times New Roman,Regular&quot;&amp;12Page &amp;P</oddFooter>\n';

    xml += '  </headerFooter>\n';
    return xml;
  }
}
