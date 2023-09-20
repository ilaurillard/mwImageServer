import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math.dart';

import '../Engine.dart';
import '../Model/Resource.dart';
import 'Etc.dart';
import 'Widget.dart';

class Chart {
  static pw.Chart chart(
    Dict json,
  ) {
    return pw.Chart(
      grid: chartGrid(json['grid'] as Dict? ?? {}),
      overlay: Widget.parse(json['overlay'] as Dict? ?? {}),
      title: Widget.parse(json['title'] as Dict? ?? {}),
      bottom: Widget.parse(json['bottom'] as Dict? ?? {}),
      left: Widget.parse(json['left'] as Dict? ?? {}),
      right: Widget.parse(json['right'] as Dict? ?? {}),
      datasets: datasets(
        json['datasets'] as List<dynamic>? ?? [],
      ),
    );
  }

  static pw.ChartGrid chartGrid(
    Dict json,
  ) {
    MapEntry<String, dynamic> widget = json.entries.first;

    String key = widget.key;
    Dict data = widget.value as Dict;

    // print('W: $key');

    switch (key) {
      case 'CartesianGrid':
        return cartesianGrid(data);
      case 'PieGrid':
        return pieGrid(data);
      case 'RadialGrid':
        return radialGrid(data);
    }

    throw Exception('Parsing chart grid failed');
  }

  static pw.CartesianGrid cartesianGrid(
    Dict json,
  ) {
    return pw.CartesianGrid(
      xAxis: gridAxis(json['xAxis'] as Dict? ?? {}),
      yAxis: gridAxis(json['yAxis'] as Dict? ?? {}),
    );
  }

  static pw.PieGrid pieGrid(
    Dict json,
  ) {
    double angle = double.tryParse(json['startAngle'].toString()) ?? 0.0;
    return pw.PieGrid(
      startAngle: radians(angle),
    );
  }

  // experimental
  static pw.RadialGrid radialGrid(
    Dict json,
  ) {
    return pw.RadialGrid();
  }

  static pw.GridAxis gridAxis(
    Dict json,
  ) {
    MapEntry<String, dynamic> widget = json.entries.first;
    String key = widget.key;
    Dict data = widget.value as Dict;
    // print('W: $key');
    switch (key) {
      case 'FixedAxis':
        return fixedAxis(data);
    }
    throw Exception('Parsing chart axis failed');
  }

  static pw.FixedAxis fixedAxis(
    Dict json,
  ) {
    // yAxis: pw.FixedAxis(
    //   [0, 1, 2, 3, 4, 5],
    //   ticks: true,
    // ),
    // xAxis: pw.FixedAxis.fromStrings(['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h']),

    // return pw.FixedAxis.fromStrings(['a','b', 'c','d', 'e','f', 'g']);

    // TODO values, numbers, strings
    // automatic axis from datasets?

    double? width = double.tryParse(json['width'].toString());
    double? margin = double.tryParse(json['margin'].toString());
    double? marginStart = double.tryParse(json['marginStart'].toString());
    double? marginEnd = double.tryParse(json['marginEnd'].toString());
    double? divisionsWidth = double.tryParse(json['divisionsWidth'].toString());
    double angle = double.tryParse(json['angle'].toString()) ?? 0.0;
    return pw.FixedAxis(
      [0, 1, 2, 3, 4, 5, 6],
      margin: margin != null ? margin * PdfPageFormat.mm : null,
      marginStart: marginStart != null ? marginStart * PdfPageFormat.mm : null,
      marginEnd: marginEnd != null ? marginEnd * PdfPageFormat.mm : null,
      divisionsWidth:
          divisionsWidth != null ? divisionsWidth * PdfPageFormat.mm : null,
      width: width != null ? width * PdfPageFormat.mm : null,
      angle: radians(angle),
      ticks: json['ticks'] as bool?,
      divisions: json['divisions'] as bool?,
      axisTick: json['axisTick'] as bool?,
      divisionsDashed: json['divisionsDashed'] as bool?,
      color: Etc.color(json['color'] as String?),
      textStyle: Etc.textStyle(json['textStyle'] as Dict? ?? {}),
    );
  }

  static pw.ChartLegend chartLegend(
    Dict json,
  ) {
    return pw.ChartLegend(
      textStyle: Etc.textStyle(json['textStyle'] as Dict? ?? {}),
      position: Etc.alignment(
            json['position'] as String?,
          ) ??
          pw.Alignment.topRight,
      direction: Etc.axis(json['direction'] as String?) ?? pw.Axis.vertical,
      padding: Etc.edgeInsets(
            json['padding'] as List<dynamic>?,
          ) ??
          pw.EdgeInsets.all(5),
      decoration: Etc.boxDecoration(
        (json['decoration'] as Dict?) ?? {},
      ),
    );
  }

  static List<pw.Dataset> datasets(
    List<dynamic> json,
  ) {
    List<pw.Dataset> dataSets = [];

    for (dynamic temp in json) {
      MapEntry<String, dynamic> temp2 = (temp as Dict? ?? {}).entries.first;
      String key = temp2.key;
      Dict data = temp2.value as Dict;

      switch (key) {
        case 'BarDataSet':
          dataSets.add(
            barDataSet(data),
          );
          break;
        case 'LineDataSet':
          dataSets.add(
            lineDataSet(data),
          );
          break;
        case 'PieDataSet':
          Resource resource = Engine.resources.get(data['resource'] as String?);

          if (resource.data.isNotEmpty) {
            for (Map<String, dynamic> i in resource.data) {
              data['value'] = double.tryParse(i['value'].toString()) ?? 0;
              data['color'] = i['color'] as String?;
              data['legend'] = i['legend'] as String?;
              dataSets.add(
                pieDataSet(data),
              );
            }
          } else {
            dataSets.add(
              pieDataSet(data),
            );
          }

          break;

        default:
          print('Unknown dataset "$key"');
          break;
      }
    }

    return dataSets;
  }

  static pw.BarDataSet barDataSet(
    Dict json,
  ) {
    Resource resource = Engine.resources.get(json['resource'] as String?);
    double? surfaceOpacity = double.tryParse(json['surfaceOpacity'].toString());
    double? width = double.tryParse(json['width'].toString());
    double? offset = double.tryParse(json['offset'].toString());
    double? pointSize = double.tryParse(json['pointSize'].toString());
    return pw.BarDataSet(
      width: width != null ? width * PdfPageFormat.mm : 10,
      offset: offset != null ? offset * PdfPageFormat.mm : 0,
      surfaceOpacity: surfaceOpacity ?? 1,
      drawSurface: json['drawSurface'] as bool? ?? true,
      drawBorder: json['drawBorder'] as bool?,
      drawPoints: json['drawPoints'] as bool? ?? false,
      color: Etc.color(json['color'] as String?) ?? PdfColors.blue,
      legend: json['legend'] as String?,
      borderColor: Etc.color(json['borderColor'] as String?),
      pointColor: Etc.color(json['pointColor'] as String?),
      axis: Etc.axis(json['axis'] as String?) ?? pw.Axis.horizontal,
      pointSize: pointSize != null ? pointSize * PdfPageFormat.mm : 3,
      valuePosition: valuePosition(json['valuePosition'] as String?) ??
          pw.ValuePosition.auto,
      data: List<pw.PointChartValue>.generate(
        resource.values.length,
        (int index) {
          final double value =
              double.tryParse((resource.values[index][0]).toString()) ?? 0.0;
          return pw.PointChartValue(
            index.toDouble(),
            value,
          );
        },
      ),
    );
  }

  static pw.PieDataSet pieDataSet(
    Dict json,
  ) {
    double? offset = double.tryParse(json['offset'].toString());
    double? borderWidth = double.tryParse(json['borderWidth'].toString());
    double? surfaceOpacity = double.tryParse(json['surfaceOpacity'].toString());
    double? value = double.tryParse(json['value'].toString());
    double? legendOffset = double.tryParse(json['legendOffset'].toString());
    double? innerRadius = double.tryParse(json['innerRadius'].toString());
    double? legendLineWidth =
        double.tryParse(json['legendLineWidth'].toString());
    return pw.PieDataSet(
      value: value ?? 0,
      color: Etc.color(json['color'] as String?) ?? PdfColors.amber,
      legend: json['legend'] as String?,
      borderColor: Etc.color(json['borderColor'] as String?) ?? PdfColors.white,
      borderWidth: borderWidth != null ? borderWidth * PdfPageFormat.mm : 1.5,
      drawBorder: json['drawBorder'] as bool?,
      drawSurface: json['drawSurface'] as bool? ?? true,
      surfaceOpacity: surfaceOpacity ?? 1,
      offset: offset != null ? offset * PdfPageFormat.mm : 0,
      legendStyle: Etc.textStyle((json['legendStyle'] as Dict?) ?? {}),
      legendAlign: Etc.textAlign(json['legendAlign'] as String?),
      legendPosition: pieLegendPosition(json['legendPosition'] as String?) ??
          pw.PieLegendPosition.auto,
      legendLineWidth:
          legendLineWidth != null ? legendLineWidth * PdfPageFormat.mm : 1.0,
      legendLineColor: Etc.color(json['legendLineColor'] as String?),
      legendWidget: json['legendWidget'] != null
          ? Widget.parse(json['legendWidget'] as Dict? ?? {})
          : null,
      legendOffset: legendOffset != null ? legendOffset * PdfPageFormat.mm : 20,
      innerRadius: innerRadius != null ? innerRadius * PdfPageFormat.mm : 0,
    );
  }

  static pw.LineDataSet lineDataSet(
    Dict json,
  ) {
    Resource resource = Engine.resources.get(json['resource'] as String?);
    double? smoothness = double.tryParse(json['smoothness'].toString());
    double? pointSize = double.tryParse(json['pointSize'].toString());
    double? lineWidth = double.tryParse(json['lineWidth'].toString());
    double? surfaceOpacity = double.tryParse(json['surfaceOpacity'].toString());
    return pw.LineDataSet(
      legend: json['legend'] as String?,
      color: Etc.color(json['color'] as String?) ?? PdfColors.blue,
      pointColor: Etc.color(json['pointColor'] as String?),
      pointSize: pointSize != null ? pointSize * PdfPageFormat.mm : 3,
      lineWidth: lineWidth != null ? lineWidth * PdfPageFormat.mm : 2,
      drawLine: json['drawLine'] as bool? ?? true,
      lineColor: Etc.color(json['lineColor'] as String?),
      drawPoints: json['drawPoints'] as bool? ?? true,
      valuePosition: valuePosition(json['valuePosition'] as String?) ??
          pw.ValuePosition.auto,
      drawSurface: json['drawSurface'] as bool? ?? false,
      surfaceOpacity: surfaceOpacity ?? .2,
      surfaceColor: Etc.color(json['surfaceColor'] as String?),
      isCurved: json['isCurved'] as bool? ?? false,
      smoothness: smoothness ?? 0.35,
      data: List<pw.PointChartValue>.generate(
        resource.values.length,
        (int index) {
          final double value =
              double.tryParse((resource.values[index][0]).toString()) ?? 0.0;
          return pw.PointChartValue(
            index.toDouble(),
            value,
          );
        },
      ),
    );
  }

  static pw.ValuePosition? valuePosition(
    String? json,
  ) {
    switch (json) {
      case 'left':
        return pw.ValuePosition.left;
      case 'top':
        return pw.ValuePosition.top;
      case 'right':
        return pw.ValuePosition.right;
      case 'bottom':
        return pw.ValuePosition.bottom;
      case 'auto':
        return pw.ValuePosition.auto;
    }
    return null;
  }

  static pw.PieLegendPosition? pieLegendPosition(
    String? json,
  ) {
    switch (json) {
      case 'left':
        return pw.PieLegendPosition.none;
      case 'auto':
        return pw.PieLegendPosition.auto;
      case 'inside':
        return pw.PieLegendPosition.inside;
      case 'outside':
        return pw.PieLegendPosition.outside;
    }
    return null;
  }
}
