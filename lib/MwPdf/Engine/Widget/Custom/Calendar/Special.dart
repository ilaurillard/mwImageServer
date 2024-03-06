import 'package:mwcdn/MwPdf/Engine/Widget/Custom/Calendar/Config.dart';
import 'package:pdf/widgets.dart' as pw;

class Special {
  Map<String, String> items = {};

  Special();

  void add(String label, String icon) {
    items[label] = icon;
  }

  pw.Widget icons(
    Config styles,
  ) {
    return pw.Align(
      alignment: pw.Alignment.bottomLeft,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.end,
        children: items.entries
            .map(
              (entry) => pw.Icon(
                size: styles.iconSize,
                pw.IconData(
                  int.parse(
                    entry.value,
                    radix: 16,
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
