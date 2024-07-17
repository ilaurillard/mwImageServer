import 'dart:io';

import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwInvoice/Service/Invoice.dart';
import 'package:mwcdn/MwPdf/Engine/Storage.dart';
import 'package:mwcdn/MwInvoice/Service/CrossIndustryInvoice/Util.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc/MultiColumnsPage.dart';
import 'Meta.dart';
import 'Model/Footer.dart';
import 'Model/Header.dart';
import 'Model/Page.dart';
import 'Model/State.dart';
import 'Theme/Theme.dart';

class Engine {
  final List<Page> pages;
  final String resDir;
  final State state;
  final Meta meta;

  Engine({
    required this.state,
    required this.resDir,
    required this.pages,
    required this.meta,
    required this.invoice,
  });

  final Invoice invoice;

  static Future<Engine> create(
    Dict json, {
    required String resDir,
    required Storage storage,
  }) async {
    State state = State.fromJson(
      sources: (json['sources'] as Dict?) ?? {},
      variables: (json['variables'] as Dict?) ?? {},
      resDir: resDir,
      storage: storage,
    );
    await state.init();

    return Engine(
      resDir: resDir,
      pages: Page.fromJsonAll(
        (json['pages'] as List?) ?? [],
      ),
      state: state,
      meta: Meta.fromJson(
        (json['meta'] as Dict?) ?? {},
        state,
      ),
      invoice: Invoice.fromJson(
        (json['facturx'] as Dict?) ?? {},
        (json['xrechnung'] as Dict?) ?? {},
      ),
    );
  }

  // Create the pdf -------------------
  Future<pw.Document> pdf() async {

    pw.PageTheme? pageTheme;
    if (meta.theme.isNotEmpty) {
      pageTheme = meta.themes[meta.theme]?.theme;
    }

    pw.ThemeData? docTheme = Theme.defaultDocumentTheme(state);
    if (pageTheme != null) {
      docTheme = pageTheme.theme;
    }

    // --------------------------------------

    pw.Document.debug = false;
    pw.RichText.debug = false;

    pw.Document pdf = pw.Document(
      pageMode: meta.pageMode,
      theme: docTheme,

      title: meta.title,
      author: meta.author,
      creator: meta.creator,
      subject: meta.subject,
      keywords: meta.keywords,
      producer: meta.producer,

      // verbose: true,
      compress: meta.compress,
      version: PdfVersion.pdf_1_5,

      metadata: meta.pdfaRdf(
        cii: invoice.cii != null,
        ubl: invoice.ubl != null,
      ),
    );

    // -------------------------

    if (meta.pdfa3b) {
      // Needed for PDF/A 3b compliency
      PdfaColorProfile(
        pdf.document,
        File('$resDir/sRGB2014.icc').readAsBytesSync(),
      );
    }

    // -------------------------

    // embedded invoice xml

    if (invoice.cii != null) {
      PdfaAttachedFiles(
        pdf.document,
        {
          'factur-x.xml': Util.prettyXml(
            invoice.cii!,
          ),
        },
      );
    }

    if (invoice.ubl != null) {
      PdfaAttachedFiles(
        pdf.document,
        {
          // TODO xxx?
          'xrechnung.xml': Util.prettyXml(
            invoice.ubl!,
          ),
        },
      );
    }

    // ------------------------- Headers/Footers

    int tocPageNr = 0;
    pw.Page? tocPage;
    for (Page page in pages) {
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

      // ---------------

      List<pw.Widget> pageBuilder(
        pw.Context context,
      ) {
        return page.build(
          context,
          state,
        );
      }

      // -------------------------

      pageTheme = meta.themes[page.theme]?.theme ??
          pageTheme ??
          Theme.defaultPageTheme(
            state,
          );

      pw.Page pwPage;
      if (page.multi) {
        if (page.columns > 1) {
          // Custom version of MultiPage
          pwPage = MultiColumnsPage(
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

      // -------------------------

      if (page.toc > 0) {
        tocPage = pwPage;
        tocPageNr = page.toc;
      } else {
        pdf.addPage(pwPage);
      }
    }
    if (tocPage != null) {
      // insert "table of contents" page
      pdf.addPage(
        tocPage,
        index: tocPageNr - 1,
      );
    }

    return pdf;
  }
}
