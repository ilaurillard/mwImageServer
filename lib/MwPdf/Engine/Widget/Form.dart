import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class Form {
  static pw.TextField textField(
    Dict json,
  ) {
    return pw.TextField(
      name: 'Field',
      height: 50,
      width: 300,
      maxLength: 14,
      textStyle: pw.TextStyle(
        color: PdfColors.red,
        fontSize: 40,
      ),
      color: PdfColors.blue,
      backgroundColor: PdfColors.yellow,
      // date: DateTime.now(),
      // value: 'enter',
      // defaultValue: 'enter',
      // border: PdfBorder(),
      // highlighting: PdfAnnotHighlighting.outline
      // child: pw.Text('xxx')
    );

    // return pw.Row(
    //   children: [
    //     Label(label: 'Given Name:', width: 100),
    //     Decorated(
    //       child: TextField(
    //         name: 'Given Name',
    //         value: 'David',
    //         textStyle: const TextStyle(color: PdfColors.amber),
    //       ),
    //     ),
    //   ],
    // );
  }
}

// class Label extends StatelessWidget {
//   Label({this.label, this.width});
//
//   final String? label;
//
//   final double? width;
//
//   @override
//   Widget build(Context? context,) {
//     return Container(
//       child: Text(label!),
//       width: width,
//       alignment: Alignment.centerRight,
//       margin: const EdgeInsets.only(right: 5),
//     );
//   }
// }
//
// class Decorated extends StatelessWidget {
//   Decorated({this.child, this.color});
//
//   final Widget? child;
//
//   final PdfColor? color;
//
//   @override
//   Widget build(Context? context,) {
//     return Container(
//       child: child,
//       padding: const EdgeInsets.all(2),
//       decoration: BoxDecoration(
//         color: color ?? PdfColors.yellow100,
//         border: Border.all(
//           color: PdfColors.grey,
//           width: .5,
//         ),
//       ),
//     );
//   }
// }
