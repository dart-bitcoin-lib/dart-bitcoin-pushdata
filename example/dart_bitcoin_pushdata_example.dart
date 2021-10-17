import 'dart:typed_data';

import 'package:dart_bitcoin_pushdata/dart_bitcoin_pushdata.dart';

void main() {
  var i = 120;
  var buffer = ByteData(encodingLength(i));

  final encoded = encode(buffer, i);

  print(encoded);
  // => 2
}
