import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Engine.dart';
import '../Model/Resource.dart';
import 'Etc.dart';
import 'Widget.dart';

class Table {
  static pw.Table tableAuto(
    Dict json,
  ) {
    double? cellHeight = double.tryParse(json['cellHeight'].toString());
    double? headerHeight = double.tryParse(json['headerHeight'].toString());

    Resource resource = Engine.resources.get(json['resource'] as String?);

    List<List<dynamic>> data = resource.values;

    Map<int, Dict> cells =
        _cells(json['cells'] as Map<String, dynamic>? ?? {});

    if (cells.isNotEmpty) {
      for (List<dynamic> row in data) {
        for (int nr in cells.keys) {
          if (row.length > nr) {
            Widget.value = row[nr]!.toString();
            row[nr] = Widget.parse(cells[nr]!);
          }
        }
      }
    }

    return pw.TableHelper.fromTextArray(
      data: data,
      cellPadding: Etc.edgeInsets(
            json['cellPadding'] as List<dynamic>?,
          ) ??
          const pw.EdgeInsets.all(5),
      cellHeight: cellHeight != null ? cellHeight * PdfPageFormat.mm : 0,
      cellAlignment: Etc.alignment(json['cellAlignment'] as String?) ??
          pw.Alignment.topLeft,
      cellAlignments: _cellAlignments('cellAlignments', json),
      cellStyle: Etc.textStyle(json['cellStyle'] as Dict? ?? {}),
      oddCellStyle: Etc.textStyle(json['oddCellStyle'] as Dict? ?? {}),
      // cellFormat: TODO support callbacks??
      // cellDecoration: TODO support callbacks somehow??
      headerCount: int.tryParse(json['headerCount'].toString()) ?? 1,
      headers: json['headers'] as List<dynamic>?,
      headerPadding: Etc.edgeInsets(
        json['headerPadding'] as List<dynamic>?,
      ),
      headerHeight:
          headerHeight != null ? headerHeight * PdfPageFormat.mm : null,
      headerAlignment: Etc.alignment(json['headerAlignment'] as String?) ??
          pw.Alignment.center,
      headerAlignments: _cellAlignments('headerAlignments', json),
      headerStyle: Etc.textStyle(json['headerStyle'] as Dict? ?? {}),
      // headerFormat: TODO callbacks??
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
      headerDecoration:
          Etc.boxDecoration((json['headerDecoration'] as Dict?) ?? {}),
      headerCellDecoration:
          Etc.boxDecoration((json['headerCellDecoration'] as Dict?) ?? {}),
      rowDecoration: Etc.boxDecoration((json['rowDecoration'] as Dict?) ?? {}),
      oddRowDecoration:
          Etc.boxDecoration((json['oddRowDecoration'] as Dict?) ?? {}),
      headerDirection: Etc.textDirection(
        json['headerDirection'] as String?,
      ),
      tableDirection: Etc.textDirection(
        json['tableDirection'] as String?,
      ),
    );
  }

  static pw.Table table(
    Dict json,
  ) {
    List<pw.TableRow> rows = [];

    for (dynamic e in json['children'] as List<dynamic>? ?? []) {
      Dict d = e as Dict;
      rows.addAll(
        tableRows(d),
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
  ) {
    // print('W: TableRow');
    Dict data = json['TableRow'] as Dict? ?? {};

    Resource resource = Engine.resources.get(data['resource'] as String?);
    // print(resource);

    pw.BoxDecoration? decoration = Etc.boxDecoration(
      data['decoration'] as Dict? ?? {},
    );
    bool? repeat = data['repeat'] as bool? ?? false;
    pw.TableCellVerticalAlignment? verticalAlignment =
        tableCellVerticalAlignment(
      data['verticalAlignment'] as String?,
    );

    List<pw.TableRow> rows = [];

    List<List<dynamic>> values = resource.values;
    if (values.isEmpty) {
      values = [[]];
    }

    for (List<dynamic> v in values) {
      List<pw.Widget> children = [];
      int nr = 0;
      for (dynamic d in data['children'] as List<dynamic>? ?? []) {
        Widget.value = v.length > nr ? v[nr].toString() : '?';
        children.add(Widget.parse(d as Dict));
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
          Etc.borderSide(json['all'] as Dict?) ?? pw.BorderSide.none;
      return pw.TableBorder(
        top: Etc.borderSide(json['top'] as Dict?) ?? fb,
        right: Etc.borderSide(json['right'] as Dict?) ?? fb,
        bottom: Etc.borderSide(json['bottom'] as Dict?) ?? fb,
        left: Etc.borderSide(json['left'] as Dict?) ?? fb,
        horizontalInside:
            Etc.borderSide(json['horizontalInside'] as Dict?) ?? fb,
        verticalInside: Etc.borderSide(json['verticalInside'] as Dict?) ?? fb,
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
    Map<String, dynamic> temp = json[key] as Map<String, dynamic>? ?? {};
    if (json[key] != null) {
      cellAlignments = Map.fromEntries(
        temp.entries.map(
          (
            MapEntry<String, dynamic> entry,
          ) {
            return MapEntry(
              int.tryParse(entry.key) ?? 0,
              Etc.alignment(
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
    Map<String, dynamic> temp =
        json['columnWidths'] as Map<String, dynamic>? ?? {};
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
