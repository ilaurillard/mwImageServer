import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';

class Text {
  // static pw.RichText richText(
  //   Dict json,
  // ) {
  //   // TODO richtext/markdown
  //   // build a markdown parser?
  //   return pw.RichText(
  //     text: pw.TextSpan(
  //       text: 'test',
  //       children: [
  //         pw.TextSpan(
  //           text: 'xxx',
  //         ),
  //         pw.TextSpan(
  //           text: 'yyy',
  //         ),
  //         pw.TextSpan(
  //           text: 'zzz',
  //         ),
  //       ]
  //     ),
  //   );
  // }

  static pw.Text text(
    Dict json,
    State state,
  ) {
    String text = Etc.replaceParameters(
      json['text'] as String? ?? '',
      state,
    );
    if (text.isEmpty) {
      text = state
          .source(
            json['source'] as String?,
          )
          .text;
    }
    return pw.Text(
      text,
      style: Etc.textStyle(
        (json['style'] as Dict?) ?? {},
        state,
      ),
      textAlign: Etc.textAlign(
        json['textAlign'] as String?,
      ),
      textDirection: Etc.textDirection(
        json['textDirection'] as String?,
      ),
      softWrap: json['softWrap'] as bool?,
      tightBounds: Types.boolFromDict(json, 'tightBounds'),
      textScaleFactor:
          double.tryParse(json['textScaleFactor'].toString()) ?? 1.0,
      maxLines: int.tryParse(json['maxLines'].toString()),
      overflow: Etc.textOverflow(json['overflow'] as String?),
    );
  }
}
