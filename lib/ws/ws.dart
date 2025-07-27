import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

class Ws with ChangeNotifier {
  final wsUrl = Uri.parse('ws://uno-game.ddns.net');

  late var channel;

  void connect() async {
    channel = WebSocketChannel.connect(wsUrl);
    await channel.ready;
  }

  @override
  void dispose() {
    channel.sink.close(status.goingAway);
    super.dispose();
  }
}
