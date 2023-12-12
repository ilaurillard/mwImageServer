import 'package:archive/archive.dart';

import 'Meta.dart';
import 'Model/ColIndex.dart';
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

    // ------------------

    String app = _appXML();
    archive.addFile(ArchiveFile(
      'docProps/app.xml',
      app.length,
      app,
    ));

    // ------------------

    String core = _coreXML();
    archive.addFile(ArchiveFile(
      'docProps/core.xml',
      core.length,
      core,
    ));

    // ------------------

    String rels = _relsXML();
    archive.addFile(ArchiveFile(
      '_rels/.rels',
      rels.length,
      rels,
    ));

    // ------------------

    int nr = 1;
    for (Sheet sheet in sheets) {
      String sheetXml = sheet.toXml(
        sheets.length,
        styles,
      );
      archive.addFile(ArchiveFile(
        'xl/worksheets/sheet$nr.xml',
        sheetXml.length,
        sheetXml,
      ));
      nr++;
    }

    // ------------------

    String workbook = _workbookXML();
    archive.addFile(ArchiveFile(
      'xl/workbook.xml',
      workbook.length,
      workbook,
    ));

    // ------------------

    String stylesXml = styles.toXml();
    archive.addFile(ArchiveFile(
      'xl/styles.xml',
      stylesXml.length,
      stylesXml,
    ));

    // ------------------

    String contentTypes = _contentTypesXML();
    archive.addFile(ArchiveFile(
      '[Content_Types].xml',
      contentTypes.length,
      contentTypes,
    ));

    // ------------------

    String workbookRels = _workbookRelsXML();
    archive.addFile(ArchiveFile(
      'xl/_rels/workbook.xml.rels',
      workbookRels.length,
      workbookRels,
    ));

    // ------------------

    return Future.value(
      ZipEncoder().encode(archive),
    );
  }

  String _workbookRelsXML() {
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

  String _contentTypesXML() {
    String xml = '<?xml version="1.0" encoding="UTF-8"?>\n';
    xml +=
        '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">\n';
    xml +=
        '<Override PartName="/_rels/.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\n';
    xml +=
        '<Override PartName="/xl/_rels/workbook.xml.rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>\n';
    int nr = 1;
    for (int i = 0; i < sheets.length; i++) {
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

  String _appXML() {
    String xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<Properties xmlns="http://schemas.openxmlformats.org/officeDocument/2006/extended-properties" xmlns:vt="http://schemas.openxmlformats.org/officeDocument/2006/docPropsVTypes">\n';
    xml += '<TotalTime>0</TotalTime>\n';
    xml += '<Company>${escapeXml(meta.company)}</Company>\n';
    xml += '</Properties>\n';
    return xml;
  }

  String _relsXML() {
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

  String _workbookXML() {
    String xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">\n';
    xml +=
        '<fileVersion appName="Calc"/><workbookPr backupFile="false" showObjects="all" date1904="false"/><workbookProtection/>\n';
    xml +=
        '<bookViews><workbookView activeTab="0" firstSheet="0" showHorizontalScroll="true" showSheetTabs="true" showVerticalScroll="true" tabRatio="212" windowHeight="8192" windowWidth="16384" xWindow="0" yWindow="0"/></bookViews>\n';
    xml += '<sheets>\n';

    int i = 0;
    for (Sheet sheet in sheets) {
      String sheetName = sheet.nameSanitized();
      xml +=
          '<sheet name="${escapeXml(sheetName)}" sheetId="${i + 1}" state="visible" r:id="rId${i + 2}"/>';
      i++;
    }

    xml += '</sheets>\n';
    xml += '<definedNames>\n';

    i = 0;
    for (Sheet sheet in sheets) {
      if (sheet.sheetStyles.autoFilterRow > -1) {
        ColIndex maxCellCol = sheet.maxCell().colIndex;
        int maxCellRow = sheet.maxCell().rowIndex;
        String sheetname = sheet.nameSanitized();
        xml +=
            '<definedName name="_xlnm._FilterDatabase" localSheetId="$i" hidden="1">\n';
        xml +=
            '\'${escapeXml(sheetname)}\'!\$A\$${sheet.sheetStyles.autoFilterRow}:\$${maxCellCol.name}\$${maxCellRow + 1}';
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

  String _coreXML() {
    String xml = '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>\n';
    xml +=
        '<cp:coreProperties xmlns:cp="http://schemas.openxmlformats.org/package/2006/metadata/core-properties" xmlns:dc="http://purl.org/dc/elements/1.1/" xmlns:dcmitype="http://purl.org/dc/dcmitype/" xmlns:dcterms="http://purl.org/dc/terms/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance">\n';
    xml +=
        '<dcterms:created xsi:type="dcterms:W3CDTF">\n${_date(null)}</dcterms:created>\n';
    xml += '<dc:title>${escapeXml(meta.title)}</dc:title>\n';
    xml += '<dc:subject>${escapeXml(meta.subject)}</dc:subject>\n';
    xml += '<dc:creator>${escapeXml(meta.author)}</dc:creator>\n';
    if (meta.keywords.isNotEmpty) {
      xml +=
          '<cp:keywords>${escapeXml(meta.keywords.join(', '))}</cp:keywords>';
    }
    xml += '<dc:description>${escapeXml(meta.description)}</dc:description>\n';
    xml += '<cp:revision>${escapeXml(meta.revision)}</cp:revision>\n';
    xml += '</cp:coreProperties>\n';
    return xml;
  }

  String _date(
    DateTime? dt,
  ) {
    dt ??= DateTime.now();
    return dt.toUtc().toIso8601String();
  }

  static String escapeXml(
    String input,
  ) {
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < input.length; i++) {
      final char = input[i];
      switch (char) {
        case '&':
          buffer.write('&amp;');
          break;
        case '<':
          buffer.write('&lt;');
          break;
        case '>':
          buffer.write('&gt;');
          break;
        case '"':
          buffer.write('&quot;');
          break;
        case "'":
          buffer.write('&apos;');
          break;
        default:
          buffer.write(char);
          break;
      }
    }

    return buffer.toString();
  }
}
