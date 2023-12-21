import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Util.dart';
import 'package:pdf/pdf.dart';

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
  });

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
    );
  }
}
