@JS()
library;

import 'dart:js_interop';

@JS('window.ws.send')
external void wsSend(JSArrayBuffer arrayBuffer);
