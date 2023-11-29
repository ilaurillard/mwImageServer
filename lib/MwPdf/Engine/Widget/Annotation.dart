import 'package:mwcdn/MwMs/Etc/Types.dart';
import 'package:mwcdn/MwPdf/Engine/Model/State.dart';
import 'package:pdf/widgets.dart' as pw;

import 'Widget.dart';

class Annotation {
  static pw.UrlLink urlLink(
    Dict json,
    State state,
  ) {
    return pw.UrlLink(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  // link to anchor --->
  static pw.Link link(
    Dict json,
    State state,
  ) {
    return pw.Link(
      destination: json['destination'] as String? ?? '?',
      child: Widget.child(
        json,
        state,
      ),
    );
  }

  static pw.Anchor anchor(
    Dict json,
    State state,
  ) {
    return pw.Anchor(
      name: json['name'] as String? ?? '?',
      child: Widget.child(
        json,
        state,
      ),
      description: json['description'] as String? ?? '?',
      zoom: double.tryParse(json['zoom'].toString()),
      setX: json['setX'] as bool? ?? false,
    );
  }
}
