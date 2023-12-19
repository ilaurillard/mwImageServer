import 'package:collection/collection.dart';
import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Datasource.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math_64.dart';

import 'Widget.dart';

class Util {
  static pw.DecorationGraphic? decorationGraphic(
    Dict json,
    State state,
  ) {
    if (json.isEmpty) {
      return null;
    }

    Datasource source = state.source(
      json['source'] as String?,
    );

    if (source.isSvg()) {
      return pw.DecorationSvgImage(
        svg: source.svgFromBinary(),
        fit: Util.boxFit(json['fit'] as String?) ?? pw.BoxFit.cover,
        alignment:
            Util.alignment(json['alignment'] as String?) ?? pw.Alignment.center,
      );
    } else {
      return pw.DecorationImage(
        image: source.imageFromBinary(),
        fit: Util.boxFit(json['fit'] as String?) ?? pw.BoxFit.cover,
        alignment:
            Util.alignment(json['alignment'] as String?) ?? pw.Alignment.center,
        dpi: double.tryParse(json['dpi'].toString()),
      );
    }
  }

  static pw.BoxDecoration? boxDecoration(
    Dict json,
    State state,
  ) {
    if (json.isEmpty) {
      return null;
    }
    List<dynamic> bs = json['boxShadow'] as List<dynamic>? ?? [];
    return pw.BoxDecoration(
      color: Util.color(json['color'] as String?),
      border: Util.boxBorder(
        json['border'] as Dict?,
      ),
      borderRadius: Util.borderRadius(
        json['borderRadius'] as List<dynamic>?,
      ),
      shape: Util.boxShape(json['shape'] as String?) ?? pw.BoxShape.rectangle,
      boxShadow: bs.map((e) => Util.boxShadow(e as Dict? ?? {})).toList(),
      gradient: Util.gradient(json['gradient'] as Dict? ?? {}),
      image: Util.decorationGraphic(
        json['image'] as Dict? ?? {},
        state,
      ),
    );
  }

  static pw.TextStyle? textStyle(
    Dict json,
    State state,
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
      color: Util.color(json['color'] as String?),
      font: Util.font(
        json['font'] as String?,
        state,
      ),
      fontNormal: Util.font(
        json['fontNormal'] as String?,
        state,
      ),
      fontBold: Util.font(
        json['fontBold'] as String?,
        state,
      ),
      fontItalic: Util.font(
        json['fontItalic'] as String?,
        state,
      ),
      fontBoldItalic: Util.font(
        json['fontBoldItalic'] as String?,
        state,
      ),
      fontSize: fontSize != null ? fontSize * PdfPageFormat.mm : null,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      letterSpacing: double.tryParse(json['letterSpacing'].toString()),
      wordSpacing: double.tryParse(json['wordSpacing'].toString()),
      lineSpacing: double.tryParse(json['lineSpacing'].toString()),
      height: double.tryParse(json['height'].toString()),
      background: Util.boxDecoration(
        json['background'] as Dict? ?? {},
        state,
      ),
      decoration: Util.textDecoration(json['decoration'] as String?),
      decorationColor: Util.color(json['decorationColor'] as String?),
      decorationStyle: decStyle,
      decorationThickness:
          double.tryParse(json['decorationThickness'].toString()),
      renderingMode: renderingMode,
    );
  }

  static pw.Font? font(
    String? json,
    State state,
  ) {
    // print('Font: $json');

    if (json != null && json.isNotEmpty) {
      if (State.fonts[json] != null) {
        return State.fonts[json];
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

  static pw.BoxShadow boxShadow(
    Dict json,
  ) {
    return pw.BoxShadow(
      color: Util.color(json['color'] as String?) ?? PdfColors.black,
      offset: Util.pdfPoint(json['offset'] as List<dynamic>? ?? []) ??
          PdfPoint.zero,
      blurRadius: double.tryParse(json['blurRadius'].toString()) ?? 0.0,
      spreadRadius: double.tryParse(json['spreadRadius'].toString()) ?? 0.0,
    );
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

  static PdfPoint? pdfPoint(
    List<dynamic>? json,
  ) {
    if (json != null && json.isNotEmpty) {
      double x = double.tryParse(json.first.toString()) ?? 0.0;
      double y = 0.0;
      if (json.length > 1) {
        y = double.tryParse(json[1].toString()) ?? 0.0;
      }
      return PdfPoint(
        x * PdfPageFormat.mm,
        y * PdfPageFormat.mm,
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

  static pw.TileMode? tileMode(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'clamp':
          return pw.TileMode.clamp;
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
          // allow "double,double"
          List<String> segments = json.split(',');
          if (segments.length == 2) {
            double? x = double.tryParse(segments[0]);
            double? y = double.tryParse(segments[1]);
            return pw.Alignment(x ?? 1, y ?? 1);
          }
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

  static String replaceParameters(
    String text,
    State state,
  ) {
    // for (String key in Widget.parameters.keys) {
    //   text = text.replaceAll('%$key%', Widget.parameters[key] ?? '');
    // }
    return text
        .replaceAll('%value%', state.value)
        .replaceAll('%pageNumber%', state.pageNumber.toString())
        .replaceAll('%pagesCount%', state.pagesCount.toString());
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
          Util.borderSide(json['all'] as Dict?) ?? pw.BorderSide.none;
      return pw.Border(
        top: Util.borderSide(json['top'] as Dict?) ?? fb,
        right: Util.borderSide(json['right'] as Dict?) ?? fb,
        bottom: Util.borderSide(json['bottom'] as Dict?) ?? fb,
        left: Util.borderSide(json['left'] as Dict?) ?? fb,
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
        color: Util.color(
              json['color'] as String?,
            ) ??
            PdfColors.black,
        style: Util.borderStyle(
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
        maxWidth:
            maxWidth != null ? maxWidth * PdfPageFormat.mm : double.infinity,
        maxHeight:
            maxHeight != null ? maxHeight * PdfPageFormat.mm : double.infinity,
      );
    }
    return null;
  }

  static pw.Widget switchCases(
    Dict json,
    State state,
  ) {
    String subject = json['subject'] as String? ?? '';
    String value = replaceParameters(
      subject,
      state,
    );

    Dict cases = (json['cases'] as Dict? ?? {});
    if (cases[value] != null) {
      return Widget.parse(
        cases[value] as Dict? ?? {},
        state,
      );
    }

    return Widget.parse(
      json['default'] as Dict? ?? {},
      state,
    );
  }

  static pw.Gradient? gradient(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      // print(json);

      MapEntry<String, dynamic> widget = json.entries.first;
      String key = widget.key;
      Dict data = widget.value as Dict;

      List<PdfColor> colors = (data['colors'] as List<dynamic>)
          .map((e) => Util.color(e as String?) ?? PdfColors.black)
          .toList();

      List<double>? stops = data['stops'] != null
          ? (data['stops'] as List<dynamic>)
              .map((e) => double.tryParse(e.toString()) ?? 0.0)
              .toList()
          : null;

      switch (key) {
        case 'LinearGradient':
          return pw.LinearGradient(
            colors: colors,
            stops: stops,
            begin: Util.alignment(data['begin'] as String?) ??
                pw.Alignment.centerLeft,
            end: Util.alignment(data['end'] as String?) ??
                pw.Alignment.centerRight,
            tileMode:
                Util.tileMode(data['tileMode'] as String?) ?? pw.TileMode.clamp,
          );
        case 'RadialGradient':
          double? radius = double.tryParse(data['radius'].toString());
          double? focalRadius = double.tryParse(data['focalRadius'].toString());

          return pw.RadialGradient(
              colors: colors,
              stops: stops,
              center: Util.alignment(data['center'] as String?) ??
                  pw.Alignment.center,
              radius: radius ?? 0.5,
              tileMode: Util.tileMode(data['tileMode'] as String?) ??
                  pw.TileMode.clamp,
              focalRadius: focalRadius ?? 0.0,
              focal: Util.alignment(data['center'] as String?));
      }
      throw Exception('Parsing gradient failed');
    }
    return null;
  }

  static Matrix4? transform(
    Dict json,
  ) {
    if (json.isNotEmpty) {
      MapEntry<String, dynamic> widget = json.entries.first;
      String key = widget.key;
      Dict data = widget.value as Dict;

      Matrix4 matrix = Matrix4.identity();
      switch (key) {
        case 'RotateZ':
          double? angle = double.tryParse(data['angle'].toString());
          matrix.multiply(
            Matrix4.rotationZ(
              radians(angle ?? 0.0),
            ),
          );
          return matrix;
        case 'Scale':
          double? scale = double.tryParse(data['scale'].toString());
          matrix.multiply(
            Matrix4.diagonal3Values(
              scale ?? 0,
              scale ?? 0,
              0,
            ),
          );
          return matrix;
        case 'Translate':
          PdfPoint p = Util.pdfPoint(data['offset'] as List<dynamic>? ?? []) ??
              PdfPoint.zero;
          matrix.multiply(
            Matrix4.translationValues(
              p.x,
              p.y,
              0,
            ),
          );

          return matrix;
      }
    }
    return null;
  }
}