import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:luno/state/table_game_manager.dart';

enum Seat { unassigned, top, right, bottom, left }

const seatGrantedOffset = 4;

class TableState {
  TableState(this.tgm);
  TableGameManager tgm;

  Seat _seat = Seat.unassigned;

  void processMessage(Uint8List messageByteArray) {
    messageByteArray[seatGrantedOffset];
  }

  void takeSeat(Seat seat) {
    _seat = seat;
  }
}
