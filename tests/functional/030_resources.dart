import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/UtilTest.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token98 = '';

  String token888 = '';

  String resourceId1 = '';
  String resourcePath1 = '';
  String resourceFilename1 = '';

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

  test('Admin 98 creates token for user 888', () async {
    http.Response r = await http.post(Uri.parse('${host}api/bucket/98/token'),
        headers: {
          'Authorization': token98,
        },
        body: json.encode({
          'users': [888]
        }));
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;
    token888 = data['id'] as String;
  });

  test('Admin 98 creates a public resource', () async {
    http.Response r = await http.post(
      Uri.parse('${host}api/bucket/98/resource'),
      headers: {
        'Authorization': token98,
        'Content-Type': UtilTest.uploadContentType,
      },
      body: UtilTest.upload(
        await File('tests/functional/files/ffff23.jpg').readAsBytes(),
        {},
        'image/jpeg',
        'ffff23.jpg',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;
    expect(data['public'], equals(true));
    expect(data['filename'], equals('ffff23.jpg'));
    resourceId1 = data['id'] as String;
    resourcePath1 =
        data['path'] as String;
    resourceFilename1 = data['filename'] as String;
  });

  test('User 888 can access resource', () async {
    http.Response r = await http.get(
      Uri.parse('$host$resourcePath1/$resourceFilename1'),
      headers: {'Authorization': token888},
    );
    expect(r.statusCode, equals(200));
    expect(r.contentLength, equals(46975));
  });

  test('User 888 can access default thumbnail', () async {
    http.Response r = await http.get(
      Uri.parse('$host$resourcePath1/thumb1-$resourceFilename1'),
      headers: {'Authorization': token888},
    );
    expect(r.statusCode, equals(200));
    expect(r.contentLength, equals(2929));
  });

  test('Admin 98 deletes resource', () async {
    http.Response r = await http.delete(
      Uri.parse('${host}api/bucket/98/resource/$resourceId1'),
      headers: {'Authorization': token98},
    );
    expect(r.statusCode, equals(204));
  });

  test('User 888 cannot access default thumbnail', () async {
    http.Response r = await http.get(
      Uri.parse('$host$resourcePath1/thumb1-$resourceFilename1'),
      headers: {'Authorization': token888},
    );
    expect(r.statusCode, equals(404));
  });

}
