import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc/ColPage.dart';
import 'Meta.dart';
import 'Model/Footer.dart';
import 'Model/Header.dart';
import 'Model/Page.dart';
import 'Model/State.dart';
import 'Theme/Theme.dart';

class Engine {
  final List<Page> pages;
  final String baseDir;
  final State state;
  final Meta meta;

  Engine({
    required this.state,
    required this.baseDir,
    required this.pages,
    required this.meta,
  });

  static Future<Engine> create(
    Dict json, {
    required String baseDir,
    required Storage storage,
  }) async {
    State state = State.fromJson(
      (json['sources'] as Dict?) ?? {},
      baseDir: baseDir,
      storage: storage,
    );
    await state.init();

    return Engine(
      baseDir: baseDir,
      pages: Page.fromJsonAll(
        (json['pages'] as List?) ?? [],
      ),
      state: state,
      meta: Meta.fromJson(
        (json['meta'] as Dict?) ?? {},
        state,
      ),
    );
  }

  pw.Document pdf() {
    pw.ThemeData? docTheme = Theme.defaultDocumentTheme(state);
    if (meta.theme.isNotEmpty) {
      pw.PageTheme? pt = meta.themes[meta.theme]?.theme;
      if (pt != null) {
        docTheme = pt.theme;
      }
    }

    pw.Document pdf = pw.Document(
      pageMode: meta.pageMode,
      theme: docTheme,
      title: meta.title,
      author: meta.author,
      creator: meta.creator,
      subject: meta.subject,
      keywords: meta.keywords,
      producer: meta.producer,
    );

    pw.Document.debug = false;
    pw.RichText.debug = false;

    int tocPageNr = 0;
    pw.Page? tocPage;
    for (Page page in pages) {
      // header callback --------------------------
      pw.Widget headerBuilder(
        pw.Context context,
      ) {
        if (page.header.isNotEmpty) {
          Header? header = meta.headers[page.header];
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
      pw.Widget footerBuilder(
        pw.Context context,
      ) {
        if (page.footer.isNotEmpty) {
          Footer? footer = meta.footers[page.footer];
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
      List<pw.Widget> pageBuilder(
        pw.Context context,
      ) {
        return page.build(
          state,
        );
      }

      // --------------------------

      pw.PageTheme? pageTheme = meta.themes[page.theme]?.theme ??
          Theme.defaultPageTheme(
            state,
          );

      // --------------------------

      pw.Page pwPage;
      if (page.multi) {
        if (page.columns > 1) {
          pwPage = ColPage(
            pageTheme: pageTheme,
            header: page.header.isNotEmpty ? headerBuilder : null,
            footer: page.footer.isNotEmpty ? footerBuilder : null,
            build: (pw.Context context) => pageBuilder(context),
            columns: page.columns,
            gapWidth: page.gapWidth,
          );
        } else {
          pwPage = pw.MultiPage(
            pageTheme: pageTheme,
            header: page.header.isNotEmpty ? headerBuilder : null,
            footer: page.footer.isNotEmpty ? footerBuilder : null,
            build: (pw.Context context) => pageBuilder(context),
            maxPages: 100,
          );
        }
      } else {
        pwPage = pw.Page(
          pageTheme: pageTheme,
          build: (pw.Context context) => pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (page.header.isNotEmpty) headerBuilder(context),
              pw.Expanded(
                child: pageBuilder(context).first,
              ),
              if (page.footer.isNotEmpty) footerBuilder(context),
            ],
          ),
        );
      }
      if (page.toc > 0) {
        tocPage = pwPage;
        tocPageNr = page.toc;
      } else {
        pdf.addPage(pwPage);
      }
    }

    if (tocPage != null) {
      pdf.addPage(
        tocPage,
        index: tocPageNr - 1,
      );
    }

    return pdf;
  }
}
