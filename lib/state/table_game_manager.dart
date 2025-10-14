import 'dart:typed_data';
import 'package:riverpod/riverpod.dart';
import 'package:luno/state/table_state.dart';

const actionByteIndex = 1;

class TableGameManager {
  ProviderContainer providerContainer;
  TableGameManager(this.providerContainer) {
    tableState = TableState(this);
  }
  late TableState tableState;

  void processMessage(Uint8List messageByteArray) {
    print(
      'recieve message::: ${messageByteArray.fold("", (c, i) => c + " " + i.toString())}',
    );
    tableState.processMessage(messageByteArray);
  }

  Map<String, List<Function>> callbacks = <String, List<Function>>{};

  void update(String eventName, dynamic data) {
    var cbs = callbacks[eventName];
    if (cbs == null) return;
    for (var i = 0; i < cbs.length; i++) {
      if (data != null) {
        cbs[i](data);
      } else {
        cbs[i]();
      }
    }
  }

  void registerCallback(String eventName, Function callback) {
    (callbacks.putIfAbsent(eventName, () {
      return <Function>[];
    })).add(callback);
  }
}
