import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

// class Decorated extends pw.StatelessWidget {
//   Decorated({this.child, this.color});
//
//   final pw.Widget? child;
//
//   final PdfColor? color;
//
//   @override
//   pw.Widget build(pw.Context? context) {
//     return pw.Container(
//       child: child,
//       padding: const pw.EdgeInsets.all(2),
//       decoration: pw.BoxDecoration(
//         // color: color ?? PdfColors.yellow100,
//         border: pw.Border.all(
//           color: PdfColors.grey,
//           width: .5,
//         ),
//       ),
//     );
//   }
// }

class Form {
  static pw.TextField textField(
    Dict json,
  ) {
    // return Decorated(
    //   child: pw.TextField(
    //     name: 'Given Name',
    //     value: 'David',
    //     textStyle: const pw.TextStyle(
    //       color: PdfColors.green,
    //     ),
    //   ),
    //   color: PdfColors.green,
    // );

    return pw.TextField(
      name: 'Field',
      height: 50,
      width: 300,
      // maxLength: 14,
      textStyle: pw.TextStyle(
        color: PdfColors.red,
        fontSize: 40,
      ),
      color: PdfColors.blue,
      backgroundColor: PdfColors.teal,
      // date: DateTime.now(),
      value: 'enter',

      // defaultValue: 'enter',
      // border: PdfBorder(),
      highlighting: PdfAnnotHighlighting.toggle
      // child: pw.Text(
      //   'xxx',
      //   style: pw.TextStyle(
      //     color: PdfColors.blue,
      //     fontSize: 40,
      //   ),
      // ),
    );
  }
}

