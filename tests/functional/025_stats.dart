import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/UtilTest.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token98 = '';

  test(
    'Root creates a bucket',
        () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({'id': 98, 'name': 'Hmm'}),
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Root creates admin token for bucket (98)',
        () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/token'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({
          'buckets': [98]
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      token98 = data['id'] as String;
    },
  );

  test(
    'Root accesses bucket stats',
        () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/98/stats'),
        headers: {'Authorization': rootKey},
      );
      expect(r.statusCode, equals(200));
      // Dict data = json.decode(r.body) as Dict;
      // print(data);
    },
  );

  test(
    'Admin 98 accesses bucket stats',
        () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/98/stats'),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Root accesses all stats',
        () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/stats'),
        headers: {'Authorization': rootKey},
      );
      expect(r.statusCode, equals(200));
      // Dict data = json.decode(r.body) as Dict;
      // print(data);
    },
  );
}
