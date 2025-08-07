import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class Ws with ChangeNotifier {
  final wsUrl = Uri.parse('ws://192.168.0.101:5290/ws');

  late var channel;
  late var isValid = false;

  void connect() async {
    channel = WebSocketChannel.connect(wsUrl);
    try {
      await channel.ready;
      isValid = true;
      channel.stream.listen(onMessage, onError: onError, onDone: onDone);
    } catch (e) {
      print('channel failed to be ready');
    }
  }

  void send(ByteBuffer buffer) async {
    if (!isValid) {
      print('trying to send $buffer but WS is not valid');
    }
    channel.sink.add(buffer);
  }

  var _message;

  void onMessage(message) {
    print(message);
    _message = message;
    notifyListeners();
  }

  dynamic getMessage() {
    return _message;
  }

  void onError() {
    print('websocket error');
  }

  void onDone() {
    print('websocket is closing');
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }
}
