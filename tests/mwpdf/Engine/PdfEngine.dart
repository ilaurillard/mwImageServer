import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Model/PdfResources.dart';
import 'Model/PdfFooter.dart';
import 'Model/PdfHeader.dart';
import 'Model/PdfPage.dart';
import 'Theme/PdfTheme.dart';

class PdfEngine {
  final List<PdfPage> pages;
  final Map<String, PdfTheme> themes;
  final Map<String, PdfHeader> headers;
  final Map<String, PdfFooter> footers;
  final PdfResources resources;

  static late PdfResources res;

  PdfEngine({
  required this.pages,
    required this.themes,
    required this.headers,
    required this.footers,
    required this.resources,
  }) {
    PdfEngine.res = resources;
  }

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
      resources: PdfResources.fromJson(
        (json['resources'] as Dict?) ?? {},
      ),
    );
  }

  pw.Document buildPdf() {
    pw.Document pdf = pw.Document();

    for (PdfPage page in pages) {
      // header callback --------------------------
      pw.Widget headerBuilder(
        pw.Context context,
      ) {
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
