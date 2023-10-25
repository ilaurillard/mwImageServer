import 'package:mwcdn/Etc/Types.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Annotation {
  static pw.UrlLink urlLink(
    Dict json,
  ) {
    return pw.UrlLink(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(json),
    );
  }

  // link to anchor --->
  static pw.Link link(
    Dict json,
  ) {
    return pw.Link(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(json),
    );
  }

  static pw.Anchor anchor(
    Dict json,
  ) {
    return pw.Anchor(
      name: json['name'] as String? ?? '?',
      child: Widget.child(json),
      description: json['description'] as String? ?? '?',
      zoom: double.tryParse(json['zoom'].toString()),
      setX: json['setX'] as bool? ?? false,
    );
  }
}
