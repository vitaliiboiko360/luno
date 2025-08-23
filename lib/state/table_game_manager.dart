import 'dart:typed_data';

import 'package:luno/state/event_names.dart';
import 'package:luno/state/table_state.dart';

const actionByteIndex = 1;

class TableGameManager {
  late TableState tableState = TableState(this);

  void processMessage(Uint8List messageByteArray) {
    if (actionByteIndex == SeatGranted) {
      tableState.processMessage(messageByteArray);
    }
  }

  Map<String, List<Function>> callbacks = <String, List<Function>>{};

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
