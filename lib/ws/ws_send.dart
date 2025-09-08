import 'dart:js_interop';
import 'dart:typed_data';

import 'package:luno/state/commands.dart';
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

void requestSeat(int seat) {
  Uint8List arrayToSend = Uint8List(8);
  arrayToSend[0] = 1;
  arrayToSend[1] = 1;
  arrayToSend[2] = seat;
  wsSend(arrayToSend.buffer.toJS);
}

void checkPlayerSeat() {
  Uint8List arrayToSend = Uint8List(8);
  arrayToSend[0] = TableCommand;
  arrayToSend[1] = CheckPlayerSeat;
  wsSend(arrayToSend.buffer.toJS);
}
