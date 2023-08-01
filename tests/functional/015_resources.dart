import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mwcdn/Etc/Types.dart';
import 'package:mwcdn/Etc/Util.dart';
import 'package:test/test.dart';

import '../testConfig.dart';

void main() {
  String token98 = '';
  String token99 = '';

  String token777 = '';
  String token999 = '';

  String resourceId1 = '';
  String resourceUrl1 = '';

  String resourceId2 = '';
  String resourceUrl2 = '';

  test('Create invalid resource', () async {
    http.Response r = await http.post(
      Uri.parse(host + '/api/bucket/98/resource'),
      headers: {'Authorization': rootKey},
    );
    expect(r.statusCode, equals(400));
  });

  test('Root creates a private resource', () async {
    http.Response r = await http.post(
      Uri.parse(host + '/api/bucket/98/resource'),
      headers: {
        'Authorization': rootKey,
        'Content-Type': 'multipart/form-data; boundary=MyBoundary',
      },
      body: Util.upload(
        await File('tests/functional/files/ffff23.jpg').readAsBytes(),
        {
          'users': [5, 4],
          'groups': [19, 16, 17, 17]
        },
        'image/jpeg',
        'ffff23.jpg',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;

    expect(data['public'], equals(false));
    expect(data['bucket'], equals(98));
    expect(data['users'], equals([4, 5]));
    expect(data['groups'], equals([16, 17, 19]));
    expect(data['filename'], equals('ffff23.jpg'));
    expect(data['mimeType'], equals('image/jpeg'));
    expect(
        data['size'],
        equals(
          46975,
        ));

    resourceId1 = data['id'] as String;
    resourceUrl1 = host +
        '/' +
        (data['path'] as String) +
        '/' +
        (data['filename'] as String);
  });

  test('Root creates a public resource', () async {
    http.Response r = await http.post(
      Uri.parse(host + '/api/bucket/98/resource'),
      headers: {
        'Authorization': rootKey,
        'Content-Type': 'multipart/form-data; boundary=MyBoundary',
      },
      body: Util.upload(
        await File('tests/functional/files/ffff23.jpg').readAsBytes(),
        {},
        'image/jpeg',
        'ffff23.jpg',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;

    expect(data['public'], equals(true));

    resourceUrl2 = host +
        '/' +
        (data['path'] as String) +
        '/' +
        (data['filename'] as String);
  });

  test(
    'Root creates admin token for bucket (98)',
    () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/token'),
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
    'Admin 98 can access resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/98/resource/' + resourceId1),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      expect(data['filename'], equals('ffff23.jpg'));
    },
  );

  test(
    'Admin 99 cannot access resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(host + '/api/bucket/98/resource/' + resourceId1),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Admin 98 can load private resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl1),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 99 cannot load private resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl1),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Nobody cannot load private resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl1),
      );
      expect(r.statusCode, equals(404));
    },
  );

  test(
    'Admin 98 can load public resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl2),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 99 can load public resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl2),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Anyone can load public resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl2),
      );
      expect(r.statusCode, equals(200));
    },
  );

  // ------------------------

  test('Admin creates a private resource', () async {
    http.Response r = await http.post(
      Uri.parse(host + '/api/bucket/98/resource'),
      headers: {
        'Authorization': token98,
        'Content-Type': 'multipart/form-data; boundary=MyBoundary',
      },
      body: Util.upload(
        await File('tests/functional/files/ffff23.jpg').readAsBytes(),
        {
          'users': [777],
          'groups': [999]
        },
        'image/jpeg',
        'ffff23.jpg',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;

    expect(data['public'], equals(false));

    resourceId1 = data['id'] as String;
    resourceUrl1 = host +
        '/' +
        (data['path'] as String) +
        '/' +
        (data['filename'] as String);
  });

  test('Admin creates a public resource', () async {
    http.Response r = await http.post(
      Uri.parse(host + '/api/bucket/98/resource'),
      headers: {
        'Authorization': token98,
        'Content-Type': 'multipart/form-data; boundary=MyBoundary',
      },
      body: Util.upload(
        await File('tests/functional/files/ffff23.jpg').readAsBytes(),
        {},
        'image/jpeg',
        'ffff23.jpg',
      ),
    );
    expect(r.statusCode, equals(200));
    Dict data = json.decode(r.body) as Dict;

    expect(data['public'], equals(true));

    resourceId2 = data['id'] as String;
    resourceUrl2 = host +
        '/' +
        (data['path'] as String) +
        '/' +
        (data['filename'] as String);
  });

  test(
    'Anyone can load public resource',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl2),
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 99 cannot delete resource',
    () async {
      http.Response r = await http.delete(
        Uri.parse(host + '/api/bucket/98/resource/' + resourceId2),
        headers: {'Authorization': token99},
      );
      expect(r.statusCode, equals(403));
    },
  );

  test(
    'Admin 98 can delete resource',
    () async {
      http.Response r = await http.delete(
        Uri.parse(host + '/api/bucket/98/resource/' + resourceId2),
        headers: {'Authorization': token98},
      );
      expect(r.statusCode, equals(204));
    },
  );

  test(
    'Private resource is protected',
        () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl1),
      );
      expect(r.statusCode, equals(404));
    },
  );

  test(
    'Public resource is deleted',
    () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl2),
      );
      expect(r.statusCode, equals(404));
    },
  );

  test(
    'Admin 98 creates token for user 777',
    () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/bucket/98/token'),
        headers: {'Authorization': token98},
        body: jsonEncode({
          'users': [777],
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      token777 = data['id'] as String;
    },
  );

  test(
    'Private resource is accessible for user 777',
        () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl1),
        headers: {'Authorization': token777},
      );
      expect(r.statusCode, equals(200));
    },
  );

  test(
    'Admin 98 creates token for group 999',
        () async {
      http.Response r = await http.post(
        Uri.parse(host + '/api/bucket/98/token'),
        headers: {'Authorization': token98},
        body: jsonEncode({
          'groups': [999],
        }),
      );
      expect(r.statusCode, equals(200));
      Dict data = json.decode(r.body) as Dict;
      token999 = data['id'] as String;
    },
  );

  test(
    'Private resource is accessible for group 999',
        () async {
      http.Response r = await http.get(
        Uri.parse(resourceUrl1),
        headers: {'Authorization': token999},
      );
      expect(r.statusCode, equals(200));
    },
  );
}
