import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Etc.dart';

class Text {
  static pw.Text text(
    Dict json,
  ) {
    return pw.Text(
      Etc.replaceParameters(json['text'] as String? ?? '¿'),
      style: Etc.textStyle((json['style'] as Dict?) ?? {}),
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
