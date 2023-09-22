import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math_64.dart';

import 'Etc.dart';
import 'Widget.dart';

class Basic {
  static pw.Center center(
    Dict json,
  ) {
    return pw.Center(
      child: Widget.child(json),
    );
  }

  static pw.Align align(
    Dict json,
  ) {
    double? widthFactor = double.tryParse(json['widthFactor'].toString());
    double? heightFactor = double.tryParse(json['heightFactor'].toString());
    return pw.Align(
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: Widget.child(json),
      widthFactor: widthFactor != null ? widthFactor * PdfPageFormat.mm : null,
      heightFactor:
          heightFactor != null ? heightFactor * PdfPageFormat.mm : null,
    );
  }

  static pw.FittedBox fittedBox(
    Dict json,
  ) {
    return pw.FittedBox(
      fit: Etc.boxFit(
            json['fit'] as String?,
          ) ??
          pw.BoxFit.contain,
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      child: Widget.child(json),
    );
  }

  static pw.SizedBox sizedBox(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? height = double.tryParse(json['height'].toString());

    return pw.SizedBox(
      width: width != null ? width * PdfPageFormat.mm : null,
      height: height != null ? height * PdfPageFormat.mm : null,
      child: Widget.child(json),
    );
  }

  static pw.LimitedBox limitedBox(
    Dict json,
  ) {
    double? maxWidth = double.tryParse(json['maxWidth'].toString());
    double? maxHeight = double.tryParse(json['maxHeight'].toString());
    return pw.LimitedBox(
      maxWidth:
          maxWidth != null ? maxWidth * PdfPageFormat.mm : double.infinity,
      maxHeight:
          maxHeight != null ? maxHeight * PdfPageFormat.mm : double.infinity,
      child: Widget.child(json),
    );
  }

  static pw.ConstrainedBox constrainedBox(
    Dict json,
  ) {
    return pw.ConstrainedBox(
      constraints: Etc.boxConstraints(
            json['constraints'] as Dict?,
          ) ??
          pw.BoxConstraints(),
      child: Widget.child(json),
    );
  }

  static pw.OverflowBox overflowBox(
    Dict json,
  ) {
    return pw.OverflowBox(
      alignment: Etc.alignment(
            json['alignment'] as String?,
          ) ??
          pw.Alignment.center,
      minWidth: double.tryParse(json['minWidth'].toString()),
      maxWidth: double.tryParse(json['maxWidth'].toString()),
      minHeight: double.tryParse(json['minHeight'].toString()),
      maxHeight: double.tryParse(json['maxHeight'].toString()),
      child: Widget.child(json),
    );
  }

  static pw.AspectRatio aspectRatio(
    Dict json,
  ) {
    return pw.AspectRatio(
      aspectRatio: double.tryParse(json['aspectRatio'].toString()) ?? 1,
      child: Widget.child(json),
    );
  }

  static pw.Opacity opacity(Dict json) {
    return pw.Opacity(
      opacity: double.tryParse(json['opacity'].toString()) ?? 1.0,
      child: Widget.child(json),
    );
  }

  static pw.Transform transform(
    Dict json,
  ) {
    // return pw.Transform.rotateBox(angle: radians(45), child: Widget.child(json));
    // print(json);
    return pw.Transform(
      origin: Etc.pdfPoint(json['origin'] as List<dynamic>?),
      adjustLayout: json['adjustLayout'] as bool? ?? false,
      unconstrained: json['unconstrained'] as bool? ?? false,
      alignment: Etc.alignment(json['alignment'] as String?),
      transform: Etc.transform(json['transform'] as Dict? ?? {}) ?? Matrix4.zero(),
      child: Widget.child(json),
    );
  }

  static pw.Divider divider(
    Dict json,
  ) {
    double? height = double.tryParse(json['height'].toString());
    double? thickness = double.tryParse(json['thickness'].toString());
    double? indent = double.tryParse(json['indent'].toString());
    double? endIndent = double.tryParse(json['endIndent'].toString());
    return pw.Divider(
      height: height != null ? height * PdfPageFormat.mm : null,
      thickness: thickness != null ? thickness * PdfPageFormat.mm : null,
      indent: indent != null ? indent * PdfPageFormat.mm : null,
      endIndent: endIndent != null ? endIndent * PdfPageFormat.mm : null,
      color: Etc.color(
        json['color'] as String?,
      ),
      borderStyle: Etc.borderStyle(
        json['borderStyle'] as String?,
      ),
    );
  }

  static pw.VerticalDivider verticalDivider(
    Dict json,
  ) {
    double? width = double.tryParse(json['width'].toString());
    double? thickness = double.tryParse(json['thickness'].toString());
    double? indent = double.tryParse(json['indent'].toString());
    double? endIndent = double.tryParse(json['endIndent'].toString());
    return pw.VerticalDivider(
      width: width != null ? width * PdfPageFormat.mm : null,
      thickness: thickness != null ? thickness * PdfPageFormat.mm : null,
      indent: indent != null ? indent * PdfPageFormat.mm : null,
      endIndent: endIndent != null ? endIndent * PdfPageFormat.mm : null,
      color: Etc.color(
        json['color'] as String?,
      ),
      borderStyle: Etc.borderStyle(
        json['borderStyle'] as String?,
      ),
    );
  }
}

