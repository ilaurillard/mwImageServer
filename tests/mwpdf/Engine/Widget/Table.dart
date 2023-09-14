import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Engine.dart';
import '../Model/Resource.dart';
import 'Etc.dart';
import 'Widget.dart';

class Table {
  static pw.Table table(
    Dict json,
  ) {
    Map<int, pw.TableColumnWidth>? columnWidths = {};
    Map<String, dynamic> temp =
        json['columnWidths'] as Map<String, dynamic>? ?? {};
    if (temp.isNotEmpty) {
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

    List<pw.TableRow> rows = [];

    for (dynamic e in json['children'] as List<dynamic>? ?? []) {
      Dict d = e as Dict;
      rows.addAll(tableRows(d));
    }

    return pw.Table(
      columnWidths: columnWidths,
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

    List<Map<String, String>> values = resource.values;
    if (values.isEmpty) {
      values = [{}];
    }
    for (Map<String, String> v in values) {
      Widget.parameters = v;
      List<pw.Widget> children = [];
      for (dynamic d in data['children'] as List<dynamic>? ?? []) {
        children.add(Widget.parse(d as Dict));
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
}
