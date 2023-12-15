import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/ex/Sheet.dart';

class WorkbookRelationShips {
  final List<Sheet> sheets;

  final String filename = 'xl/_rels/workbook.xml.rels';

  WorkbookRelationShips(this.sheets);

  ArchiveFile file() {
    String xml = toXml();
    return ArchiveFile(
      filename,
      xml.length,
      xml,
    );
  }

  String toXml() {
    int nr = 1;
    String xml = '<?xml version="1.0" encoding="UTF-8"?>\n';
    xml +=
    '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\n';
    xml +=
    '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>\n';

    for (int i = 0; i < sheets.length; i++) {
      xml +=
      '<Relationship Id="rId${nr + 1}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet$nr.xml"/>\n';
      nr++;
    }
    xml += '</Relationships>\n';
    return xml;
  }
}
