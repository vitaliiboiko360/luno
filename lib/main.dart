import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:luno/bg/bg.dart';
import 'package:luno/src/app.dart';
import 'package:logging/logging.dart';
import 'package:luno/state/table_game_manager.dart';
import 'dart:developer' as dev;
import 'dart:js_interop';
import 'package:luno/ws/ws.dart';

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
  debugPaintSizeEnabled = true;
  var bgImage = images[Random().nextInt(images.length - 1)];
  TableGameManager tgm = TableGameManager();

  wsOnMessageHandler(JSArrayBuffer arrayBuffer) {
    tgm.processMessage(Uint8List.view(arrayBuffer.toDart));
  }

  wsOnMessage = wsOnMessageHandler.toJS;

  runApp(App(tgm, bgImage));
}
