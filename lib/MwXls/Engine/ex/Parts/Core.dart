import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/ex/Excel.dart';
import 'package:mwcdn/MwXls/Engine/ex/Meta.dart';
import 'package:mwcdn/MwXls/Engine/ex/Model/ColIndex.dart';

import '../Sheet.dart';
import '../Util.dart';

class Core {
  final Meta meta;

  final String _filename = 'docProps/core.xml';

  Core(this.meta);

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
    '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">\n';
    xml +=
    '<dcterms:created xsi:type="dcterms:W3CDTF">\n${_currentDate(null)}</dcterms:created>\n';
    xml += '<dc:title>${Util.escapeXml(meta.title)}</dc:title>\n';
    xml += '<dc:subject>${Util.escapeXml(meta.subject)}</dc:subject>\n';
    xml += '<dc:creator>${Util.escapeXml(meta.author)}</dc:creator>\n';
    if (meta.keywords.isNotEmpty) {
      xml +=
      '<cp:keywords>${Util.escapeXml(meta.keywords.join(', '))}</cp:keywords>';
    }
    xml += '<dc:description>${Util.escapeXml(meta.description)}</dc:description>\n';
    xml += '<cp:revision>${Util.escapeXml(meta.revision)}</cp:revision>\n';
    xml += '</cp:coreProperties>\n';
    return xml;
  }

  String _currentDate(
      DateTime? dt,
      ) {
    dt ??= DateTime.now();
    return dt.toUtc().toIso8601String();
  }
}
