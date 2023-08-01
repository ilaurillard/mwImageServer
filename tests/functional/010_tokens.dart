import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token98 = '';
  String token99 = '';

  test(
    'Root creates admin token for bucket (98)',
        () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/token'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({
          'buckets': [98],
          'root': false,
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['root'], equals(false));
      token98 = data['id'] as String;
    },
  );

  test(
    'Root creates admin token for bucket (99)',
        () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/token'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({
          'buckets': [99]
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      token99 = data['id'] as String;
    },
  );

  test(
    'Admin 98 can access bucket (98)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/98'),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 99 can access bucket (99)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/99'),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 98 cannot access bucket (99)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/99'),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Admin 99 cannot access bucket (98)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/98'),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Root can access token (99)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/token/' + token99),
        headers: {'Authorization': rootKey},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 98 can access token (98)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/98/token/' + token98),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 99 can access token (99)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/99/token/' + token99),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 99 cannot access token (99)',
        () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/token/' + token99),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Root creates root token',
        () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/token'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({
          'buckets': [99],
          'root': true
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['root'], equals(true));
      expect(data['bucket'], equals(0));
      expect(data['buckets'], equals([]));
    },
  );

  test(
    'Root creates admin token',
        () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/bucket/99/token'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({
          'root': true,
          'buckets': [],
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['root'], equals(false));
      expect(data['bucket'], equals(99));
      expect(data['buckets'], equals([]));
    },
  );
}
