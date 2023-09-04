import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfWidgetEnums {
  static pw.MainAxisAlignment parseMainAxisAlignment(
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

  static pw.CrossAxisAlignment parseCrossAxisAlignment(
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

  static pw.MainAxisSize parseMainAxisSize(
    String? json,
  ) {
    switch (json) {
      case 'min':
        return pw.MainAxisSize.min;
    }
    return pw.MainAxisSize.max;
  }

  static pw.VerticalDirection parseVerticalDirection(
    String? json,
  ) {
    switch (json) {
      case 'up':
        return pw.VerticalDirection.up;
    }
    return pw.VerticalDirection.down;
  }

  static PdfColor? parseColor(
    String? json,
  ) {
    // TODO ???
    if (json != null && json != '') {
      // return PdfColor(0.5, 0.5, 0.5, 0.5);
      return PdfColor.fromInt(int.parse(json, radix: 16));
    }
    return null;
  }

  static pw.EdgeInsets? parseEdgeInsets(
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

  static pw.Alignment? parseAlignment(
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

  static pw.TextAlign parseTextAlign(
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
      }
    }
    return pw.TextAlign.justify;
  }

  static pw.Axis parseAxis(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'vertical':
          return pw.Axis.vertical;
      }
    }
    return pw.Axis.horizontal;
  }

  static pw.FlexFit parseFlexFit(
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

  static pw.BorderStyle parseBorderStyle(
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

  static pw.WrapAlignment parseWrapAlignment(
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

  static pw.WrapCrossAlignment parseWrapCrossAlignment(
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

  static pw.TableWidth parseTableWidth(
    String? json,
  ) {
    if (json != null && json != '') {
      switch (json) {
        case 'min':
          return pw.TableWidth.min;
      }
    }
    return pw.TableWidth.max;
  }
}
