import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Util.dart';

class Shape {
  static pw.InkList inkList(
    Dict json,
  ) {
    double? strokeWidth = double.tryParse(json['strokeWidth'].toString());
    return pw.InkList(
      points: _pointsList(json['points'] as List<dynamic>? ?? []),
      strokeColor: Util.color(
        json['strokeColor'] as String?,
      ),
      strokeWidth: strokeWidth != null ? strokeWidth * PdfPageFormat.mm : 1.0,
    );
  }

  static pw.Circle circle(
    Dict json,
  ) {
    double? strokeWidth = double.tryParse(json['strokeWidth'].toString());
    return pw.Circle(
      fillColor: Util.color(
        json['fillColor'] as String?,
      ),
      strokeColor: Util.color(
        json['strokeColor'] as String?,
      ),
      strokeWidth: strokeWidth != null ? strokeWidth * PdfPageFormat.mm : 1.0,
    );
  }

  static pw.Rectangle rectangle(
    Dict json,
  ) {
    double? strokeWidth = double.tryParse(json['strokeWidth'].toString());
    return pw.Rectangle(
      fillColor: Util.color(
        json['fillColor'] as String?,
      ),
      strokeColor: Util.color(
        json['strokeColor'] as String?,
      ),
      strokeWidth: strokeWidth != null ? strokeWidth * PdfPageFormat.mm : 1.0,
    );
  }

  static pw.Polygon polygon(
    Dict json,
  ) {
    double? strokeWidth = double.tryParse(json['strokeWidth'].toString());
    return pw.Polygon(
      points: _points(json['points'] as List<dynamic>? ?? []),
      close: json['close'] as bool? ?? true,
      fillColor: Util.color(
        json['fillColor'] as String?,
      ),
      strokeColor: Util.color(
        json['strokeColor'] as String?,
      ),
      strokeWidth: strokeWidth != null ? strokeWidth * PdfPageFormat.mm : 1.0,
    );
  }

  static List<List<PdfPoint>> _pointsList(
      List<dynamic> pointsList,
      ) {
    return pointsList.map((dynamic e ) {
      return _points(e as List<dynamic>);
    }).toList();
  }

  static List<PdfPoint> _points(
    List<dynamic> pointsData,
  ) {
    return pointsData.map((dynamic e) {
      List<dynamic> p = e as List<dynamic>? ?? [];
      double p1 = 0;
      double p2 = 0;
      if (p.isNotEmpty) {
        p1 = double.tryParse(p[0].toString()) ?? 0;
      }
      if (p.length > 1) {
        p2 = double.tryParse(p[1].toString()) ?? 0;
      }
      return PdfPoint(
        p1 * PdfPageFormat.mm,
        p2 * PdfPageFormat.mm,
      );
    }).toList();
  }
}
