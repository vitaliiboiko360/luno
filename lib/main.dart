import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:luno/src/app.dart';
import 'package:logging/logging.dart';
import 'dart:developer' as dev;

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

  var ws = Ws();
  ws.connect();

  runApp(const App());
}
