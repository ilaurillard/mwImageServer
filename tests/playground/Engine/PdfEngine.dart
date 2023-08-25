import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'PdfData.dart';
import 'PdfFooter.dart';
import 'PdfHeader.dart';
import 'PdfPage.dart';
import 'PdfTheme.dart';

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

      List<pw.Widget> pageBuilder(
        pw.Context context,
      ) {
        return page.build(context);
      }

      pdf.addPage(
        pw.MultiPage(
          pageTheme: themes[page.theme]?.theme,
          header: page.header.isNotEmpty ? headerBuilder : null,
          footer: page.footer.isNotEmpty ? footerBuilder : null,
          build: (pw.Context context) => pageBuilder(context),
        ),
      );

      // pdf.addPage(
      //   pw.Page(
      //     pageTheme: themes[page.theme]?.theme,
      //     build: (pw.Context context) => pw.Column(
      //       crossAxisAlignment: pw.CrossAxisAlignment.start,
      //       children: [
      //         if (page.header.isNotEmpty) headerBuilder(context),
      //          pw.Expanded(
      //           //child: pw.Text(pw.LoremText().paragraph(100)),
      //           child: pageBuilder(context).first,
      //         ),
      //         if (page.footer.isNotEmpty) footerBuilder(context),
      //       ],
      //     ),
      //   ),
      // );
    }

    return pdf;
  }
}
