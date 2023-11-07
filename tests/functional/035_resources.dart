// ignore_for_file: unnecessary_string_escapes

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
        await File('tests/functional/files/invoice_pdf_template.json').readAsBytes(),
        {'users': [888]},
        'application/json',
        'invoice_pdf_template.json',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;
    resourceId1 = data['id'] as String;
    resourcePath1 =
        data['path'] as String;
    resourceFilename1 = data['filename'] as String;
  });

  test('Root generates pdf from resource', () async {
    http.Response r = await http.post(
      Uri.parse('${host}api/bucket/98/resource/$resourceId1/pdf'),
      headers: {
        'Authorization': rootKey,
      },
      body: json.encode({
        'data': <String, Object>{
          'sources': {
            '@img1': {
              'binary': 'iVBORw0KGgoAAAANSUhEUgAAAEAAAABACAIAAAAlC+aJAAAAA3NCSVQICAjb4U/gAAAAsUlEQVRoQ+3S0Q2AIBTFUHFHB2Io9zPMcD7MS8p/b6BlPfu9Jp978uXP3XvA3wUrUAE00BdCgYxXgBXiQAVQIOMVYIU4UAEUyHgFWCEOVAAFMl4BVogDFUCBjFeAFeJABVAg4xVghThQARTIeAVYIQ5UAAUyXgFWiAMVQIGMV4AV4kAFUCDjFWCFOFABFMh4BVghDlQABTJeAVaIAxVAgYxXgBXiQAVQIOMVYIU4ML7AB7SUAgsNFnJkAAAAAElFTkSuQmCC'
            },
            '@img2': {
              'url': 'https://placehold.co/200x100/png?text=FlinsenDaFör'
            },
            '@img3': {
              'url': 'https://placehold.co/200x100/jpg?text=HurrFurr'
            },

            '@svg1': {
              'binary': 'PHN2ZyBoZWlnaHQ9IjEwMCIgd2lkdGg9IjEwMCI+CiAgPGNpcmNsZSBjeD0iNTAiIGN5PSI1MCIgcj0iNDAiIHN0cm9rZT0iYmxhY2siIHN0cm9rZS13aWR0aD0iMyIgZmlsbD0icmVkIiAvPgogIFNvcnJ5LCB5b3VyIGJyb3dzZXIgZG9lcyBub3Qgc3VwcG9ydCBpbmxpbmUgU1ZHLiAgCjwvc3ZnPiA='
            },
            '@svg2': {
              'binary': '<svg height="100" width="100"><circle cx="50" cy="50" r="40" stroke="black" stroke-width="3" fill="green" /></svg>'
            },
            '@svg3': {
              'url': 'https://placehold.co/200x100/svg?text=FlinsenSuppe'
            },
            '@svg4': {
              'binary': '<svg width="200" height="100"><rect width="100%" height="100%" fill="#DDDDDD"/></svg>'
            },

            '@source3': {
              'text': 'some text'
            },
            '@source2': {
              'widget': {
                'LoremParagraph': {
                  'sentence': 20
                }
              }
            },
            '@source1': {
              'valuesLocale': 'en_US',
              'valuesFormats': {
                '1': '#,##0',
                '3': '#,##0.00'
              },
              'values': [
                [
                  'Katze',
                  1.5,
                  true,
                  7.5
                ],
                [
                  'Hund',
                  null,
                  false,
                  333441275.25
                ],
                [
                  'Seehund',
                  33,
                  false,
                  375.25
                ],
                [
                  'Hase',
                  4,
                  true,
                  0
                ]
              ]
            }
          }
        },
        'filename': 'xxx.pdf',
        'users': [888],
        'groups': [666],
      }),
    );
    expect(r.statusCode, equals(200));
    // print(r.body);
    Dict data = json.decode(r.body) as Dict;
    print(data);
  });
}
