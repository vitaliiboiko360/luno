@JS()
library;

import 'dart:js_interop';

@JS('window.pixi.init')
external void pixiInit();

@JS('window.pixi.startStopMoving')
external void startStopMoving();
