import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Snip {
  static pw.Widget build({
    pw.Axis direction = pw.Axis.horizontal,
    double offset = 20,
    pw.EdgeInsets? padding,
  }) {
    return direction == pw.Axis.horizontal
        ? horizontal(
            offset: offset,
            padding: padding,
          )
        : vertical(
            offset: offset,
            padding: padding,
          );
  }

  static pw.Widget horizontal({
    pw.EdgeInsets? padding,
    double offset = 20,
  }) {
    return pw.Padding(
      padding: padding ?? pw.EdgeInsets.zero,
      child: pw.Stack(
        overflow: pw.Overflow.visible,
        children: [
          pw.Divider(
            borderStyle: pw.BorderStyle.dashed,
            height: 1 * PdfPageFormat.mm,
          ),
          pw.Positioned(
            left: offset * PdfPageFormat.mm,
            top: -3 * PdfPageFormat.mm,
            child: _scissors(90),
          ),
        ],
      ),
    );
  }

  static pw.Widget vertical({
    pw.EdgeInsets? padding,
    double offset = 20,
  }) {
    return pw.Padding(
      padding: padding ?? pw.EdgeInsets.zero,
      child: pw.Stack(
        overflow: pw.Overflow.visible,
        children: [
          pw.VerticalDivider(
            borderStyle: pw.BorderStyle.dashed,
            width: 1 * PdfPageFormat.mm,
          ),
          pw.Positioned(
            left: -3.25 * PdfPageFormat.mm,
            bottom: offset * PdfPageFormat.mm,
            child: _scissors(0),
          ),
        ],
      ),
    );
  }

  static pw.Widget _scissors(double rot) {
    return pw.SizedBox(
      width: 7 * PdfPageFormat.mm,
      height: 7 * PdfPageFormat.mm,
      child: pw.SvgImage(
        svg: '<svg viewBox="0 0 512 512">'
            '<path transform="rotate($rot 256 256)" class="st0" d="M494.758,381.889l-30.281-47.641c-12.5-19.688-31.953-32.563-53.063-37.25 '
            'c-16.031-3.594-33.219-2.484-49.203,3.766c-24.469,5.281-38.078-11.594-46.594-24.969l-18.031-28.391l88.078-184.391 '
            'c11.875-28.75,7.219-49.484-14.047-63.016L256.008,181.967L140.398-0.002c-21.281,13.531-25.922,34.266-14.063,63.016 '
            'l88.078,184.391l-18.031,28.391c-8.516,13.375-22.125,30.25-46.594,24.969c-15.969-6.25-33.156-7.359-49.203-3.766 '
            'c-21.109,4.688-40.563,17.563-53.063,37.25l-30.281,47.641C4.727,401.576,1.352,424.654,6.07,445.732 '
            'c4.672,21.109,17.547,40.547,37.234,53.047c19.688,12.516,42.766,15.906,63.844,11.188c21.094-4.688,40.563-17.547,53.063-37.25 '
            'l30.281-47.641c12.516-19.672,15.891-42.766,11.172-63.859c-1.109-4.984-2.688-9.891-4.719-14.641 '
            'c14.203-22.359,20.531-31.109,29.969-47.156c9.188-15.641,19.531-24.391,29.094-29.188c9.547,4.797,19.891,13.547,29.078,29.188 '
            'c9.438,16.047,15.766,24.797,29.969,47.156c-2.016,4.75-3.609,9.656-4.719,14.641c-4.719,21.094-1.344,44.188,11.188,63.859 '
            'l30.266,47.641c12.516,19.703,31.969,32.563,53.063,37.25c21.078,4.719,44.156,1.328,63.844-11.188 '
            'c19.688-12.5,32.563-31.938,37.234-53.047C510.648,424.654,507.273,401.576,494.758,381.889z M157.023,403.811l-30.266,47.656 '
            'c-6.734,10.547-16.922,17.266-28.234,19.813c-11.313,2.5-23.391,0.75-33.953-5.953c-10.547-6.703-17.266-16.906-19.813-28.203 '
            'c-2.5-11.328-0.734-23.406,5.953-33.969l30.281-47.656c6.703-10.547,16.891-17.266,28.219-19.813 '
            'c11.313-2.5,23.391-0.75,33.953,5.953c10.547,6.703,17.266,16.906,19.813,28.219C165.477,381.17,163.727,393.264,157.023,403.811z '
            'M255.664,243.779c-7.641,0-13.813-6.188-13.813-13.813s6.172-13.813,13.813-13.813c7.625,0,13.813,6.188,13.813,13.813 '
            'S263.289,243.779,255.664,243.779z M467.242,437.123c-2.547,11.297-9.266,21.5-19.813,28.203s-22.641,8.453-33.953,5.953 '
            'c-11.313-2.547-21.5-9.266-28.219-19.813l-30.281-47.656c-6.688-10.547-8.438-22.641-5.938-33.953 '
            'c2.531-11.313,9.25-21.516,19.813-28.219c10.547-6.703,22.625-8.453,33.953-5.953c11.313,2.547,21.5,9.266,28.219,19.813 '
            'l30.281,47.656C467.992,413.717,469.742,425.795,467.242,437.123z"/>'
            '</svg>',
      ),
    );
  }
}
