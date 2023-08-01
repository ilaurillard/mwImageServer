import 'package:http/http.dart' as http;
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  test(
    'Calling /xxx results in a 404',
    () async {
      http.Response r = await http.get(
        Uri.parse(host + '/xxx'),
      );
      expect(r.statusCode, equals(404));
    },
  );

  test(
    'Calling /static/help.html results in a 200',
    () async {
      http.Response r = await http.get(
        Uri.parse(host + '/static/help.html'),
      );
      expect(r.statusCode, equals(200));
    },
  );
}
