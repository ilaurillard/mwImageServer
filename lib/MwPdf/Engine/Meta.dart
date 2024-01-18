import 'dart:ffi';

import 'package:intl/intl.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Util.dart';
import 'package:pdf/pdf.dart';
import 'package:xml/xml.dart';

import 'Model/Footer.dart';
import 'Model/Header.dart';
import 'Model/State.dart';
import 'Theme/Theme.dart';

class Meta {
  final String theme;
  final PdfPageMode pageMode;
  final String? title;
  final String? author;
  final String? creator;
  final String? subject;
  final String? keywords;
  final String? producer;
  final Map<String, Theme> themes;
  final Map<String, Header> headers;
  final Map<String, Footer> footers;
  final DateTime creationDate = DateTime.now();
  final bool pdfa3b;

  Meta({
    this.pageMode = PdfPageMode.none,
    this.themes = const {},
    this.headers = const {},
    this.footers = const {},
    this.theme = '',
    this.title,
    this.author,
    this.creator,
    this.subject,
    this.keywords,
    this.producer,
    this.pdfa3b = false,
  });

  XmlDocument? pdfaXml() {

    if (!pdfa3b) {
      return null;
    }

    String createDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss").format(creationDate);
    Duration offset = creationDate.timeZoneOffset;
    int hours =
        offset.inHours > 0 ? offset.inHours : 1; // For fixing divide by 0
    if (!offset.isNegative) {
      createDate =
          "$createDate+${offset.inHours.toString().padLeft(2, '0')}:${(offset.inMinutes % (hours * 60)).toString().padLeft(2, '0')}";
    } else {
      createDate =
          "$createDate-${(-offset.inHours).toString().padLeft(2, '0')}:${(offset.inMinutes % (hours * 60)).toString().padLeft(2, '0')}";
    }

    return XmlDocument.parse('''
<?xpacket begin="" id="W5M0MpCehiHzreSzNTczkc9d"?>
<rdf:RDF xmlns:rdf="http://www.w3.org/1999/02/22-rdf-syntax-ns#">
  <rdf:Description rdf:about="" xmlns:pdf="http://ns.adobe.com/pdf/1.3/">
    <pdf:Producer>$producer</pdf:Producer>
    <pdf:Keywords>$keywords</pdf:Keywords>
  </rdf:Description>
  <rdf:Description rdf:about="" xmlns:xmp="http://ns.adobe.com/xap/1.0/">
    <xmp:CreateDate>$createDate</xmp:CreateDate>
    <xmp:CreatorTool>$creator</xmp:CreatorTool>
  </rdf:Description>
  <rdf:Description rdf:about="" xmlns:dc="http://purl.org/dc/elements/1.1/">
    <dc:creator><rdf:Seq><rdf:li>$author</rdf:li></rdf:Seq></dc:creator>
    <dc:title><rdf:Alt><rdf:li xml:lang="x-default">$title</rdf:li></rdf:Alt></dc:title>
    <dc:description><rdf:Alt><rdf:li xml:lang="x-default">$subject</rdf:li></rdf:Alt></dc:description>
  </rdf:Description>
  <rdf:Description rdf:about="" xmlns:pdfaid="http://www.aiim.org/pdfa/ns/id/">
    <pdfaid:part>3</pdfaid:part>
    <pdfaid:conformance>B</pdfaid:conformance>
  </rdf:Description>
</rdf:RDF>
<?xpacket end="r"?>
''');
  }

  static Meta fromJson(
    Dict json,
    State state,
  ) {
    return Meta(
      theme: json['theme'] as String? ?? '',
      pageMode: Util.pageMode(json['pageMode'] as String?),
      title: json['title'] as String?,
      author: json['author'] as String?,
      creator: json['creator'] as String?,
      subject: json['subject'] as String?,
      keywords: json['keywords'] as String?,
      producer: json['producer'] as String?,
      themes: Theme.fromJsonAll(
        (json['themes'] as Dict?) ?? {},
        state,
      ),
      headers: Header.fromJsonAll(
        (json['headers'] as Dict?) ?? {},
      ),
      footers: Footer.fromJsonAll(
        (json['footers'] as Dict?) ?? {},
      ),
      pdfa3b: json['pdfa3b'] as bool? ?? false,
    );
  }
}
