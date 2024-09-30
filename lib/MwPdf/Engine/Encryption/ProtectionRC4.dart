import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:pdf/src/pdf/document.dart';
import 'package:pdf/src/pdf/format/base.dart';
import 'package:pdf/src/pdf/format/name.dart';
import 'package:pdf/src/pdf/format/num.dart';
import 'package:pdf/src/pdf/format/object_base.dart';
import 'package:pdf/src/pdf/format/string.dart';
import 'package:pdf/src/pdf/format/stream.dart';
import 'package:pdf/src/pdf/obj/encryption.dart';

class EscapedKey extends PdfDataType {
  final Uint8List key;

  const EscapedKey(this.key);

  @override
  void output(
      PdfObjectBase o,
      PdfStream s,
      [int? indent,]
      ) {
    s.putByte(0x20);
    s.putByte(40);
    s.putBytes(
        _escape(key),
    );
    s.putByte(41);
  }

  Uint8List _escape(Uint8List input) {
    List<int> result = [];
    for (var byte in input) {
      if (byte == 0x5C) {
        result.addAll([0x5C, 0x5C]); // '\\'
      } else if (byte == 0x28) {
        result.addAll([0x5C, 0x28]); // '\('
      } else if (byte == 0x29) {
        result.addAll([0x5C, 0x29]); // '\)'
      } else if (byte == 0x0D) {
        result.addAll([0x5C, 0x72]); // '\r'
      } else {
        result.add(byte);
      }
    }
    return Uint8List.fromList(result);
  }
}


// BROKEN!!!!

class ProtectionRC4 extends PdfEncryption {
  final Uint8List encryptionKey;
  final Uint8List oValue;
  final Uint8List uValue;
  final int pValue;

  ProtectionRC4(
    super.pdfDocument, {
    required this.encryptionKey,
    required this.oValue,
    required this.uValue,
    required this.pValue,
  });

  @override
  void prepare() {
    super.prepare();
    params['/Filter'] = const PdfName('/Standard');
    params['/V'] = const PdfNum(1);
    params['/R'] = const PdfNum(2);
    params['/O'] = EscapedKey(oValue);
    params['/U'] = EscapedKey(uValue);
    // params['/O'] = PdfString(oValue, encrypted: false);
    // params['/U'] = PdfString(uValue, encrypted: false);
    params['/P'] = PdfNum(pValue);
  }

  @override
  Uint8List encrypt(
    Uint8List input,
    PdfObjectBase<PdfDataType> object,
  ) {
    // print('#${object.objser}');
    // print(object);
    // print(String.fromCharCodes(input));
    // return input;
    // print(encryptionKey.length);
    // print(_packVXxx(5).length);
    // print(base64Encode(encryptionKey));
    // print(base64Encode(encryptionKey+ _packVXxx(5)));

    Uint8List key = Uint8List.fromList(
      md5
          .convert(
            encryptionKey + _packVXxx(object.objser),
          )
          .bytes,
    );

    // print(object.objser);
    // print(base64Encode(key));

    return rc4(key, input);
  }

  Uint8List _packVXxx(int value) {
    final ByteData byteData = ByteData(5);
    byteData.setUint32(0, value, Endian.little);
    byteData.setInt8(3, 0); // x
    byteData.setInt8(4, 0); // x
    return byteData.buffer.asUint8List();
  }

  static ProtectionRC4 create(
    PdfDocument document, {
    required String userPass,
    required String ownerPass,
  }) {
    // TODO 'print' => 4, 'modify' => 8, 'copy' => 16, 'annot-forms' => 32
    int protection = 192 + 4;

    const String padding =
        '\x28\xBF\x4E\x5E\x4E\x75\x8A\x41\x64\x00\x4E\x56\xFF\xFA\x01\x08\x2E\x2E\x00\xB6\xD0\x68\x3E\x80\x2F\x0C\xA9\xFE\x64\x53\x69\x7A';

    Uint8List userPassList =
        Uint8List.fromList(utf8.encode(userPass) + padding.codeUnits)
            .sublist(0, 32);
    Uint8List ownerPassList =
        Uint8List.fromList(utf8.encode(ownerPass) + padding.codeUnits)
            .sublist(0, 32);

    Digest md5Digest = md5.convert(ownerPassList);
    Uint8List ownerRc4Key = Uint8List.fromList(md5Digest.bytes.sublist(0, 5));

    Uint8List oValue = rc4(ownerRc4Key, userPassList);

    Digest md5Digest2 = md5.convert(
        userPassList + oValue + [protection] + '\xFF\xFF\xFF'.codeUnits);
    Uint8List encryptionKey =
        Uint8List.fromList(md5Digest2.bytes.sublist(0, 5));

    Uint8List uValue =
        rc4(encryptionKey, Uint8List.fromList(padding.codeUnits));

    int pValue = -((protection ^ 255) + 1);

    // print(base64Encode(encryptionKey));
    // print(base64Encode(oValue));
    // print(base64Encode(uValue));

    return ProtectionRC4(
      document,
      encryptionKey: encryptionKey,
      oValue: oValue,
      uValue: uValue,
      pValue: pValue,
    );
  }

  static Uint8List rc4(
    Uint8List key,
    Uint8List data,
  ) {
    // Initialisierung des S-Arrays
    final int keyLength = key.length;
    final List<int> S = List.generate(256, (i) => i);
    int j = 0;

    // Schlüssel-Initialisierung
    for (int i = 0; i < 256; i++) {
      j = (j + S[i] + key[i % keyLength]) % 256;
      // Tausche S[i] und S[j]
      final temp = S[i];
      S[i] = S[j];
      S[j] = temp;
    }

    // Verschlüsselung
    final Uint8List result = Uint8List(data.length);
    int i = 0;
    j = 0;

    for (int k = 0; k < data.length; k++) {
      i = (i + 1) % 256;
      j = (j + S[i]) % 256;

      // Tausche S[i] und S[j]
      final temp = S[i];
      S[i] = S[j];
      S[j] = temp;

      // Generiere den Keystream und verschlüssle das Datenbyte
      final int keyStreamByte = S[(S[i] + S[j]) % 256];
      result[k] = data[k] ^ keyStreamByte;
    }

    return result;
  }
}
