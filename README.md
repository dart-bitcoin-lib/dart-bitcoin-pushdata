# pushdata-bitcoin

Encode/decode value as bitcoin `OP_PUSHDATA` integer


## Example

``` dart
import 'dart:typed_data';

import 'package:dart_bitcoin_pushdata/dart_bitcoin_pushdata.dart';

void main() {
  var i = 120;
  var buffer = ByteData(encodingLength(i));

  final encoded = encode(buffer, i);

  print(encoded);
  // => 2
}
```

## LICENSE [MIT](LICENSE)