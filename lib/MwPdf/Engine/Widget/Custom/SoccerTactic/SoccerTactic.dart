import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:vector_math/vector_math.dart';

class SoccerTactic {
  static pw.Widget build(
    Dict fieldJson,
    State state,
  ) {
    fieldJson = fieldPreset(fieldJson['field'] as Dict? ?? {});

    String rot = fieldJson['rotation'] as String? ?? 'east';
    int rotation = 0;
    switch (rot) {
      case 'east':
        rotation = 0;
        break;
      case 'west':
        rotation = 180;
        break;
      case 'north':
        rotation = 90;
        break;
      case 'south':
        rotation = -90;
        break;
    }

    double lineOpacity = 1.0;
    String lineColor = (fieldJson['color3'] as String? ?? 'CCFFFFFF');
    if (lineColor.length > 6) {
      lineOpacity = int.parse(lineColor.substring(0, 2), radix: 16) / 255.0;
    }
    lineColor = lineColor.substring(lineColor.length - 6);

    String col1 = (fieldJson['color1'] as String? ?? '66CC66');
    col1 = col1.substring(col1.length - 6);
    String col2 = (fieldJson['color2'] as String? ?? '77DD77');
    col2 = col2.substring(col2.length - 6);

    double marginLength =
        double.tryParse(fieldJson['marginLength'].toString()) ?? 5.0;
    double marginWidth =
        double.tryParse(fieldJson['marginWidth'].toString()) ?? 5.0;

    double length = double.tryParse(fieldJson['length'].toString()) ?? 105.0;
    double width = double.tryParse(fieldJson['width'].toString()) ?? 68.0;

    double lineWidth =
        double.tryParse(fieldJson['lineWidth'].toString()) ?? 0.12;

    int mowerLanes = int.tryParse(fieldJson['mowerLanes'].toString()) ?? 17;

    double centerLength = marginLength + (length / 2);
    double centerWidth = marginWidth + (width / 2);

    double lengthTotal = length + (2 * marginLength);
    double widthTotal = width + (2 * marginWidth);

    double lengthClip = lengthTotal;
    double clip = double.tryParse(fieldJson['clip'].toString()) ?? 0.0;
    if (clip > 0) {
      lengthClip = clip;
    }

    double cornerArc =
        double.tryParse(fieldJson['cornerArc'].toString()) ?? 1.0;

    double centerSpot =
        double.tryParse(fieldJson['centerSpot'].toString()) ?? 0.22;
    double centerCircleRadius =
        double.tryParse(fieldJson['centerCirle'].toString()) ?? 9.15;

    double penaltySpot =
        double.tryParse(fieldJson['penaltySpot'].toString()) ?? 0.22;
    double penaltyArc =
        double.tryParse(fieldJson['penaltyArc'].toString()) ?? 9.15;
    double penaltyLength =
        double.tryParse(fieldJson['penaltyLength'].toString()) ?? 11.0;
    double penaltyAreaWidth =
        double.tryParse(fieldJson['penaltyAreaWidth'].toString()) ?? 40.3;
    double penaltyAreaWidthHalf = penaltyAreaWidth / 2;
    double penaltyAreaLength =
        double.tryParse(fieldJson['penaltyAreaLength'].toString()) ?? 16.5;

    double goalAreaWidth =
        double.tryParse(fieldJson['goalAreaWidth'].toString()) ?? 18.32;
    double goalAreaWidthHalf = goalAreaWidth / 2;
    double goalAreaLength =
        double.tryParse(fieldJson['goalAreaLength'].toString()) ?? 5.5;

    double goalWidth =
        double.tryParse(fieldJson['goalWidth'].toString()) ?? 7.32;
    double goalWidthHalf = goalWidth / 2;
    double goalLength =
        double.tryParse(fieldJson['goalLength'].toString()) ?? 1.0;

    // --------------

    String mowerLanesSvg = '';
    double mowerLaneWidth = length / mowerLanes;
    double xml = marginLength;
    do {
      mowerLanesSvg +=
          '<rect x="$xml" y="$marginWidth" width="$mowerLaneWidth" height="$width" fill="#$col2" />';
      xml += mowerLaneWidth * 2;
    } while (xml < length + marginLength);

    String backgroundSvg =
        '<rect x="0" y="0" width="$lengthTotal" height="$widthTotal" fill="#$col1" />';

    String aussenLinienSvg =
        '<rect x="$marginLength" y="$marginWidth" width="$length" height="$width" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />';

    String mittelLinieSvg =
        '<line x1="$centerLength" y1="$marginWidth" x2="$centerLength" y2="${width + marginWidth}" stroke="$lineColor" stroke-width="$lineWidth" stroke-opacity="$lineOpacity" />';

    String mittelKreisSvg =
        '<circle fill="none" cx="$centerLength" cy="$centerWidth" r="$centerCircleRadius" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" />';

    String strafRaeumeSvg =
        '<path d="M $marginLength ${centerWidth - penaltyAreaWidthHalf} L ${penaltyAreaLength + marginLength} ${centerWidth - penaltyAreaWidthHalf} L ${penaltyAreaLength + marginLength} ${centerWidth + penaltyAreaWidthHalf} L $marginLength ${centerWidth + penaltyAreaWidthHalf}" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />'
        '<path d="M ${marginLength + length} ${centerWidth - penaltyAreaWidthHalf} L ${marginLength + length - penaltyAreaLength} ${centerWidth - penaltyAreaWidthHalf} L ${marginLength + length - penaltyAreaLength} ${centerWidth + penaltyAreaWidthHalf} L ${marginLength + length} ${centerWidth + penaltyAreaWidthHalf}" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />';

    String elferKreiseSvg =
        '<clipPath id="ek1Clip"><rect x="${penaltyAreaLength + marginLength}" y="0" width="${length - (2 * penaltyAreaLength)}" height="$widthTotal" /></clipPath>'
        '<circle cx="${penaltyLength + marginLength}" cy="$centerWidth" r="$penaltyArc" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" clip-path="url(#ek1Clip)" />'
        '<circle cx="${marginLength + length - penaltyLength}" cy="$centerWidth" r="$penaltyArc" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" clip-path="url(#ek1Clip)" />';

    String anstossPunktSvg =
        '<circle cx="$centerLength}" cy="$centerWidth" r="$centerSpot" stroke="none" fill-opacity="$lineOpacity" fill="$lineColor" />';

    String elferPunkteSvg =
        '<circle cx="${penaltyLength + marginLength}" cy="$centerWidth" r="$penaltySpot" stroke="none" fill-opacity="$lineOpacity" fill="$lineColor" />'
        '<circle cx="${marginLength + length - penaltyLength}" cy="$centerWidth" r="$penaltySpot" stroke="none" fill-opacity="$lineOpacity" fill="$lineColor" />';

    String eckenKreiseSvg = cornerArc > 0
        ? '<clipPath id="ek2Clip"><rect x="$marginLength" y="$marginWidth" width="$length" height="$width" /></clipPath>'
            '<circle cx="$marginLength" cy="$marginWidth" r="$cornerArc" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" clip-path="url(#ek2Clip)" />'
            '<circle cx="$marginLength" cy="${marginWidth + width}" r="$cornerArc" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" clip-path="url(#ek2Clip)" />'
            '<circle cx="${marginLength + length}" cy="$marginWidth" r="$cornerArc" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" clip-path="url(#ek2Clip)" />'
            '<circle cx="${marginLength + length}" cy="${marginWidth + width}" r="$cornerArc" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" clip-path="url(#ek2Clip)" />'
        : '';

    String torwartRaeumeSvg =
        '<path d="M $marginLength ${centerWidth - goalAreaWidthHalf} L ${goalAreaLength + marginLength} ${centerWidth - goalAreaWidthHalf} L ${goalAreaLength + marginLength} ${centerWidth + goalAreaWidthHalf} L $marginLength ${centerWidth + goalAreaWidthHalf}" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />'
        '<path d="M ${marginLength + length} ${centerWidth - goalAreaWidthHalf} L ${marginLength + length - goalAreaLength} ${centerWidth - goalAreaWidthHalf} L ${marginLength + length - goalAreaLength} ${centerWidth + goalAreaWidthHalf} L ${marginLength + length} ${centerWidth + goalAreaWidthHalf}" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />';

    String toreSvg = goalLength > 0
        ? '<path d="M $marginLength ${centerWidth - goalWidthHalf} L ${marginLength - goalLength} ${centerWidth - goalWidthHalf} L ${marginLength - goalLength} ${centerWidth + goalWidthHalf} L $marginLength ${centerWidth + goalWidthHalf}" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />'
            '<path d="M ${marginLength + length} ${centerWidth - goalWidthHalf} L ${marginLength + length + goalLength} ${centerWidth - goalWidthHalf} L ${marginLength + length + goalLength} ${centerWidth + goalWidthHalf} L ${marginLength + length} ${centerWidth + goalWidthHalf}" stroke="$lineColor" stroke-opacity="$lineOpacity" stroke-width="$lineWidth" fill="none" />'
        : '';

    // --------------

    pw.Widget field = pw.Container(
      color: PdfColors.amber,
      width: double.infinity,
      height: double.infinity,
      child: pw.FittedBox(
        fit: pw.BoxFit.contain,
        child: pw.Transform.rotateBox(
          angle: degrees2Radians * rotation,
          child: pw.SvgImage(
            svg: '<svg viewBox="0 0 $lengthClip $widthTotal" '
                'width="$lengthTotal" height="$widthTotal" '
                'xmlns="http://www.w3.org/2000/svg">'
                '$backgroundSvg'
                '$mowerLanesSvg'
                '$aussenLinienSvg'
                '$mittelLinieSvg'
                '$mittelKreisSvg'
                '$strafRaeumeSvg'
                '$elferKreiseSvg'
                '$anstossPunktSvg'
                '$elferPunkteSvg'
                '$eckenKreiseSvg'
                '$torwartRaeumeSvg'
                '$toreSvg'
                '</svg>',
          ),
        ),
      ),
    );

    return field;
  }

  static Dict fieldPreset(
    Dict json,
  ) {
    String preset = json['preset'] as String? ?? '11v11';
    Map<String, Dict> presets = {
      '11v11': {
        'marginLength': 5,
        'marginWidth': 5,
        'color1': '66CC66',
        'color2': '70D470',
        'color3': 'CCFFFFFF',
        'length': 105.0,
        'width': 68.0,
        'mowerLanes': 17,
        'lineWidth': 0.12,
        'goalWidth': 7.32,
        'goalLength': 1.0,
        'centerCirle': 9.15,
        'centerSpot': 0.22,
        'penaltyAreaWidth': 40.3,
        'penaltyAreaLength': 16.5,
        'goalAreaWidth': 18.32,
        'goalAreaLength': 5.5,
        'penaltyArc': 9.15,
        'penaltySpot': 0.22,
        'cornerArc': 1.0
      },
      '9v9': {
        // TODO
      },
    };

    return {...(presets[preset] ?? {}), ...json};
  }
}
