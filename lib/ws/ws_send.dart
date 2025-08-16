import 'dart:js_interop';
import 'dart:typed_data';

import 'package:luno/ws/ws.dart';

void wsSendMessage() {
  JSArrayBuffer jsArrayBuffer = JSArrayBuffer(9);
  List<int> numbers = [65, 65, 65, 65, 65, 65, 65, 65, 65];
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  jsArrayBuffer.add(65.toJS);
  wsSend(Uint8List.fromList(numbers).buffer.toJS);
}
