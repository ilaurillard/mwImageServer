import 'package:markdown/markdown.dart' as md;
import 'package:mwcdn/MwPdf/Engine/Model/Unwrapped.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Markdown implements md.NodeVisitor {
  final String markdownContent;

  final double margin1 = 10.0;
  final double margin2 = 6.0;
  final double margin3 = 3.0;
  final double size1 = 12.0;
  final double size2 = 10.0;
  final double size3 = 8.0;
  final double size4 = 6.0;

  bool bold = false;
  bool oblique = false;
  bool code = false;
  double? size;

  List<List<pw.Widget>> widgets = [[]];
  List<pw.TextSpan> spans = [];

  int listDepth = 0;

  Markdown(
    this.markdownContent,
  );

  pw.Widget toRichText() {
    parse(markdownContent);

    return Unwrapped(
      children: widgets.first,
    );
  }

  // ----------------------------

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
                  color: PdfColors.grey200,
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

  void quote() {
    // print('  >>> XXX ${widgets.length}');

    List<pw.Widget> children = widgets.removeLast();
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
                  top: margin1,
                  right: margin1,
                  bottom: margin2,
                ),
                decoration: pw.BoxDecoration(
                  color: PdfColors.grey300,
                  border: pw.Border(
                    left: pw.BorderSide(
                      color: PdfColors.grey,
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
        // color: PdfColors.orange,
        padding: pw.EdgeInsets.only(
          bottom: listDepth == 0 ? margin1 : 0,
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
              right: margin2,
              top: 6,
            ),
            child: pw.Icon(
              pw.IconData(
                0xEf4a,
              ),
              size: 8,
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
  }

  void paragraph() {
    if (spans.isNotEmpty) {
      widgets.last.add(
        pw.Container(
          // color: PdfColors.lightBlue,
          padding: pw.EdgeInsets.only(bottom: margin1),
          child: pw.RichText(
            overflow: pw.TextOverflow.span,
            text: pw.TextSpan(
              children: spans,
            ),
          ),
        ),
      );
      spans = [];
    }
  }

  void headline() {
    if (spans.isNotEmpty) {
      widgets.last.add(
        pw.Container(
          // color: PdfColors.lightGreen,
          padding: pw.EdgeInsets.only(bottom: margin1),
          child: pw.RichText(
            overflow: pw.TextOverflow.span,
            text: pw.TextSpan(
              children: spans,
            ),
          ),
        ),
      );
      spans = [];
    }
  }

  // -----------------------

  @override
  bool visitElementBefore(
    md.Element element,
  ) {
    print('start ${element.tag}');

    switch (element.tag) {
      case 'ul':
      case 'ol':
        listDepth++;
        consumeSpans();
        widgets.add([]);
        break;
      case 'blockquote':
      case 'pre':
      case 'li':
        consumeSpans();
        widgets.add([]);
        break;
      case 'h1':
        size = size1 * PdfPageFormat.mm;
        bold = true;
        break;
      case 'h2':
        size = size2 * PdfPageFormat.mm;
        bold = true;
        break;
      case 'h3':
        size = size3 * PdfPageFormat.mm;
        bold = true;
        break;
      case 'h4':
        size = size4 * PdfPageFormat.mm;
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
    print('end ${element.tag}');

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
        quote();
        break;
      case 'pre':
        consumeSpans();
        pre();
        break;
      case 'li':
        consumeSpans();
        listElement();
        size = null;
        bold = false;
        break;
      case 'ul':
      case 'ol':
        listDepth--;
        list();
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
    pw.TextStyle? textStyle;

    if (code || bold || oblique || size != null) {
      if (code) {
        bg = pw.BoxDecoration(
          color: PdfColors.grey200,
        );
        font = pw.Font.courier();
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

  void consumeSpans() {
    if (spans.isNotEmpty) {
      widgets.last.add(
        pw.RichText(
          overflow: pw.TextOverflow.span,
          text: pw.TextSpan(
            children: spans,
          ),
        ),
      );
      spans = [];
    }
  }
}
