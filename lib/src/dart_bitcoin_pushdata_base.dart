import 'dart:typed_data';

import 'package:dart_bitcoin_ops/dart_bitcoin_ops.dart' as ops;

/// PushData
class PushData {
  int opcode;
  int number;
  int size;

  PushData({required this.opcode, required this.number, required this.size});
}

/// Encoding Length
int encodingLength(int i) {
  return i < ops.OP_PUSHDATA1
      ? 1
      : i <= 0xff
          ? 2
          : i <= 0xffff
              ? 3
              : 5;
}

/// Encode
int encode(ByteData buffer, int number, [int offset = 0]) {
  int size = encodingLength(number);

  // ~6 bit
  if (size == 1) {
    buffer.setUint8(offset, number);

    // 8 bit
  } else if (size == 2) {
    buffer.setUint8(offset, ops.OP_PUSHDATA1);
    buffer.setUint8(offset + 1, number);

    // 16 bit
  } else if (size == 3) {
    buffer.setUint8(offset, ops.OP_PUSHDATA2);
    buffer.setUint16(offset + 1, number, Endian.little);

    // 32 bit
  } else {
    buffer.setUint8(offset, ops.OP_PUSHDATA4);
    buffer.setUint32(offset + 1, number, Endian.little);
  }

  return size;
}

/// Decode
PushData? decode(ByteData buffer, offset) {
  int opcode = buffer.getUint8(offset);
  int number, size;

  // ~6 bit
  if (opcode < ops.OP_PUSHDATA1) {
    number = opcode;
    size = 1;

    // 8 bit
  } else if (opcode == ops.OP_PUSHDATA1) {
    if (offset + 2 > buffer.lengthInBytes) return null;
    number = buffer.getUint8(offset + 1);
    size = 2;

    // 16 bit
  } else if (opcode == ops.OP_PUSHDATA2) {
    if (offset + 3 > buffer.lengthInBytes) return null;
    number = buffer.getUint16(offset + 1, Endian.little);
    size = 3;

    // 32 bit
  } else {
    if (offset + 5 > buffer.lengthInBytes) return null;
    if (opcode != ops.OP_PUSHDATA4) throw Exception('Unexpected opcode');

    number = buffer.getUint32(offset + 1, Endian.little);
    size = 5;
  }

  return PushData(opcode: opcode, number: number, size: size);
}
