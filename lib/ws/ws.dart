@JS()
library;

import 'dart:js_interop';
import 'dart:typed_data';

@JS('window.ws.send')
external void wsSend(JSArrayBuffer arrayBuffer);

@JS()
external set wsOnMessage(JSFunction function);

void processWsMessage(JSArrayBuffer arrayBuffer) {
  print(
    Uint8List.view(arrayBuffer.toDart).fold<String>("recieved: ", (
      str,
      number,
    ) {
      return '$str $number.toString()';
    }),
  );
}
