import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Test.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token98 = '';

  String token888 = '';

  String resourceId1 = '';
  String resourcePath1 = '';
  String resourceFilename1 = '';

  test('Root creates a private resource', () async {
    http.Response r = await http.post(
      Uri.parse('${host}api/bucket/98/resource'),
      headers: {
        'Authorization': rootKey,
        'Content-Type': Test.uploadContentType,
      },
      body: Test.upload(
        await File('tests/functional/files/invoice_pdf.json').readAsBytes(),
        {'users': [888]},
        'application/json',
        'invoice_pdf.json',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;
    resourceId1 = data['id'] as String;
    resourcePath1 =
        data['path'] as String;
    resourceFilename1 = data['filename'] as String;
  });

  // test('Root generates pdf from resource', () async {
  //   http.Response r = await http.post(
  //     Uri.parse('${host}api/bucket/98/resource/$resourceId1/pdf'),
  //     headers: {
  //       'Authorization': rootKey,
  //     },
  //     body: json.encode({
  //       'data': <String, Object>{
  //         'xxx': 'yyy'
  //       },
  //       'filename': 'xxx.pdf',
  //       'users': [888],
  //       'groups': [666],
  //     }),
  //   );
  //   expect(r.statusCode, equals(200));
  //   // print(r.body);
  //   Dict data = json.decode(r.body) as Dict;
  //   print(data);
  // });
}
