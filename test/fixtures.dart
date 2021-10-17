enum FixtureEnum { valid, invalid }

class Fixture {
  String? description;
  int? dec;
  String hex;

  Fixture({required this.hex, this.dec, this.description});
}

Map<FixtureEnum, List<Fixture>> fixtures = {
  FixtureEnum.valid: [
    Fixture(dec: 0, hex: "00"),
    Fixture(dec: 1, hex: "01"),
    Fixture(dec: 252, hex: "4cfc"),
    Fixture(dec: 253, hex: "4cfd"),
    Fixture(dec: 254, hex: "4cfe"),
    Fixture(dec: 255, hex: "4cff"),
    Fixture(dec: 65534, hex: "4dfeff"),
    Fixture(dec: 65535, hex: "4dffff"),
    Fixture(dec: 65536, hex: "4e00000100"),
    Fixture(dec: 65537, hex: "4e01000100"),
    Fixture(dec: 4294967295, hex: "4effffffff")
  ],
  FixtureEnum.invalid: [
    Fixture(description: "OP_PUSHDATA1, no size", hex: "4c"),
    Fixture(description: "OP_PUSHDATA2, no size", hex: "4d"),
    Fixture(description: "OP_PUSHDATA4, no size", hex: "4e")
  ]
};
