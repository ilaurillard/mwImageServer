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
    // PDF/A 3b compliency (needed for embedded bills)
    this.pdfa3b = false,
  });

  static Meta fromJson(
    Dict json,
    State state,
  ) {
    return Meta(
      theme: json['theme'] as String? ?? '',
      pageMode: Util.pageMode(json['pageMode'] as String?),
      title: replaceParameters(json['title'] as String?, state),
      author: replaceParameters(json['author'] as String?, state),
      creator: replaceParameters(json['creator'] as String?, state),
      subject: replaceParameters(json['subject'] as String?, state),
      keywords: replaceParameters(json['keywords'] as String?, state),
      producer: replaceParameters(json['producer'] as String?, state),
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

  // PDF/A 3b Metadata
  XmlDocument? pdfaRdf({
    bool cii = false,
    bool xrechnung = false,
  }) {
    if (!pdfa3b) {
      return null;
    }

    String invoiceRdf = '';
    if (cii) {
      invoiceRdf = PdfaFacturxRdf().create();
    }
    else if (xrechnung) {
      // TODO xxx?
      invoiceRdf = PdfaFacturxRdf().create();
    }

    return PdfaRdf(
      title: title,
      author: author,
      creator: creator,
      subject: subject,
      keywords: keywords,
      producer: producer,
      creationDate: creationDate,
      invoiceRdf: invoiceRdf,
    ).create();
  }

  static String? replaceParameters(
    String? string,
    State state,
  ) {
    if (string != null) {
      string = state.replaceParameters(string);
    }
    return string;
  }
}
