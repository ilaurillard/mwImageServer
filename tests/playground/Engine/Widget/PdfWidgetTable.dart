import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfWidget.dart';
import 'PdfWidgetEnums.dart';

class PdfWidgetTable {
  static pw.Table parseTable(
    Dict json,
  ) {
    // TODO
    return pw.Table(
      tableWidth: PdfWidgetEnums.parseTableWidth(
        json['tableWidth'] as String?,
      ),
      children: (json['children'] as List<dynamic>? ?? [])
          .map((e) => parseTableRow(e as Dict))
          .toList(),
    );
  }

  static pw.TableRow parseTableRow(
    Dict json,
  ) {
    print('W: TableRow');

    // TODO
    return pw.TableRow(
      children: (json['TableRow']['children'] as List<dynamic>? ?? [])
          .map((e) => PdfWidget.parseWidget(e as Dict))
          .toList(),
    );
  }
}
