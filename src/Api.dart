import 'dart:isolate';

import 'package:shelf/shelf.dart';

class Api {
  Handler create() {
    return (
      Request request,
    ) {
      return Response.ok(
        "API - (isolate ${Isolate.current.hashCode})",
      );
    };
  }
}
