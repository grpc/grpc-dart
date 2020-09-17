// Copyright (c) 2019, the gRPC project authors. Please see the AUTHORS file
// for details. All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// This implementation is borrowed from googleapis_auth.
// TODO(https://github.com/dart-lang/build/issues/2322): If this is fixed we can
// go back to doing a src/ import of this. However that is also not ideal.
// TODO(sigurdm): Get rid of this when Dart has enough crypto support.

import 'dart:typed_data';

import 'package:crypto/crypto.dart';

/// Used for signing messages with a private RSA key.
///
/// The implemented algorithm can be seen in
/// RFC 3447, Section 9.2 EMSA-PKCS1-v1_5.
class RS256Signer {
  // NIST sha-256 OID (2 16 840 1 101 3 4 2 1)
  // See a reference for the encoding here:
  // http://msdn.microsoft.com/en-us/library/bb540809%28v=vs.85%29.aspx
  static const _RSA_SHA256_ALGORITHM_IDENTIFIER = const [
    0x06,
    0x09,
    0x60,
    0x86,
    0x48,
    0x01,
    0x65,
    0x03,
    0x04,
    0x02,
    0x01
  ];

  final RSAPrivateKey _rsaKey;

  RS256Signer(this._rsaKey);

  List<int> sign(List<int> bytes) {
    var digest = _digestInfo(sha256.convert(bytes).bytes);
    var modulusLen = (_rsaKey.bitLength + 7) ~/ 8;

    var block = new Uint8List(modulusLen);
    var padLength = block.length - digest.length - 3;
    block[0] = 0x00;
    block[1] = 0x01;
    block.fillRange(2, 2 + padLength, 0xFF);
    block[2 + padLength] = 0x00;
    block.setRange(2 + padLength + 1, block.length, digest);
    return RSAAlgorithm.encrypt(_rsaKey, block, modulusLen);
  }

  static Uint8List _digestInfo(List<int> hash) {
    // DigestInfo :== SEQUENCE {
    //     digestAlgorithm AlgorithmIdentifier,
    //     digest OCTET STRING
    // }
    var offset = 0;
    var digestInfo = new Uint8List(
        2 + 2 + _RSA_SHA256_ALGORITHM_IDENTIFIER.length + 2 + 2 + hash.length);
    {
      // DigestInfo
      digestInfo[offset++] = ASN1Parser.SEQUENCE_TAG;
      digestInfo[offset++] = digestInfo.length - 2;
      {
        // AlgorithmIdentifier.
        digestInfo[offset++] = ASN1Parser.SEQUENCE_TAG;
        digestInfo[offset++] = _RSA_SHA256_ALGORITHM_IDENTIFIER.length + 2;
        digestInfo.setAll(offset, _RSA_SHA256_ALGORITHM_IDENTIFIER);
        offset += _RSA_SHA256_ALGORITHM_IDENTIFIER.length;
        digestInfo[offset++] = ASN1Parser.NULL_TAG;
        digestInfo[offset++] = 0;
      }
      digestInfo[offset++] = ASN1Parser.OCTET_STRING_TAG;
      digestInfo[offset++] = hash.length;
      digestInfo.setAll(offset, hash);
    }
    return digestInfo;
  }
}

class ASN1Parser {
  static const INTEGER_TAG = 0x02;
  static const OCTET_STRING_TAG = 0x04;
  static const NULL_TAG = 0x05;
  static const OBJECT_ID_TAG = 0x06;
  static const SEQUENCE_TAG = 0x30;

  static ASN1Object parse(Uint8List bytes) {
    invalidFormat(String msg) {
      throw new ArgumentError("Invalid DER encoding: $msg");
    }

    var data = new ByteData.view(bytes.buffer);
    int offset = 0;
    int end = bytes.length;

    checkNBytesAvailable(int n) {
      if ((offset + n) > end) {
        invalidFormat('Tried to read more bytes than available.');
      }
    }

    List<int> readBytes(int n) {
      checkNBytesAvailable(n);

      var integerBytes = bytes.sublist(offset, offset + n);
      offset += n;
      return integerBytes;
    }

    int readEncodedLength() {
      checkNBytesAvailable(1);

      var lengthByte = data.getUint8(offset++);

      // Short length encoding form: This byte is the length itself.
      if (lengthByte < 0x80) {
        return lengthByte;
      }

      // Long length encoding form:
      // This byte has in bits 0..6 the number of bytes following which encode
      // the length.
      int countLengthBytes = lengthByte & 0x7f;
      checkNBytesAvailable(countLengthBytes);

      int length = 0;
      while (countLengthBytes > 0) {
        length = (length << 8) | data.getUint8(offset++);
        countLengthBytes--;
      }
      return length;
    }

    void readNullBytes() {
      checkNBytesAvailable(1);
      var nullByte = data.getUint8(offset++);
      if (nullByte != 0x00) {
        invalidFormat('Null byte expect, but was: $nullByte.');
      }
    }

    ASN1Object decodeObject() {
      checkNBytesAvailable(1);
      var tag = bytes[offset++];
      switch (tag) {
        case INTEGER_TAG:
          int size = readEncodedLength();
          return new ASN1Integer(RSAAlgorithm.bytes2BigInt(readBytes(size)));
        case OCTET_STRING_TAG:
          var size = readEncodedLength();
          return new ASN1OctetString(readBytes(size));
        case NULL_TAG:
          readNullBytes();
          return new ASN1Null();
        case OBJECT_ID_TAG:
          var size = readEncodedLength();
          return new ASN1ObjectIdentifier(readBytes(size));
        case SEQUENCE_TAG:
          var lengthInBytes = readEncodedLength();
          if ((offset + lengthInBytes) > end) {
            invalidFormat('Tried to read more bytes than available.');
          }
          int endOfSequence = offset + lengthInBytes;

          var objects = <ASN1Object>[];
          while (offset < endOfSequence) {
            objects.add(decodeObject());
          }
          return new ASN1Sequence(objects);
        default:
          invalidFormat(
              'Unexpected tag $tag at offset ${offset - 1} (end: $end).');
      }
      // Unreachable.
      return null;
    }

    var obj = decodeObject();
    if (offset != bytes.length) {
      throw new ArgumentError('More bytes than expected in ASN1 encoding.');
    }
    return obj;
  }
}

abstract class ASN1Object {}

class ASN1Sequence extends ASN1Object {
  final List<ASN1Object> objects;
  ASN1Sequence(this.objects);
}

class ASN1Integer extends ASN1Object {
  final BigInt integer;
  ASN1Integer(this.integer);
}

class ASN1OctetString extends ASN1Object {
  final List<int> bytes;
  ASN1OctetString(this.bytes);
}

class ASN1ObjectIdentifier extends ASN1Object {
  final List<int> bytes;
  ASN1ObjectIdentifier(this.bytes);
}

class ASN1Null extends ASN1Object {}

/// Represents integers obtained while creating a Public/Private key pair.
class RSAPrivateKey {
  /// First prime number.
  final BigInt p;

  /// Second prime number.
  final BigInt q;

  /// Modulus for public and private keys. Satisfies `n=p*q`.
  final BigInt n;

  /// Public key exponent. Satisfies `d*e=1 mod phi(n)`.
  final BigInt e;

  /// Private key exponent. Satisfies `d*e=1 mod phi(n)`.
  final BigInt d;

  /// Different form of [p]. Satisfies `dmp1=d mod (p-1)`.
  final BigInt dmp1;

  /// Different form of [p]. Satisfies `dmq1=d mod (q-1)`.
  final BigInt dmq1;

  /// A coefficient which satisfies `coeff=q^-1 mod p`.
  final BigInt coeff;

  /// The number of bits used for the modulus. Usually 1024, 2048 or 4096 bits.
  int get bitLength => n.bitLength;

  RSAPrivateKey(
      this.n, this.e, this.d, this.p, this.q, this.dmp1, this.dmq1, this.coeff);
}

/// Provides a [encrypt] method for encrypting messages with a [RSAPrivateKey].
abstract class RSAAlgorithm {
  /// Performs the encryption of [bytes] with the private [key].
  /// Others who have access to the public key will be able to decrypt this
  /// the result.
  ///
  /// The [intendedLength] argument specifies the number of bytes in which the
  /// result should be encoded. Zero bytes will be used for padding.
  static List<int> encrypt(
      RSAPrivateKey key, List<int> bytes, int intendedLength) {
    var message = bytes2BigInt(bytes);
    var encryptedMessage = _encryptInteger(key, message);
    return integer2Bytes(encryptedMessage, intendedLength);
  }

  static BigInt _encryptInteger(RSAPrivateKey key, BigInt x) {
    // The following is equivalent to `_modPow(x, key.d, key.n) but is much
    // more efficient. It exploits the fact that we have dmp1/dmq1.
    var xp = _modPow(x % key.p, key.dmp1, key.p);
    var xq = _modPow(x % key.q, key.dmq1, key.q);
    while (xp < xq) {
      xp += key.p;
    }
    return ((((xp - xq) * key.coeff) % key.p) * key.q) + xq;
  }

  // TODO(kevmoo): see if this can be done more efficiently with BigInt
  static BigInt _modPow(BigInt b, BigInt e, BigInt m) {
    if (e < BigInt.one) {
      return BigInt.one;
    }
    if (b < BigInt.zero || b > m) {
      b = b % m;
    }
    var r = BigInt.one;
    while (e > BigInt.zero) {
      if ((e & BigInt.one) > BigInt.zero) {
        r = (r * b) % m;
      }
      e >>= 1;
      b = (b * b) % m;
    }
    return r;
  }

  static BigInt bytes2BigInt(List<int> bytes) {
    var number = BigInt.zero;
    for (var i = 0; i < bytes.length; i++) {
      number = (number << 8) | new BigInt.from(bytes[i]);
    }
    return number;
  }

  static List<int> integer2Bytes(BigInt integer, int intendedLength) {
    if (integer < BigInt.one) {
      throw new ArgumentError('Only positive integers are supported.');
    }
    var bytes = new Uint8List(intendedLength);
    for (int i = bytes.length - 1; i >= 0; i--) {
      bytes[i] = (integer & _bigIntFF).toInt();
      integer >>= 8;
    }
    return bytes;
  }
}

final _bigIntFF = new BigInt.from(0xff);
