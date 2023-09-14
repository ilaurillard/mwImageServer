import 'package:collection/collection.dart';
import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../Engine.dart';
import 'PdfWidget.dart';

class Etc {
  static pw.BoxDecoration? boxDecoration(
    Dict json,
  ) {
    if (json.isEmpty) {
      return null;
    }

    // TODO
    // boxShadow,
    // gradient,
    // image,

    return pw.BoxDecoration(
      color: Etc.color(json['color'] as String?),
      border: Etc.boxBorder(
        json['border'] as Dict?,
      ),
      borderRadius: Etc.borderRadius(
        json['borderRadius'] as List<dynamic>?,
      ),
      shape: Etc.boxShape(json['shape'] as String?) ??
          pw.BoxShape.rectangle,
    );
  }

  static pw.TextStyle? textStyle(
    Dict json,
  ) {
    if (json.isEmpty) {
      return null;
    }
    // print('TextStyle: $json');

    String fw = json['fontWeight'] as String? ?? '';
    pw.FontWeight? fontWeight =
        pw.FontWeight.values.firstWhereOrNull((e) => e.name == fw);

    String fs = json['fontStyle'] as String? ?? '';
    pw.FontStyle? fontStyle =
        pw.FontStyle.values.firstWhereOrNull((e) => e.name == fs);

    String ds = json['decorationStyle'] as String? ?? '';
    pw.TextDecorationStyle? decStyle =
        pw.TextDecorationStyle.values.firstWhereOrNull((e) => e.name == ds);

    String rm = json['renderingMode'] as String? ?? '';
    PdfTextRenderingMode? renderingMode =
        PdfTextRenderingMode.values.firstWhereOrNull((e) => e.name == rm);

    double? fontSize = double.tryParse(json['fontSize'].toString());

    return pw.TextStyle(
      color: Etc.color(json['color'] as String?),
      font: Etc.font(json['font'] as String?),
      fontNormal: Etc.font(json['fontNormal'] as String?),
      fontBold: Etc.font(json['fontBold'] as String?),
      fontItalic: Etc.font(json['fontItalic'] as String?),
      fontBoldItalic: Etc.font(json['fontBoldItalic'] as String?),
      fontSize: fontSize != null ? fontSize * PdfPageFormat.mm : null,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: double.tryParse(json['letterSpacing'].toString()),
      wordSpacing: double.tryParse(json['wordSpacing'].toString()),
      lineSpacing: double.tryParse(json['lineSpacing'].toString()),
      height: double.tryParse(json['height'].toString()),
      // TODO background
      background: null,
      decoration: Etc.textDecoration(json['decoration'] as String?),
      decorationColor: Etc.color(json['decorationColor'] as String?),
      decorationStyle: decStyle,
      decorationThickness:
          double.tryParse(json['decorationThickness'].toString()),
      renderingMode: renderingMode,
    );
  }

  static pw.Font? font(
    String? json,
  ) {
    // print('Font: $json');

    if (json != null && json.isNotEmpty) {
      if (Engine.res.fonts[json] != null) {
        return Engine.res.fonts[json];
      }

      // internal fonts
      switch (json) {
        case 'courier':
          return pw.Font.courier();
        case 'courierBold':
          return pw.Font.courierBold();
        case 'courierBoldOblique':
          return pw.Font.courierBoldOblique();
        case 'courierOblique':
          return pw.Font.courierOblique();
        case 'helvetica':
          return pw.Font.helvetica();
        case 'helveticaBold':
          return pw.Font.helveticaBold();
        case 'helveticaBoldOblique':
          return pw.Font.helveticaBoldOblique();
        case 'helveticaOblique':
          return pw.Font.helveticaOblique();
        case 'times':
          return pw.Font.times();
        case 'timesBold':
          return pw.Font.timesBold();
        case 'timesBoldItalic':
          return pw.Font.timesBoldItalic();
        case 'timesItalic':
          return pw.Font.timesItalic();
        case 'symbol':
          return pw.Font.symbol();
        case 'zapfDingbats':
          return pw.Font.zapfDingbats();
      }

      print('?? Unknown font: $json');
    }
    return null;
  }

  static PdfColor? color(
    String? json,
  ) {
    if (json != null && json != '') {
      json = json.padLeft(8, 'F');
      return PdfColor.fromInt(int.parse(json, radix: 16));
    }
    return null;
  }

  static pw.BoxShape? boxShape(
    String? json,
  ) {
    switch (json) {
      case 'circle':
        return pw.BoxShape.circle;
      case 'rectangle':
        return pw.BoxShape.rectangle;
    }
    return null;
  }

  static pw.MainAxisAlignment mainAxisAlignment(
    String? json,
  ) {
    switch (json) {
      case 'center':
        return pw.MainAxisAlignment.center;
      case 'end':
        return pw.MainAxisAlignment.end;
      case 'spaceBetween':
        return pw.MainAxisAlignment.spaceBetween;
      case 'spaceAround':
        return pw.MainAxisAlignment.spaceAround;
      case 'spaceEvenly':
        return pw.MainAxisAlignment.spaceEvenly;
    }
    return pw.MainAxisAlignment.start;
  }

  static pw.CrossAxisAlignment crossAxisAlignment(
    String? json,
  ) {
    switch (json) {
      case 'start':
        return pw.CrossAxisAlignment.start;
      case 'end':
        return pw.CrossAxisAlignment.end;
      case 'stretch':
        return pw.CrossAxisAlignment.stretch;
    }
    return pw.CrossAxisAlignment.center;
  }

  static pw.MainAxisSize mainAxisSize(
    String? json,
  ) {
    switch (json) {
      case 'min':
        return pw.MainAxisSize.min;
    }
    return pw.MainAxisSize.max;
  }

  static pw.VerticalDirection verticalDirection(
    String? json,
  ) {
    switch (json) {
      case 'up':
        return pw.VerticalDirection.up;
    }
    return pw.VerticalDirection.down;
  }

  static pw.BorderRadius? borderRadius(
    List<dynamic>? json,
  ) {
    if (json != null && json.isNotEmpty) {
      double l = double.tryParse(json.first.toString()) ?? 0;
      double t = l;
      double r = l;
      double b = l;
      if (json.length > 1) {
        t = double.tryParse(json[1].toString()) ?? 0;
        b = t;
      }
      if (json.length > 3) {
        r = double.tryParse(json[2].toString()) ?? 0;
        b = double.tryParse(json[3].toString()) ?? 0;
      }

      return pw.BorderRadius.only(
        topLeft: pw.Radius.circular(l * PdfPageFormat.mm),
        topRight: pw.Radius.circular(t * PdfPageFormat.mm),
        bottomLeft: pw.Radius.circular(r * PdfPageFormat.mm),
        bottomRight: pw.Radius.circular(b * PdfPageFormat.mm),
      );
    }
    return null;
  }

  static pw.EdgeInsets? edgeInsets(
    List<dynamic>? json,
  ) {
    if (json != null && json.isNotEmpty) {
      double l = double.tryParse(json.first.toString()) ?? 0;
      double t = l;
      double r = l;
      double b = l;
      if (json.length > 1) {
        t = double.tryParse(json[1].toString()) ?? 0;
        b = t;
      }
      if (json.length > 3) {
        r = double.tryParse(json[2].toString()) ?? 0;
        b = double.tryParse(json[3].toString()) ?? 0;
      }

      return pw.EdgeInsets.fromLTRB(
        l * PdfPageFormat.mm,
        t * PdfPageFormat.mm,
        r * PdfPageFormat.mm,
        b * PdfPageFormat.mm,
      );
    }
    return null;
  }

  static pw.BoxFit? boxFit(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'contain':
          return pw.BoxFit.contain;
        case 'fill':
          return pw.BoxFit.fill;
        case 'cover':
          return pw.BoxFit.cover;
        case 'fitWidth':
          return pw.BoxFit.fitWidth;
        case 'fitHeight':
          return pw.BoxFit.fitHeight;
        case 'none':
          return pw.BoxFit.none;
        case 'scaleDown':
          return pw.BoxFit.scaleDown;
      }
    }
    return null;
  }

  static pw.Alignment? alignment(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'center':
          return pw.Alignment.center;
        case 'topLeft':
          return pw.Alignment.topLeft;
        case 'topCenter':
          return pw.Alignment.topCenter;
        case 'topRight':
          return pw.Alignment.topRight;
        case 'centerRight':
          return pw.Alignment.centerRight;
        case 'bottomLeft':
          return pw.Alignment.bottomLeft;
        case 'bottomCenter':
          return pw.Alignment.bottomCenter;
        case 'bottomRight':
          return pw.Alignment.bottomRight;
        case 'centerLeft':
          return pw.Alignment.centerLeft;
        default:
          // TODO allow "double,double"
          return pw.Alignment(1, 1);
      }
    }
    return null;
  }

  static pw.TextAlign? textAlign(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'center':
          return pw.TextAlign.center;
        case 'left':
          return pw.TextAlign.left;
        case 'right':
          return pw.TextAlign.right;
        case 'justify':
          return pw.TextAlign.justify;
      }
    }
    return null;
  }

  static pw.TextDirection? textDirection(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'ltr':
          return pw.TextDirection.ltr;
        case 'rtl':
          return pw.TextDirection.rtl;
      }
    }
    return null;
  }

  static pw.Axis? axis(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'vertical':
          return pw.Axis.vertical;
        case 'horizontal':
          return pw.Axis.horizontal;
      }
    }
    return null;
  }

  static pw.FlexFit flexFit(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'loose':
          return pw.FlexFit.loose;
      }
    }
    return pw.FlexFit.tight;
  }

  static pw.BorderStyle borderStyle(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'none':
          return pw.BorderStyle.none;
        case 'dashed':
          return pw.BorderStyle.dashed;
        case 'dotted':
          return pw.BorderStyle.dotted;
      }
    }
    return pw.BorderStyle.solid;
  }

  static pw.WrapAlignment wrapAlignment(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'end':
          return pw.WrapAlignment.end;
        case 'center':
          return pw.WrapAlignment.center;
        case 'spaceBetween':
          return pw.WrapAlignment.spaceBetween;
        case 'spaceAround':
          return pw.WrapAlignment.spaceAround;
        case 'spaceEvenly':
          return pw.WrapAlignment.spaceEvenly;
      }
    }
    return pw.WrapAlignment.start;
  }

  static pw.TextOverflow? textOverflow(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'clip':
          return pw.TextOverflow.clip;
        case 'visible':
          return pw.TextOverflow.visible;
        case 'span':
          return pw.TextOverflow.span;
      }
    }
    return null;
  }

  static pw.WrapCrossAlignment wrapCrossAlignment(
    String? json,
  ) {
    switch (json) {
      case 'center':
        return pw.WrapCrossAlignment.center;
      case 'end':
        return pw.WrapCrossAlignment.end;
    }
    return pw.WrapCrossAlignment.start;
  }

  static pw.StackFit? stackFit(
      String? json,
      ) {
    switch (json) {
      case 'loose':
        return pw.StackFit.loose;
      case 'expand':
        return pw.StackFit.expand;
      case 'passthrough':
        return pw.StackFit.passthrough;
    }
    return null;
  }

  static pw.Overflow? overflow(
      String? json,
      ) {
    switch (json) {
      case 'clip':
        return pw.Overflow.clip;
      case 'visible':
        return pw.Overflow.visible;
    }
    return null;
  }

  static pw.DecorationPosition decorationPosition(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'foreground':
          return pw.DecorationPosition.foreground;
      }
    }
    return pw.DecorationPosition.background;
  }

  static String parameters(
    String text,
  ) {
    return text
        .replaceAll('%pageNumber%', PdfWidget.pageNumber.toString())
        .replaceAll('%pagesCount%', PdfWidget.pagesCount.toString());
  }

  // text decoration is broken .. ?
  static pw.TextDecoration? textDecoration(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'none':
          return pw.TextDecoration.none;
        case 'underline':
          return pw.TextDecoration.underline;
        case 'overline':
          return pw.TextDecoration.overline;
        case 'lineThrough':
          return pw.TextDecoration.lineThrough;
      }
    }
    return null;
  }

  static pw.Border? boxBorder(
    Dict? json,
  ) {
    if (json != null) {
      pw.BorderSide fb =
          Etc.borderSide(json['all'] as Dict?) ?? pw.BorderSide.none;
      return pw.Border(
        top: Etc.borderSide(json['top'] as Dict?) ?? fb,
        right: Etc.borderSide(json['right'] as Dict?) ?? fb,
        bottom: Etc.borderSide(json['bottom'] as Dict?) ?? fb,
        left: Etc.borderSide(json['left'] as Dict?) ?? fb,
      );
    }
    return null;
  }

  static pw.BorderSide? borderSide(
    Dict? json,
  ) {
    if (json != null) {
      double? width = double.tryParse(json['width'].toString());
      return pw.BorderSide(
        color: Etc.color(
              json['color'] as String?,
            ) ??
            PdfColors.black,
        style: Etc.borderStyle(
          json['style'] as String?,
        ),
        width: width != null ? width * PdfPageFormat.mm : 1.0,
      );
    }
    return null;
  }

  static pw.BoxConstraints? boxConstraints(
    Dict? json,
  ) {
    if (json != null && json.isNotEmpty) {
      double? minWidth = double.tryParse(json['minWidth'].toString());
      double? maxWidth = double.tryParse(json['maxWidth'].toString());
      double? minHeight = double.tryParse(json['minHeight'].toString());
      double? maxHeight = double.tryParse(json['maxHeight'].toString());
      return pw.BoxConstraints(
        minWidth: minWidth != null ? minWidth * PdfPageFormat.mm : 0.0,
        minHeight: minHeight != null ? minHeight * PdfPageFormat.mm : 0.0,
        maxWidth: maxWidth != null ? maxWidth * PdfPageFormat.mm : double.infinity,
        maxHeight: maxHeight != null ? maxHeight * PdfPageFormat.mm : double.infinity,
      );
    }
    return null;
  }
}
