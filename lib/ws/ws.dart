import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class Ws extends ChangeNotifier {
  final wsUrl = Uri.parse('ws://uno-game.ddns.com:7192/ws');

  late var channel;
  late var isValid = false;

  void connect() async {
    channel = WebSocketChannel.connect(wsUrl);
    try {
      await channel.ready;
      isValid = true;
      channel.stream.listen(onMessage, onError: onError, onDone: onDone);
    } catch (e) {
      print('\n\nchannel failed to be ready ${e.toString()}\n');
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

  void onError(error) {
    print('websocket error: $error');
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
