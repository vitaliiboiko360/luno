import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:luno/src/app.dart';
import 'package:logging/logging.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:luno/state/table_state.dart';
import 'dart:developer' as dev;
import 'dart:js_interop';
import 'package:luno/ws/ws.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  Logger.root.level = kDebugMode ? Level.FINE : Level.INFO;
  Logger.root.onRecord.listen((record) {
    dev.log(
      record.message,
      time: record.time,
      level: record.level.value,
      name: record.loggerName,
    );
  });

  debugPaintSizeEnabled = false;

  final providerContainer = ProviderContainer(
    // overrides: [avatarProvider.overrideWith(() => AvatarInfoNotifier())],
  );

  providerContainer.listen(avatarProvider, (p, n) {
    print('MAIN: new value = ${n.avatarId}');
  });

  TableGameManager tgm = TableGameManager(providerContainer);
  wsOnMessageHandler(JSArrayBuffer arrayBuffer) {
    tgm.processMessage(Uint8List.view(arrayBuffer.toDart));
  }

  wsOnMessage = wsOnMessageHandler.toJS;

  runApp(App(tgm));
}
