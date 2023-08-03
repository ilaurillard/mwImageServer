import 'dart:convert';
import 'dart:typed_data';

import 'package:mwcdn/Etc/Types.dart';

class Test {
  static const uploadContentType = 'multipart/form-data; boundary=MyBoundary';

  static Uint8List upload(
    Uint8List imageData,
    Dict meta,
    String mime,
    String filename,
  ) {
    BytesBuilder data = BytesBuilder();
    data.add(
      Uint8List.fromList(
        ('--MyBoundary\r\nContent-Type: application/json\r\n\r\n${json.encode(meta)}\r\n--MyBoundary\r\nContent-Disposition: form-data; filename="$filename"\r\nContent-Type: $mime\r\n\r\n')
            .codeUnits,
      ),
    );
    data.add(imageData);
    data.add(
      Uint8List.fromList(
        ('\r\n--MyBoundary--\r\n').codeUnits,
      ),
    );
    return data.toBytes();
  }
}
