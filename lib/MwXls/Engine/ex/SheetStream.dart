import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/Model/State.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/CellIndex.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/ColIndex.dart';
import 'package:mwcdn/MwXls/Engine/ex/Sheet.dart';
import 'package:mwcdn/MwXls/Engine/ex/Styles.dart';

import 'Model/SheetStyle.dart';
import 'Row.dart';

class SheetStream extends Sheet {
  CellIndex? _maxCell;

  final File sourceFile;
  final State state;

  SheetStream({
    String name = 'Sheet1',
    SheetStyle sheetStyle = const SheetStyle(),
    required this.sourceFile,
    required this.state,
  }) : super(
          name: name,
          sheetStyle: sheetStyle,
        );

  @override
  CellIndex maxCell() {
    if (_maxCell == null) {
      throw Exception('Max cell not yet determined!');
    }
    return _maxCell!;
  }

  @override
  Future<String> rowsToXml(
    Styles styles,
  ) async {
    String xml = '';

    InputStream stream = InputStream(
      await sourceFile.readAsBytes(),
    );
    OutputStream output = OutputStream();
    GZipDecoder().decodeStream(stream, output);

    String d = String.fromCharCodes(output.getBytes());
    List<String> lines = d.split('\n');
    int rowIndex = 0;
    int colIndex = 0;
    for (String c in lines) {
      if (c.isNotEmpty) {
        Row row = Row.fromValues(
          json.decode(c.toString()) as List<dynamic>,
          state,
        );
        colIndex = max(row.cells.length, colIndex);
        rowIndex++;

        xml += row.toXml(
          rowIndex,
          sheetCellStyles: sheetStyle.cellStyles,
          sheetRowStyle: sheetStyle.defaultRowStyle,
          sheetCellStyle: sheetStyle.defaultCellStyle,
          styles: styles,
        );
      }
    }

    _maxCell = CellIndex.fromColAndRow(
      ColIndex.fromValue(colIndex),
      rowIndex,
    );

    return Future.value(xml);
  }
}
