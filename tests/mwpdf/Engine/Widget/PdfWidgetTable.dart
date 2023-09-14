import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Model/Resource.dart';
import '../PdfEngine.dart';
import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetTable {
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


    return pw.Table(
      columnWidths: columnWidths,
      defaultVerticalAlignment: tableCellVerticalAlignment(
        json['defaultVerticalAlignment'] as String?,
      ) ?? pw.TableCellVerticalAlignment.top,
      defaultColumnWidth: columnWidth(
        json['defaultColumnWidth'] as Dict?,
      ),
      border: tableBorder(
        json['border'] as Dict?,
      ),
      tableWidth: tableWidth(
        json['tableWidth'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => tableRow(e as Dict))
          .toList(),
    );
  }

  static pw.TableRow tableRow(
    Dict json,
  ) {
    Resource resource = PdfEngine.res.get(json['resource'] as String?);
    // print(resource);


    // print('W: TableRow');
    Dict data = json['TableRow'] as Dict? ?? {};

    return pw.TableRow(
      decoration: PdfWidgetUtil.boxDecoration(
        data['decoration'] as Dict? ?? {},
      ),
      repeat: data['repeat'] as bool? ?? false,
      verticalAlignment: tableCellVerticalAlignment(
        data['verticalAlignment'] as String?,
      ),
      children: (data['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parse(e as Dict))
          .toList(),
    );
  }

  static pw.TableBorder? tableBorder(
    Dict? json,
  ) {
    if (json != null) {
      pw.BorderSide fb =
          PdfWidgetUtil.borderSide(json['all'] as Dict?) ?? pw.BorderSide.none;
      return pw.TableBorder(
        top: PdfWidgetUtil.borderSide(json['top'] as Dict?) ?? fb,
        right: PdfWidgetUtil.borderSide(json['right'] as Dict?) ?? fb,
        bottom: PdfWidgetUtil.borderSide(json['bottom'] as Dict?) ?? fb,
        left: PdfWidgetUtil.borderSide(json['left'] as Dict?) ?? fb,
        horizontalInside:
            PdfWidgetUtil.borderSide(json['horizontalInside'] as Dict?) ?? fb,
        verticalInside:
            PdfWidgetUtil.borderSide(json['verticalInside'] as Dict?) ?? fb,
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
