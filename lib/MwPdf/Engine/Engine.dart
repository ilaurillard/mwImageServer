import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Util.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc/ColPage.dart';
import 'Model/Footer.dart';
import 'Model/Header.dart';
import 'Model/Page.dart';
import 'Model/State.dart';
import 'Theme/Theme.dart';

class Engine {
  final List<Page> pages;

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

  final String baseDir;

  final State state;

  Engine({
    required this.state,

    required this.baseDir,
    required this.pages,

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

  static Future<Engine> create(Dict json, {
    required String baseDir,
    required Storage storage,
  }) async {
    State state = State.fromJson(
      (json['sources'] as Dict?) ?? {},
      baseDir: baseDir,
      storage: storage,
    );
    await state.init();

    Dict meta = (json['meta'] as Dict?) ?? {};
    return Engine(
      baseDir: baseDir,
      theme: meta['theme'] as String? ?? '',
      pageMode: Util.pageMode(meta['pageMode'] as String?),
      title: meta['title'] as String?,
      author: meta['author'] as String?,
      creator: meta['creator'] as String?,
      subject: meta['subject'] as String?,
      keywords: meta['keywords'] as String?,
      producer: meta['producer'] as String?,
      themes: Theme.fromJsonAll(
        (meta['themes'] as Dict?) ?? {},
        state,
      ),
      headers: Header.fromJsonAll(
        (meta['headers'] as Dict?) ?? {},
      ),
      footers: Footer.fromJsonAll(
        (meta['footers'] as Dict?) ?? {},
      ),
      pages: Page.fromJsonAll(
        (json['pages'] as List?) ?? [],
      ),
      state: state,
    );
  }

  pw.Document pdf() {
    pw.ThemeData? docTheme = Theme.defaultDocumentTheme(state);
    if (theme.isNotEmpty) {
      pw.PageTheme? pt = themes[theme]?.theme;
      if (pt != null) {
        docTheme = pt.theme;
      }
    }

    pw.Document pdf = pw.Document(
      pageMode: pageMode,
      theme: docTheme,
      title: title,
      author: author,
      creator: creator,
      subject: subject,
      keywords: keywords,
      producer: producer,
    );

    pw.Document.debug = false;
    pw.RichText.debug = false;

    for (Page page in pages) {
      // header callback --------------------------
      pw.Widget headerBuilder(pw.Context context,) {
        if (page.header.isNotEmpty) {
          Header? header = headers[page.header];
          if (header != null) {
            return header.build(
              context,
              state,
            );
          }
        }
        return pw.SizedBox();
      }

      // footer callback --------------------------
      pw.Widget footerBuilder(pw.Context context,) {
        if (page.footer.isNotEmpty) {
          Footer? footer = footers[page.footer];
          if (footer != null) {
            return footer.build(
              context,
              state,
            );
          }
        }
        return pw.SizedBox();
      }

      // page builder  --------------------------
      List<pw.Widget> pageBuilder(pw.Context context,) {
        return page.build(
          state,
        );
      }

      // --------------------------
      // --------------------------

      pw.PageTheme? pageTheme = themes[page.theme]?.theme ??
          Theme.defaultPageTheme(
            state,
          );

      if (page.multi) {
        if (page.columns > 1) {
          pdf.addPage(
            ColPage(
              pageTheme: pageTheme,
              header: page.header.isNotEmpty ? headerBuilder : null,
              footer: page.footer.isNotEmpty ? footerBuilder : null,
              build: (pw.Context context) => pageBuilder(context),
              columns: page.columns,
              gapWidth: page.gapWidth,
            ),
          );
        } else {
          pdf.addPage(
            pw.MultiPage(
              pageTheme: pageTheme,
              header: page.header.isNotEmpty ? headerBuilder : null,
              footer: page.footer.isNotEmpty ? footerBuilder : null,
              build: (pw.Context context) => pageBuilder(context),
              maxPages: 100,
            ),
          );
        }
      } else {
        pdf.addPage(
          pw.Page(
            pageTheme: pageTheme,
            build: (pw.Context context) =>
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    if (page.header.isNotEmpty) headerBuilder(context),
                    pw.Expanded(
                      child: pageBuilder(context).first,
                    ),
                    if (page.footer.isNotEmpty) footerBuilder(context),
                  ],
                ),
          ),
        );
      }
    }

    return pdf;
  }
}
