import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/ex/Parts/App.dart';
import 'package:mwcdn/MwXls/Engine/ex/Parts/ContentTypes.dart';
import 'package:mwcdn/MwXls/Engine/ex/Parts/Core.dart';
import 'package:mwcdn/MwXls/Engine/ex/Parts/RelationShips.dart';
import 'package:mwcdn/MwXls/Engine/ex/Parts/Workbook.dart';
import 'package:mwcdn/MwXls/Engine/ex/Parts/WorkbookRelationShips.dart';

import 'Meta.dart';
import 'Sheet.dart';
import 'Styles.dart';

class Excel {
  List<Sheet> sheets;
  late final Styles styles;
  final Meta meta;

  Excel({
    this.sheets = const [],
    Styles? styles,
    required this.meta,
  }) {
    if (sheets.isEmpty) {
      sheets = [];
    }
    this.styles = styles ?? Styles();
  }

  void addSheet(
    Sheet sheet,
  ) {}

  Future<List<int>> save() {
    Archive archive = Archive();

    archive.addFile(
      App(meta).file(),
    );

    archive.addFile(
      Core(meta).file(),
    );

    archive.addFile(
      RelationShips().file(),
    );

    int nr = 1;
    for (Sheet sheet in sheets) {
      archive.addFile(
        sheet.file(
          sheets.length,
          styles,
          nr,
        ),
      );
      nr++;
    }

    archive.addFile(
      Workbook(sheets).file(),
    );

    archive.addFile(
      styles.file(),
    );

    archive.addFile(
      ContentTypes(sheets).file(),
    );

    archive.addFile(
      WorkbookRelationShips(sheets).file(),
    );

    return Future.value(
      ZipEncoder().encode(archive),
    );
  }
}
