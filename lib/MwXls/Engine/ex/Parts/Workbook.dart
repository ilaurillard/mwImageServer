import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/CellIndex.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/ColIndex.dart';

import '../Sheet.dart';
import '../Util.dart';

class Workbook {
  final List<Sheet> _sheets;

  final String _filename = 'xl/workbook.xml';

  Workbook(this._sheets);

  ArchiveFile file() {
    String xml = _toXml();
    return ArchiveFile(
      _filename,
      xml.length,
      xml,
    );
  }

  String _toXml() {
    String xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">\n';
    xml +=
        '<fileVersion appName="Calc"/><workbookPr backupFile="false" showObjects="all" date1904="false"/><workbookProtection/>\n';
    xml +=
        '<bookViews><workbookView activeTab="0" firstSheet="0" showHorizontalScroll="true" showSheetTabs="true" showVerticalScroll="true" tabRatio="212" windowHeight="8192" windowWidth="16384" xWindow="0" yWindow="0"/></bookViews>\n';
    xml += '<sheets>\n';

    int i = 0;
    for (Sheet sheet in _sheets) {
      String sheetName = sheet.nameSanitized();
      xml +=
          '<sheet name="${Util.escapeXml(sheetName)}" sheetId="${i + 1}" state="visible" r:id="rId${i + 2}"/>';
      i++;
    }

    xml += '</sheets>\n';

    xml += '<definedNames>\n';

    i = 0;
    for (Sheet sheet in _sheets) {
      if (sheet.sheetStyle.autoFilterRow > -1) {
        CellIndex maxCell = sheet.maxCell();
        xml +=
            '<definedName name="_xlnm._FilterDatabase" localSheetId="$i" hidden="1">\n';
        xml +=
            '\'${Util.escapeXml(sheet.nameSanitized())}\'!\$A\$${sheet.sheetStyle.autoFilterRow}:\$${maxCell.colIndex.name}\$${maxCell.rowIndex + 1}';
        xml += '</definedName>\n';
        i++;
      }
    }

    xml += '</definedNames>\n';

    // print(xml);

    xml +=
        '<calcPr iterateCount="100" refMode="A1" iterate="false" iterateDelta="0.001"/></workbook>\n';
    return xml;
  }
}
