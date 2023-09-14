import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Model/Resources.dart';
import 'Model/Footer.dart';
import 'Model/Header.dart';
import 'Model/Page.dart';
import 'Theme/Theme.dart';

class Engine {
  final List<Page> pages;
  final Map<String, Theme> themes;
  final Map<String, Header> headers;
  final Map<String, Footer> footers;
  final Resources resources;

  static late Resources res;

  Engine({
  required this.pages,
    required this.themes,
    required this.headers,
    required this.footers,
    required this.resources,
  }) {
    Engine.res = resources;
  }

  static Engine fromJson(
    Dict json,
  ) {
    Dict meta = (json['meta'] as Dict?) ?? {};
    return Engine(
      pages: Page.fromJsonAll(
        (json['pages'] as List?) ?? [],
      ),
      themes: Theme.fromJsonAll(
        (meta['theme'] as Dict?) ?? {},
      ),
      headers: Header.fromJsonAll(
        (meta['header'] as Dict?) ?? {},
      ),
      footers: Footer.fromJsonAll(
        (meta['footer'] as Dict?) ?? {},
      ),
      resources: Resources.fromJson(
        (json['resources'] as Dict?) ?? {},
      ),
    );
  }

  pw.Document buildPdf() {
    pw.Document pdf = pw.Document();

    for (Page page in pages) {
      // header callback --------------------------
      pw.Widget headerBuilder(
        pw.Context context,
      ) {
        if (page.header.isNotEmpty) {
          Header? header = headers[page.header];
          if (header != null) {
            return header.build(context);
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
            return footer.build(context);
          }
        }
        return pw.SizedBox();
      }

      // page builder  --------------------------
      List<pw.Widget> pageBuilder(
        pw.Context context,
      ) {
        return page.build(context);
      }

      // --------------------------
      // --------------------------

      if (page.multi) {
        pdf.addPage(
          pw.MultiPage(
            pageTheme: themes[page.theme]?.theme,
            header: page.header.isNotEmpty ? headerBuilder : null,
            footer: page.footer.isNotEmpty ? footerBuilder : null,
            build: (pw.Context context) => pageBuilder(context),
          ),
        );
      } else {
        pdf.addPage(
          pw.Page(
            pageTheme: themes[page.theme]?.theme,
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
