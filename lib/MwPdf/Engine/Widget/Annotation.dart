import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/Resources.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Annotation {
  static pw.UrlLink urlLink(
    Dict json,
    Resources resources,
  ) {
    return pw.UrlLink(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(
        json,
        resources,
      ),
    );
  }

  // link to anchor --->
  static pw.Link link(
    Dict json,
    Resources resources,
  ) {
    return pw.Link(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(
        json,
        resources,
      ),
    );
  }

  static pw.Anchor anchor(
    Dict json,
    Resources resources,
  ) {
    return pw.Anchor(
      name: json['name'] as String? ?? '?',
      child: Widget.child(
        json,
        resources,
      ),
      description: json['description'] as String? ?? '?',
      zoom: double.tryParse(json['zoom'].toString()),
      setX: json['setX'] as bool? ?? false,
    );
  }
}
