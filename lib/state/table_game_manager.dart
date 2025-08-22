import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:luno/state/table_state.dart';

class TableGameManager {
  late Color color = Color.fromARGB(100, 100, 100, 100);
  late bool isColorProccessed = true;

  late TableState tableState = TableState(this);

  void processMessage(Uint8List messageByteArray) {
    if (messageByteArray.length > 3) {
      color = Color.fromARGB(
        100,
        messageByteArray[0],
        messageByteArray[1],
        messageByteArray[2],
      );
      isColorProccessed = false;
    }
  }

  void setProcessed() {
    isColorProccessed = true;
  }

  Map<String, List<Function>> callbacks = Map<String, List<Function>>();

  void update(String eventName, dynamic data) {
    var cbs = callbacks[eventName];
    if (cbs == null) return;
    for (var i = 0; i < cbs.length; i++) {
      cbs[i](data);
    }
  }

  void registerCallback(String eventName, Function callback) {
    callbacks
        .putIfAbsent(eventName, () {
          return List<Function>.empty();
        })
        .add(callback);
  }
}
