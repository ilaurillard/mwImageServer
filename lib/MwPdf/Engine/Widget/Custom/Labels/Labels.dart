import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Util.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Widget.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Labels {
  static pw.Widget labels(
    Dict json,
    State state,
  ) {
    Config config = Config.fromJson(
      json,
    );

    Datasource source = state.source(
      json['source'] as String?,
    );
    int amount = json['amount'] as int? ?? 0;
    if (amount < 1) {
      amount = source.values.length;
    }

    List<pw.Widget> children = [];

    for (int n = 0; n < amount; n++) {
      if (n < source.valuesFormatted.length) {
        int k = 0;
        for (dynamic value in source.valuesFormatted[n]) {
          state.variables['value$k'] = value;
          k++;
        }
      }

      children.add(
        pw.Container(
          padding: pw.EdgeInsets.all(
            config.margin,
          ),
          width: config.width,
          height: config.height,
          child: Widget.child(
            json,
            state,
          ),
        ),
      );
    }

    return pw.GridView(
      padding: config.padding,
      childAspectRatio: config.height / config.width,
      crossAxisCount: config.xNumber,
      crossAxisSpacing: config.xSpace,
      mainAxisSpacing: config.ySpace,
      children: children,
    );
  }
}

class Config {
  pw.EdgeInsets padding;
  double xSpace; // Horizontal space between 2 labels
  double ySpace; // Vertical space between 2 labels
  int xNumber; // Number of labels horizontally
  int yNumber; // Number of labels vertically
  double width; // Width of label
  double height; // Height of label
  double margin;

  Config({
    this.margin = 0,
    this.padding = pw.EdgeInsets.zero,
    this.xSpace = 0.0,
    this.ySpace = 0.0,
    this.xNumber = 1,
    this.yNumber = 1,
    this.width = 100.0,
    this.height = 100.0,
  }); // Padding

  static Config fromJson(
    Dict json,
  ) {
    Config config = Config();

    String preset = json['preset'] as String? ?? '';
    switch (preset) {
      // TODO more presets
      case '3420':
        config = Config(
          margin: 1.0 * PdfPageFormat.mm,
          padding: pw.EdgeInsets.fromLTRB(
            0,
            4.85 * PdfPageFormat.mm,
            0,
            4.85 * PdfPageFormat.mm,
          ),
          xNumber: 3,
          yNumber: 17,
          width: 70.0 * PdfPageFormat.mm,
          height: 16.9 * PdfPageFormat.mm,
        );
        break;
      case '3422':
        config = Config(
          margin: 3.0 * PdfPageFormat.mm,
          padding: pw.EdgeInsets.fromLTRB(
            0,
            8.5 * PdfPageFormat.mm,
            0,
            8.5 * PdfPageFormat.mm,
          ),
          xNumber: 3,
          yNumber: 8,
          width: 70.0 * PdfPageFormat.mm,
          height: 35.0 * PdfPageFormat.mm,
        );
        break;
      case 'L7163':
        config = Config(
          margin: 3.0 * PdfPageFormat.mm,
          padding: pw.EdgeInsets.fromLTRB(
            5,
            15 * PdfPageFormat.mm,
            5,
            15 * PdfPageFormat.mm,
          ),
          xNumber: 2,
          yNumber: 7,
          width: 99.1 * PdfPageFormat.mm,
          height: 38.1 * PdfPageFormat.mm,
          xSpace: 25,
        );
        break;
    }

    if (json['margin'] != null) {
      config.margin = double.tryParse(json['margin'].toString()) ?? 3.0;
    }
    if (json['width'] != null) {
      config.width = double.tryParse(json['width'].toString()) ?? 100.0;
    }
    if (json['height'] != null) {
      config.height = double.tryParse(json['height'].toString()) ?? 100.0;
    }
    if (json['xSpace'] != null) {
      config.xSpace = double.tryParse(json['xSpace'].toString()) ?? 100.0;
    }
    if (json['ySpace'] != null) {
      config.ySpace = double.tryParse(json['ySpace'].toString()) ?? 100.0;
    }
    if (json['padding'] != null) {
      config.padding = Util.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.zero;
    }
    if (json['xNumber'] != null) {
      config.xNumber = int.tryParse(json['xNumber'].toString()) ?? 1;
    }
    if (json['yNumber'] != null) {
      config.yNumber = int.tryParse(json['yNumber'].toString()) ?? 1;
    }

    return config;
  }
}
