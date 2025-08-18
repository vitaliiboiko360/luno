import 'dart:typed_data';

import 'package:flutter/widgets.dart';

class TableGameManager {
  late Color color = Color.fromARGB(100, 100, 100, 100);
  late bool isColorProccessed = true;

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
}
