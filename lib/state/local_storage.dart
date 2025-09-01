@JS()
library;

import 'dart:js_interop';

external Storage get localStorage;

@JS()
class Storage {
  late int length;
  external dynamic getItem(String key);
  external void setItem(String key, dynamic item);
  external void removeItem(String key);
  external void clear();
}
