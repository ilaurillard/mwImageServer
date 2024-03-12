import 'package:intl/intl.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Colors.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/ConfigDay.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/ConfigLane.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Holiday.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Config {
  final bool weekendStrong;
  final pw.TextStyle textStyle;
  final double cellAspect;
  final bool highlightToday;
  final double iconSize;
  final double cellPadding;

  final ConfigLane lane;
  final Colors colors;
  final ConfigDay day;

  final String locale;

  final int days; // 1 - 7

  const Config({
    this.locale = 'de_DE',
    this.cellAspect = 1.0,
    this.textStyle = const pw.TextStyle(),
    this.weekendStrong = true,
    this.highlightToday = true,
    this.iconSize = 3 * PdfPageFormat.mm,
    this.cellPadding = 1 * PdfPageFormat.mm,
    this.days = 7,
    this.colors = const Colors(),
    this.lane = const ConfigLane(),
    this.day = const ConfigDay(),
  });

  static pw.Widget? label({
    required Holiday? holi,
    required Config config,
    required DateTime dt,
    required pw.TextStyle style,
  }) {
    pw.Widget? label;
    if (holi != null) {
      label = pw.Text(
        holi.inMyCounty ? holi.name : '(${holi.name})',
        style: pw.TextStyle(
          color: config.colors.textSpecial,
        ),
      );
    } else if (dt.day == 1 && holi == null) {
      label = pw.Text(
        DateFormat.MMMM(config.locale).format(dt),
        style: style,
      );
    }
    return label;
  }

  PdfColor groupColor(
    int group,
  ) {



    return PdfColors.grey;
  }
}
