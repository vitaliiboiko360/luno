import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class Ws with ChangeNotifier {
  final wsUrl = Uri.parse('ws://192.168.0.101:5290/ws');

  late var channel;

  void connect() async {
    channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
    channel.stream.listen(onMessage, onError: onError, onDone: onDone);
  }

  void send(ByteBuffer buffer) async {
    channel.sink.add(buffer);
  }

  void onMessage(message) {
    print(message);
    notifyListeners();
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
