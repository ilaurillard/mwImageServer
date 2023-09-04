import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Model/PdfData.dart';
import 'Model/PdfFooter.dart';
import 'Model/PdfHeader.dart';
import 'Model/PdfPage.dart';
import 'Theme/PdfTheme.dart';

class PdfEngine {
  List<PdfPage> pages;
  Map<String, PdfData> data;
  Map<String, PdfTheme> themes;
  Map<String, PdfHeader> headers;
  Map<String, PdfFooter> footers;

  PdfEngine({
    this.pages = const [],
    this.data = const {},
    this.themes = const {},
    this.headers = const {},
    this.footers = const {},
  });

  static PdfEngine fromJson(
    Dict json,
  ) {
    Dict meta = (json['meta'] as Dict?) ?? {};

    return PdfEngine(
      pages: PdfPage.fromJsonAll(
        (json['pages'] as List?) ?? [],
      ),
      themes: PdfTheme.fromJsonAll(
        (meta['theme'] as Dict?) ?? {},
      ),
      headers: PdfHeader.fromJsonAll(
        (meta['header'] as Dict?) ?? {},
      ),
      footers: PdfFooter.fromJsonAll(
        (meta['footer'] as Dict?) ?? {},
      ),
    );
  }

  pw.Document build() {
    pw.Document pdf = pw.Document();

    for (PdfPage page in pages) {
      // header callback --------------------------
      pw.Widget headerBuilder(
        pw.Context context,
      ) {

        //print('Header ${context.pageNumber}/${context.pagesCount}');

        if (page.header.isNotEmpty) {
          PdfHeader? header = headers[page.header];
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

        //print('Footer ${context.pageNumber}/${context.pagesCount}');

        if (page.footer.isNotEmpty) {
          PdfFooter? footer = footers[page.footer];
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
