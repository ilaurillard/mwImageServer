import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Datasource.dart';
import 'Util.dart';
import 'Widget.dart';

class Table {
  static pw.Table tableAuto(
    Dict json,
    State state,
  ) {
    double? cellHeight = double.tryParse(json['cellHeight'].toString());
    double? headerHeight = double.tryParse(json['headerHeight'].toString());

    Datasource source = state.source(
      json['source'] as String?,
    );

    List<List<dynamic>> data = source.values;

    Map<int, Dict> cells = _cells(json['cells'] as Dict? ?? {});

    if (cells.isNotEmpty) {
      for (List<dynamic> row in data) {
        for (int nr in cells.keys) {
          if (row.length > nr) {
            state.cellValue = row[nr]!.toString();
            row[nr] = Widget.parse(
              cells[nr]!,
              state,
            );
          }
        }
      }
    }

    List<dynamic>? headers = json['headers'] as List<dynamic>?;
    if (headers != null) {
      for (int index = 0; index < headers.length; index++) {
        dynamic h = headers[index];
        if (h is! String) {
          headers[index] = Widget.parse(
            h as Dict? ?? {},
            state,
          );
        }
      }
    }

    return pw.TableHelper.fromTextArray(
      data: data,
      cellPadding: Util.edgeInsets(
            json['cellPadding'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.all(5),
      cellHeight: cellHeight != null ? cellHeight * PdfPageFormat.mm : 0,
      cellAlignment: Util.alignment(json['cellAlignment'] as String?) ??
          pw.Alignment.topLeft,
      cellAlignments: _cellAlignments('cellAlignments', json),
      cellStyle: Util.textStyle(
        json['cellStyle'] as Dict? ?? {},
        state,
      ),
      oddCellStyle: Util.textStyle(
        json['oddCellStyle'] as Dict? ?? {},
        state,
      ),
      // cellFormat: TODO support callbacks??
      // cellDecoration: TODO support callbacks somehow??
      // headerFormat: (int index, dynamic data) {
      //   return 'xxx';
      // },
      headerCount: int.tryParse(json['headerCount'].toString()) ?? 1,
      headers: headers,
      headerPadding: Util.edgeInsets(
        json['headerPadding'] as List<dynamic>?,
      ),
      headerHeight:
          headerHeight != null ? headerHeight * PdfPageFormat.mm : null,
      headerAlignment: Util.alignment(json['headerAlignment'] as String?) ??
          pw.Alignment.center,
      headerAlignments: _cellAlignments('headerAlignments', json),
      headerStyle: Util.textStyle(
        json['headerStyle'] as Dict? ?? {},
        state,
      ),

      border: tableBorder(
        json['border'] as Dict?,
      ),
      columnWidths: _columnWidths(json),
      defaultColumnWidth: columnWidth(
        json['defaultColumnWidth'] as Dict?,
      ),
      tableWidth: tableWidth(
        json['tableWidth'] as String?,
      ),
      headerDecoration: Util.boxDecoration(
        (json['headerDecoration'] as Dict?) ?? {},
        state,
      ),
      headerCellDecoration: Util.boxDecoration(
        (json['headerCellDecoration'] as Dict?) ?? {},
        state,
      ),
      rowDecoration: Util.boxDecoration(
        (json['rowDecoration'] as Dict?) ?? {},
        state,
      ),
      oddRowDecoration: Util.boxDecoration(
        (json['oddRowDecoration'] as Dict?) ?? {},
        state,
      ),
      headerDirection: Util.textDirection(
        json['headerDirection'] as String?,
      ),
      tableDirection: Util.textDirection(
        json['tableDirection'] as String?,
      ),
    );
  }

  static pw.Table table(
    Dict json,
    State state,
  ) {
    List<pw.TableRow> rows = [];

    for (dynamic childData in json['children'] as List<dynamic>? ?? []) {
      rows.addAll(
        tableRows(
          childData as Dict,
          state,
        ),
      );
    }

    return pw.Table(
      columnWidths: _columnWidths(json),
      defaultVerticalAlignment: tableCellVerticalAlignment(
            json['defaultVerticalAlignment'] as String?,
          ) ??
          pw.TableCellVerticalAlignment.top,
      defaultColumnWidth: columnWidth(
        json['defaultColumnWidth'] as Dict?,
      ),
      border: tableBorder(
        json['border'] as Dict?,
      ),
      tableWidth: tableWidth(
        json['tableWidth'] as String?,
      ),
      children: rows,
    );
  }

  static List<pw.TableRow> tableRows(
    Dict json,
    State state,
  ) {
    Dict showIf = json['ShowIfValue'] as Dict? ?? {};
    if (showIf.isNotEmpty) {
      String condition = state.replaceParameters(
        showIf['condition'] as String? ?? '',
      );
      if (condition.isEmpty) {
        return [];
      }
      json = showIf['child'] as Dict? ?? {};
    }
    Dict data = json['TableRow'] as Dict? ?? {};

    // print('W: TableRow');

    Datasource source = state.source(
      data['source'] as String?,
    );

    pw.BoxDecoration? decoration = Util.boxDecoration(
      data['decoration'] as Dict? ?? {},
      state,
    );
    bool? repeat = data['repeat'] as bool? ?? false;
    pw.TableCellVerticalAlignment? verticalAlignment =
        tableCellVerticalAlignment(
      data['verticalAlignment'] as String?,
    );

    List<pw.TableRow> rows = [];

    List<List<dynamic>> values = source.values;
    if (values.isEmpty) {
      values = [[]];
    }

    for (List<dynamic> v in values) {
      List<pw.Widget> children = [];
      int nr = 0;
      for (dynamic d in data['children'] as List<dynamic>? ?? []) {
        state.cellValue = v.length > nr ? v[nr].toString() : '?';
        children.add(Widget.parse(
          d as Dict,
          state,
        ));
        nr++;
      }
      rows.add(pw.TableRow(
        decoration: decoration,
        repeat: repeat,
        verticalAlignment: verticalAlignment,
        children: children,
      ));
    }

    return rows;
  }

  static pw.TableBorder? tableBorder(
    Dict? json,
  ) {
    if (json != null) {
      pw.BorderSide fb =
          Util.borderSide(json['all'] as Dict?) ?? pw.BorderSide.none;
      return pw.TableBorder(
        top: Util.borderSide(json['top'] as Dict?) ?? fb,
        right: Util.borderSide(json['right'] as Dict?) ?? fb,
        bottom: Util.borderSide(json['bottom'] as Dict?) ?? fb,
        left: Util.borderSide(json['left'] as Dict?) ?? fb,
        horizontalInside:
            Util.borderSide(json['horizontalInside'] as Dict?) ?? fb,
        verticalInside: Util.borderSide(json['verticalInside'] as Dict?) ?? fb,
      );
    }
    return null;
  }

  static pw.TableWidth tableWidth(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'min':
          return pw.TableWidth.min;
      }
    }
    return pw.TableWidth.max;
  }

  static pw.TableCellVerticalAlignment? tableCellVerticalAlignment(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'bottom':
          return pw.TableCellVerticalAlignment.bottom;
        case 'middle':
          return pw.TableCellVerticalAlignment.middle;
        case 'full':
          return pw.TableCellVerticalAlignment.full;
        case 'top':
          return pw.TableCellVerticalAlignment.top;
      }
    }
    return null;
  }

  static pw.TableColumnWidth columnWidth(
    Dict? json,
  ) {
    if (json != null && json.isNotEmpty) {
      MapEntry<String, dynamic> widget = json.entries.first;

      String key = widget.key;
      Dict data = widget.value as Dict;

      switch (key) {
        case 'IntrinsicColumnWidth':
          return pw.IntrinsicColumnWidth(
              flex: double.tryParse(data['flex'].toString()));
        case 'FlexColumnWidth':
          return pw.FlexColumnWidth(
              double.tryParse(data['flex'].toString()) ?? 1.0);
        case 'FractionColumnWidth':
          return pw.FractionColumnWidth(
              double.tryParse(data['value'].toString()) ?? 0.0);
        case 'FixedColumnWidth':
          double width = double.tryParse(data['width'].toString()) ?? 0.0;
          return pw.FixedColumnWidth(width * PdfPageFormat.mm);
      }
    }
    return pw.IntrinsicColumnWidth();
  }

  static Map<int, pw.Alignment>? _cellAlignments(
    String key,
    Dict json,
  ) {
    Map<int, pw.Alignment>? cellAlignments;
    Dict temp = json[key] as Dict? ?? {};
    if (json[key] != null) {
      cellAlignments = Map.fromEntries(
        temp.entries.map(
          (
            MapEntry<String, dynamic> entry,
          ) {
            return MapEntry(
              int.tryParse(entry.key) ?? 0,
              Util.alignment(
                    entry.value as String?,
                  ) ??
                  pw.Alignment.topLeft,
            );
          },
        ),
      );
    }
    return cellAlignments;
  }

  static Map<int, pw.TableColumnWidth>? _columnWidths(
    Dict json,
  ) {
    Map<int, pw.TableColumnWidth>? columnWidths;
    Dict temp = json['columnWidths'] as Dict? ?? {};
    if (json['columnWidths'] != null) {
      columnWidths = Map.fromEntries(
        temp.entries.map(
          (
            MapEntry<String, dynamic> entry,
          ) {
            return MapEntry(
              int.tryParse(entry.key) ?? 0,
              columnWidth(
                entry.value as Dict?,
              ),
            );
          },
        ),
      );
    }
    return columnWidths;
  }

  static Map<int, Dict> _cells(
    Dict json,
  ) {
    Map<int, Dict> cells = Map.fromEntries(
      json.entries.map(
        (
          MapEntry<String, dynamic> entry,
        ) {
          return MapEntry(
            int.tryParse(entry.key) ?? 0,
            entry.value as Dict? ?? {},
          );
        },
      ),
    );
    return cells;
  }
}
