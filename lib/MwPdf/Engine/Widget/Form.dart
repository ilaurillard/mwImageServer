import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:mwcdn/MwPdf/Engine/Widget/Util.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Form {

  static pw.Widget choiceField(
      Dict json,
      State state,
      ) {
    double height = (double.tryParse(json['height'].toString()) ?? 8.0) * PdfPageFormat.mm;

    String name = json['name'] as String? ?? '';
    String label = json['label'] as String? ?? '';

    PdfColor? color = Util.color(json['color'] as String?);
    PdfColor? bgColor = Util.color(json['bgColor'] as String?);

    pw.TextStyle? textStyle = Util.textStyle(
      (json['textStyle'] as Dict?) ?? {},
      state,
    );
    if (textStyle != null && textStyle.font == null) {
      textStyle = textStyle.copyWith(
        font: pw.Font.helvetica(),
      );
    }

    pw.TextStyle? labelStyle = Util.textStyle(
      (json['labelStyle'] as Dict?) ?? {},
      state,
    );

    List<String> items = (json['items'] as List<dynamic>? ?? []).cast();


    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          height: height,
          width: double.infinity,
          margin: pw.EdgeInsets.only(
            bottom: 1 * PdfPageFormat.mm,
          ),
          decoration: pw.BoxDecoration(
            color: bgColor ?? PdfColors.grey200,
            border: pw.Border(
              bottom: pw.BorderSide(
                width: 0.25 * PdfPageFormat.mm,
                color: color ?? PdfColors.black,
              ),
            ),
          ),
          child: pw.ChoiceField(
            name: name,
            textStyle: textStyle,
            items: items,
          ),
        ),
        pw.Text(
          label,
          style: labelStyle,
        ),
      ],
    );
  }

  static pw.Widget checkbox(
    Dict json,
    State state,
  ) {
    String name = json['name'] as String? ?? '';
    String label = json['label'] as String? ?? '';
    PdfColor? color = Util.color(json['color'] as String?);
    PdfColor? bgColor = Util.color(json['bgColor'] as String?);
    PdfColor? activeColor = Util.color(json['activeColor'] as String?);
    PdfColor? checkColor = Util.color(json['checkColor'] as String?);
    pw.TextStyle? labelStyle = Util.textStyle(
      (json['labelStyle'] as Dict?) ?? {},
      state,
    );

    return pw.Container(
      child: pw.Row(
        children: [
          pw.Checkbox(
            name: name,
            value: false,
            activeColor: activeColor ?? PdfColors.blue,
            checkColor: checkColor ?? PdfColors.white,
            decoration: pw.BoxDecoration(
              color: bgColor ?? PdfColors.grey200,
              border: pw.Border.all(
                color: color ?? PdfColors.black,
                width: 1,
              ),
            ),
          ),
          pw.SizedBox(
            width: 1.5 * PdfPageFormat.mm,
          ),
          pw.Text(
            label,
            style: labelStyle,
          ),
        ],
      ),
    );
  }

  static pw.Widget textField(
    Dict json,
    State state,
  ) {
    double height = (double.tryParse(json['height'].toString()) ?? 8.0) * PdfPageFormat.mm;

    String name = json['name'] as String? ?? '';
    String label = json['label'] as String? ?? '';
    List<int> comb = (json['comb'] as List<dynamic>? ?? []).cast();
    int maxLength = int.tryParse(json['maxLength'].toString()) ?? 32;

    PdfColor? color = Util.color(json['color'] as String?);
    PdfColor? bgColor = Util.color(json['bgColor'] as String?);

    pw.TextStyle? textStyle = Util.textStyle(
      (json['textStyle'] as Dict?) ?? {},
      state,
    );
    if (textStyle != null && textStyle.font == null) {
      textStyle = textStyle.copyWith(
        font: pw.Font.helvetica(),
      );
    }

    pw.TextStyle? labelStyle = Util.textStyle(
      (json['labelStyle'] as Dict?) ?? {},
      state,
    );

    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Container(
          height: height,
          width: double.infinity,
          margin: pw.EdgeInsets.only(
            bottom: 1 * PdfPageFormat.mm,
          ),
          decoration: pw.BoxDecoration(
            color: bgColor ?? PdfColors.grey200,
            border: pw.Border(
              bottom: pw.BorderSide(
                width: 0.25 * PdfPageFormat.mm,
                color: color ?? PdfColors.black,
              ),
            ),
          ),
          child: pw.Stack(
            fit: pw.StackFit.passthrough,
            children: [
              _comb(
                comb,
                height,
                color,
              ),
              pw.TextField(
                name: name,
                maxLength: maxLength,
                textStyle: textStyle,
                fieldFlags: {
                  if (comb.isNotEmpty) PdfFieldFlags.comb,
                },
              ),
            ],
          ),
        ),
        pw.Text(
          label,
          style: labelStyle,
        ),
      ],
    );
  }

  static pw.Widget _comb(
    List<int> combDef,
    double height,
    PdfColor? color,
  ) {
    if (combDef.isEmpty) {
      return pw.Container();
    }

    List<pw.Widget> fields = [];

    List<bool> sep = [];
    int total = 0;
    for (int f in combDef) {
      total += f;
      for (int g = 0; g < f; g++) {
        sep.add(g == f - 1);
      }
    }

    for (int i = 0; i < total; i++) {
      fields.add(
        pw.Expanded(
          child: pw.Container(
            height: sep[i] ? height : height * 0.7,
            decoration: i == total - 1
                ? null
                : pw.BoxDecoration(
                    border: pw.Border(
                      right: pw.BorderSide(
                        color: color ?? PdfColors.black,
                        width: 0.25 * PdfPageFormat.mm,
                      ),
                    ),
                  ),
          ),
        ),
      );
    }

    return pw.Container(
      decoration: pw.BoxDecoration(
        border: pw.Border(
          left: pw.BorderSide(
            width: 0.25 * PdfPageFormat.mm,
            color: color ?? PdfColors.black,
          ),
          right: pw.BorderSide(
            width: 0.25 * PdfPageFormat.mm,
            color: color ?? PdfColors.black,
          ),
        ),
      ),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.end,
        children: fields,
      ),
    );
  }
}
