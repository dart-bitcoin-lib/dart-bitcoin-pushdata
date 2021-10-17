import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:dart_bitcoin_pushdata/dart_bitcoin_pushdata.dart';
import 'package:test/test.dart';

import 'fixtures.dart';

void main() {
  if (fixtures.containsKey(FixtureEnum.valid)) {
    for (Fixture fixture in fixtures[FixtureEnum.valid]!) {
      test('Valid for ${fixture.hex}', () {
        int opcode = int.parse(fixture.hex.substring(0, 2), radix: 16);
        int size = encodingLength(fixture.dec!);
        expect(size, equals(fixture.hex.length / 2));

        ByteData buffer =
            ByteData.view(Uint8List.fromList(hex.decode(fixture.hex)).buffer);
        final d = decode(buffer, 0);

        expect(d.runtimeType, equals(PushData));
        expect(d!.opcode, equals(opcode));
        expect(d.number, equals(fixture.dec));
        expect(d.size, equals(buffer.lengthInBytes));

        buffer = ByteData(buffer.lengthInBytes);
        final int n = encode(buffer, fixture.dec!, 0);
        expect(hex.encode(buffer.buffer.asUint8List().sublist(0, n)),
            equals(fixture.hex));
      });
    }
  }
  if (fixtures.containsKey(FixtureEnum.invalid)) {
    for (Fixture fixture in fixtures[FixtureEnum.invalid]!) {
      test('Invalid for ${fixture.description}', () {
        ByteData buffer =
            ByteData.view(Uint8List.fromList(hex.decode(fixture.hex)).buffer);
        final d = decode(buffer, 0);

        expect(d, isNull);
      });
    }
  }
}
