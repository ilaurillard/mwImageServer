import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HyphenatedParagraph extends pw.StatelessWidget {
  HyphenatedParagraph({
    this.text,
    this.textAlign = pw.TextAlign.justify,
    this.style,
    this.margin = const pw.EdgeInsets.only(
      bottom: 5.0 * PdfPageFormat.mm,
    ),
    this.padding,
    this.hyphenation,
  });

  final String? text;
  final pw.TextAlign textAlign;
  final pw.TextStyle? style;
  final pw.EdgeInsetsGeometry margin;
  final pw.EdgeInsetsGeometry? padding;
  final pw.Hyphenation? hyphenation;

  @override
  pw.Widget build(
    pw.Context context,
  ) {
    return pw.Container(
      margin: margin,
      padding: padding,
      child: HyphenatedText(
        text!,
        textAlign: textAlign,
        style: pw.Theme.of(context).paragraphStyle.merge(style),
        overflow: pw.TextOverflow.span,
        hyphenation: hyphenation,
      ),
    );
  }
}

class HyphenatedText extends pw.RichText {
  HyphenatedText(
    String text, {
    pw.TextStyle? style,
    super.textAlign,
    super.textDirection,
    super.softWrap,
    super.tightBounds,
    super.textScaleFactor,
    super.maxLines,
    super.overflow = null,
    super.hyphenation,
  }) : super(
          text: pw.TextSpan(text: text, style: style),
        );
}

// this is the word overflow logic in Richtext.layout (buildlines)
// see https://github.com/DavBfr/dart_pdf/pull/1563
// if (hyphenation != null) {
//   List<String> syllables = hyphenation!(word);
//   if (syllables.length > 1) {
//     String fits = '';
//     for (String syllable in syllables) {
//       if (offsetX + ((font.stringMetrics(
//           fits + syllable + '-',
//           letterSpacing: style.letterSpacing! /
//               (style.fontSize! * textScaleFactor)) *
//           (style.fontSize! * textScaleFactor)).width) >
//           constraintWidth + 0.00001) {
//         break;
//       }
//       fits += syllable;
//     }
//     if (fits.isNotEmpty) {
//       words[index] = fits + '-';
//       words.insert(index + 1, word.substring(fits.length));
//       index--;
//       continue;
//     }
//   }
// }
