import 'package:archive/archive.dart';

class RelationShips {
  final String _filename = '_rels/.rels';

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
        '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">\n';
    xml +=
        '<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>\n';
    xml +=
        '<Relationship Id="rId2" Type="http://schemas.openxmlformats.org/package/2006/relationships/metadata/core-properties" Target="docProps/core.xml"/>\n';
    xml +=
        '<Relationship Id="rId3" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/extended-properties" Target="docProps/app.xml"/>\n';
    xml += '</Relationships>\n';
    return xml;
  }
}
