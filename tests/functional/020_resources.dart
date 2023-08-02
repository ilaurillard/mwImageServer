import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/UtilTest.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token98 = '';

  String resourceId1 = '';
  String resourceUrl1 = '';

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

  test('Admin 98 creates a private resource', () async {
    http.Response r = await http.post(
      Uri.parse('${host}api/bucket/98/resource'),
      headers: {
        'Authorization': token98,
        'Content-Type': UtilTest.uploadContentType,
      },
      body: UtilTest.upload(
        await File('tests/functional/files/ffff23.jpg').readAsBytes(),
        {
          'users': [6]
        },
        'image/jpeg',
        'ffff23.jpg',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;
    expect(data['public'], equals(false));
    expect(data['users'], equals([6]));
    expect(data['filename'], equals('ffff23.jpg'));
    resourceId1 = data['id'] as String;
    resourceUrl1 =
        '$host${data['path'] as String}/${data['filename'] as String}';
  });

  test('Admin 98 changes resource meta', () async {
    http.Response r = await http.post(
      Uri.parse('${host}api/bucket/98/resource/$resourceId1'),
      headers: {'Authorization': token98},
      body: json.encode({'users': [7], 'groups': [2]}),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;
    expect(data['public'], equals(false));
    expect(data['users'], equals([7]));
    expect(data['groups'], equals([2]));
  });
}
