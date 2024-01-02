import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/ex/Sheet.dart';

class ContentTypes {
  final List<Sheet> _sheets;

  final String _filename = '[Content_Types].xml';

  ContentTypes(this._sheets);

  ArchiveFile file() {
    String xml = _toXml();
    return ArchiveFile(
      _filename,
      xml.length,
      xml,
    );
  }

  String _toXml() {
    String xml = '<?xml version="1.0" encoding="UTF-8"?>\n';
    xml +=
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">\n';
    xml +=
        '<Override PartName="/_rels/.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\n';
    xml +=
        '<Override PartName="/xl/_rels/workbook.xml.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\n';
    int nr = 1;
    for (int i = 0; i < _sheets.length; i++) {
      xml +=
          '<Override PartName="/xl/worksheets/sheet$nr.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>\n';
      nr++;
    }
    xml +=
        '<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>\n';
    xml +=
        '<Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>\n';
    xml +=
        '<Override PartName="/docProps/app.xml" ContentType="application/vnd.openxmlformats-officedocument.extended-properties+xml"/>\n';
    xml +=
        '<Override PartName="/docProps/core.xml" ContentType="application/vnd.openxmlformats-package.core-properties+xml"/>\n';
    xml += '</Types>\n';
    return xml;
  }
}
