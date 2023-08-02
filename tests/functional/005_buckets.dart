import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token = '';

  test(
    'Root creates a bucket without key must fail',
    () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket'),
        body: jsonEncode({'id': 77, 'name': 'Henry'}),
      );
      expect(r.statusCode, equals(401));
    },
  );

  test(
    'Root creates a bucket',
    () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({'id': 98, 'name': 'TestBucketXXX'}),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['id'], equals(98));
      expect(data['name'], equals('TestBucketXXX'));
    },
  );

  test(
    'Root updates bucket (98)',
        () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({'id': 98, 'name': 'TestBucket98'}),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['id'], equals(98));
      expect(data['name'], equals('TestBucket98'));
    },
  );

  test(
    'Root can access bucket (98)',
    () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/98'),
        headers: {'Authorization': rootKey},
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['id'], equals(98));
      expect(data['name'], equals('TestBucket98'));
    },
  );

  test(
    'Root creates another bucket (99)',
    () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket'),
        headers: {'Authorization': rootKey},
        body: jsonEncode({'id': 99, 'name': 'TestBucket99'}),
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
      expect(data['buckets'], equals([98]));
      expect(data['bucket'], equals(98));
      expect(data['root'], equals(false));
      token = data['id'] as String;
      expect(token.length, equals(32));
    },
  );

  test(
    'Admin cannot access bucket (97)',
    () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/97'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Admin can access bucket (98)',
    () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/98'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['id'], equals(98));
      expect(data['name'], equals('TestBucket98'));
    },
  );

  test(
    'Admin can access bucket stats (98)',
        () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/98/stats'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['bucket']['id'], equals(98));
      expect(data['bucket']['name'], equals('TestBucket98'));
    },
  );

  test(
    'Admin cannot access bucket (99)',
    () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/99'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Admin cannot create buckets',
    () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Admin creates method (thumb2)',
        () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket/98/method'),
        headers: {'Authorization': token},
        body: jsonEncode({
          'name': 'thumb2',
          'tool': 'convert',
          'parameters': [
            '%source%',
            '-thumbnail',
            '30x30',
            '%target%'
          ]
        }),
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin creates another method (thumb3)',
        () async {
      http.Response r = await http.post(
        Uri.parse('${host}api/bucket/98/method'),
        headers: {'Authorization': token},
        body: jsonEncode({
          'name': 'thumb3',
          'tool': 'convert',
          'parameters': <String>[]
        }),
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin deletes method (thumb3)',
        () async {
      http.Response r = await http.delete(
        Uri.parse('${host}api/bucket/98/method/thumb3'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin can access bucket (98)',
        () async {
      http.Response r = await http.get(
        Uri.parse('${host}api/bucket/98'),
        headers: {'Authorization': token},
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['methods'].length, equals(1));
      expect(data['methods'][0]['name'], equals('thumb2'));
    },
  );


}
