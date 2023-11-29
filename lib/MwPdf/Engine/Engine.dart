import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc/ColPage.dart';
import 'Model/Footer.dart';
import 'Model/Header.dart';
import 'Model/Page.dart';
import 'Model/State.dart';
import 'Theme/Theme.dart';

class Engine {
  final List<Page> pages;

  final Map<String, Theme> themes;
  final Map<String, Header> headers;
  final Map<String, Footer> footers;

  final String baseDir;

  final State state;

  Engine({
    required this.baseDir,
    required this.pages,
    required this.themes,
    required this.headers,
    required this.footers,
    required this.state,
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

    Dict meta = (json['meta'] as Dict?) ?? {};
    return Engine(
      baseDir: baseDir,
      themes: Theme.fromJsonAll(
        (meta['theme'] as Dict?) ?? {},
        state,
      ),
      headers: Header.fromJsonAll(
        (meta['header'] as Dict?) ?? {},
      ),
      footers: Footer.fromJsonAll(
        (meta['footer'] as Dict?) ?? {},
      ),
      pages: Page.fromJsonAll(
        (json['pages'] as List?) ?? [],
      ),
      state: state,
    );
  }

  pw.Document pdf() {
    pw.Document pdf = pw.Document();

    for (Page page in pages) {
      // header callback --------------------------
      pw.Widget headerBuilder(
        pw.Context context,
      ) {
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
      pw.Widget footerBuilder(
        pw.Context context,
      ) {
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
      List<pw.Widget> pageBuilder(
        pw.Context context,
      ) {
        return page.build(
          state,
        );
      }

      // --------------------------
      // --------------------------

      if (page.multi) {
        if (page.columns > 1) {
          pdf.addPage(
            ColPage(
              pageTheme: themes[page.theme]?.theme ??
                  Theme.defaultTheme(
                    state,
                  ),
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
              pageTheme: themes[page.theme]?.theme ??
                  Theme.defaultTheme(
                    state,
                  ),
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
            pageTheme: themes[page.theme]?.theme ??
                Theme.defaultTheme(
                  state,
                ),
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
          ),
        );
      }
    }

    return pdf;
  }
}
