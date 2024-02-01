import 'package:markdown/markdown.dart' as md;
import 'package:mwcdn/MwPdf/Engine/Model/Unwrapped.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Markdown implements md.NodeVisitor {
  // ---------------------

  // STATE
  bool bold = false;
  bool oblique = false;
  bool code = false;
  double? size;

  List<List<pw.Widget>> widgets = [[]];
  List<pw.TextSpan> spans = [];

  int listDepth = 0;
  List<int> listNr = [];
  int quoteDepth = 0;

  // ---------------------

  final String markdownContent;

  final PdfColor colorQuote;

  final double margin1;
  final double margin2;
  final double margin3;
  final double fontSize1;
  final double fontSize2;
  final double fontSize3;
  final double fontSize4;
  final double fontSize5;
  final int bulletIcon;
  final PdfColor colorCode;
  late pw.Font? fontCode;
  final pw.TextStyle? style;

  Markdown(
    this.markdownContent, {
    this.margin1 = 5.0 * PdfPageFormat.mm,
    this.margin2 = 3.0 * PdfPageFormat.mm,
    this.margin3 = 1.5 * PdfPageFormat.mm,
    this.fontSize1 = 12.0 * PdfPageFormat.mm,
    this.fontSize2 = 10.0 * PdfPageFormat.mm,
    this.fontSize3 = 8.0 * PdfPageFormat.mm,
    this.fontSize4 = 6.0 * PdfPageFormat.mm,
    this.fontSize5 = 4.0 * PdfPageFormat.mm,
    this.bulletIcon = 0xEf4a,
    this.colorCode = PdfColors.grey200,
    this.colorQuote = PdfColors.grey200,
    this.style,
    this.fontCode,
  }) {
    fontCode ??= pw.Font.courier();
  }

  pw.Widget toRichText() {
    parse(markdownContent);

    return Unwrapped(
      children: widgets.first,
    );
  }

  // ----------------------------

  void headline() {
    if (spans.isNotEmpty) {
      widgets.last.add(
        pw.Container(
          padding: pw.EdgeInsets.only(
            bottom: margin1,
          ),
          child: pw.RichText(
            overflow: pw.TextOverflow.span,
            text: pw.TextSpan(
              children: spans,
              style: style,
            ),
          ),
        ),
      );
      spans = [];
    }
  }

  void paragraph() {
    if (spans.isNotEmpty) {
      widgets.last.add(
        pw.Container(
          padding: pw.EdgeInsets.only(bottom: margin1),
          child: pw.RichText(
            overflow: pw.TextOverflow.span,
            text: pw.TextSpan(
              children: spans,
              style: style,
            ),
          ),
        ),
      );
      spans = [];
    }
  }

  void quote() {
    List<pw.Widget> children = widgets.removeLast();

    PdfColor c = colorQuote.shade(0.78);
    switch (quoteDepth) {
      case 0:
        c = colorQuote;
        break;
      case 1:
        c = colorQuote.shade(0.57);
        break;
      case 2:
        c = colorQuote.shade(0.64);
        break;
      case 3:
        c = colorQuote.shade(0.71);
        break;
    }

    widgets.last.add(
      pw.Container(
        margin: pw.EdgeInsets.only(bottom: margin1),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.SizedBox(width: margin2),
            pw.Expanded(
              child: pw.Container(
                padding: pw.EdgeInsets.only(
                  left: margin1,
                  top: margin2,
                  right: margin1,
                ),
                decoration: pw.BoxDecoration(
                  color: c,
                  border: pw.Border(
                    left: pw.BorderSide(
                      // style: pw.BorderStyle.dashed,
                      color: colorQuote.shade(0.9),
                      width: margin3,
                    ),
                  ),
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    spans = [];
  }

  void list() {
    List<pw.Widget> children = widgets.removeLast();
    widgets.last.add(
      pw.Container(
        padding: pw.EdgeInsets.only(
          top: listDepth == 0 ? 0 : margin3,
          bottom: listDepth == 0 ? margin1 : margin3,
        ),
        child: pw.Column(
          children: children,
        ),
      ),
    );
    spans = [];
  }

  void listElement() {
    List<pw.Widget> children = widgets.removeLast();
    widgets.last.add(
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Padding(
            padding: pw.EdgeInsets.only(
              left: margin3,
              top: listNr.last == 0 ? fontSize5 / 2 : 0,
              right: margin2,
            ),
            child: listNr.last > 0
                ? pw.Text(
                    '${listNr.last}.',
                  )
                : pw.Icon(
                    pw.IconData(
                      bulletIcon,
                    ),
                    size: fontSize5,
                  ),
          ),
          pw.Expanded(
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
    if (listNr.last > 0) {
      listNr.last++;
    }
  }

  void pre() {
    List<pw.Widget> children = widgets.removeLast();

    widgets.last.add(
      pw.Container(
        margin: pw.EdgeInsets.only(bottom: margin1),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Container(
                padding: pw.EdgeInsets.all(
                  margin1,
                ),
                decoration: pw.BoxDecoration(
                  color: colorCode,
                ),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    spans = [];
  }

  // -----------------------

  void parse(
    String markdownContent,
  ) {
    spans = [];
    widgets = [[]];
    for (md.Node node in md.Document(
      encodeHtml: false,
    ).parseLines(
      markdownContent.split('\n'),
    )) {
      node.accept(this);
    }
  }

  @override
  bool visitElementBefore(
    md.Element element,
  ) {
    // print('start ${element.tag}');

    switch (element.tag) {
      case 'ul':
        listDepth++;
        spansToRichText();
        widgets.add([]);
        listNr.add(0);
        break;
      case 'ol':
        listDepth++;
        spansToRichText();
        widgets.add([]);
        listNr.add(1);
        break;
      case 'blockquote':
        quoteDepth++;
        spansToRichText();
        widgets.add([]);
        break;
      case 'pre':
      case 'li':
        spansToRichText();
        widgets.add([]);
        break;
      case 'h1':
        size = fontSize1;
        bold = true;
        break;
      case 'h2':
        size = fontSize2;
        bold = true;
        break;
      case 'h3':
        size = fontSize3;
        bold = true;
        break;
      case 'h4':
        size = fontSize4;
        bold = true;
        break;
      case 'p':
        break;
      case 'em':
        oblique = true;
        break;
      case 'code':
        code = true;
        break;
      case 'strong':
        bold = true;
        break;
    }

    return true;
  }

  @override
  void visitElementAfter(
    md.Element element,
  ) {
    // print('end ${element.tag}');

    switch (element.tag) {
      case 'p':
        paragraph();
        size = null;
        bold = false;
        break;
      case 'h1':
      case 'h2':
      case 'h3':
      case 'h4':
        headline();
        size = null;
        bold = false;
        break;
      case 'blockquote':
        quoteDepth--;
        quote();
        break;
      case 'pre':
        spansToRichText();
        pre();
        break;
      case 'li':
        spansToRichText();
        listElement();
        size = null;
        bold = false;
        break;
      case 'ul':
      case 'ol':
        listDepth--;
        list();
        listNr.removeLast();
        break;
      case 'em':
        oblique = false;
        break;
      case 'strong':
        bold = false;
        break;
      case 'code':
        code = false;
        break;
    }
  }

  @override
  void visitText(
    md.Text text,
  ) {
    // print('TEXT ${text.textContent}');

    pw.FontWeight? fontWeight = bold ? pw.FontWeight.bold : null;
    pw.FontStyle? fontStyle = oblique ? pw.FontStyle.italic : null;

    pw.Font? font;
    pw.BoxDecoration? bg;
    pw.TextStyle? textStyle = style;

    if (code || bold || oblique || size != null) {
      if (code) {
        bg = pw.BoxDecoration(
          color: colorCode,
        );
        font = fontCode;
      }

      textStyle = pw.TextStyle(
        font: font,
        background: bg,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        fontSize: size,
      );
    }

    spans.add(
      pw.TextSpan(
        text: text.textContent,
        style: textStyle,
      ),
    );
  }

  void spansToRichText() {
    if (spans.isNotEmpty) {
      widgets.last.add(
        pw.RichText(
          overflow: pw.TextOverflow.span,
          text: pw.TextSpan(
            children: spans,
            style: style,
          ),
          // textScaleFactor: 2,
        ),
      );
      spans = [];
    }
  }

  PdfColor darken(
    PdfColor c, [
    int percent = 10,
  ]) {
    return c.shade(.6);
  }
}
