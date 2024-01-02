import 'package:archive/archive.dart';
import 'package:mwcdn/MwXls/Engine/ex/Meta.dart';

import '../Util.dart';

class App {
  final Meta meta;

  final String _filename = 'docProps/app.xml';

  App(this.meta);

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
        '<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">\n';
    xml += '<TotalTime>0</TotalTime>\n';
    xml += '<Company>${Util.escapeXml(meta.company)}</Company>\n';
    xml += '</Properties>\n';
    return xml;
  }
}
