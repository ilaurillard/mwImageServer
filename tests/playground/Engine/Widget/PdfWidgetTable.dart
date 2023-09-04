import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetUtil.dart';

class PdfWidgetTable {
  static pw.Table table(
    Dict json,
  ) {
    // TODO
    return pw.Table(
      tableWidth: PdfWidgetUtil.tableWidth(
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
    print('W: TableRow');

    // TODO
    return pw.TableRow(
      children: (json['TableRow']['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parse(e as Dict))
          .toList(),
    );
  }
}
