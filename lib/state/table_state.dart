import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:luno/state/table_game_manager.dart';

enum Seat { unassigned, top, right, bottom, left }

const seatGrantedOffset = 2;

class TableState {
  TableState(this.tgm);
  TableGameManager tgm;

  Seat _seat = Seat.unassigned;

  void processMessage(Uint8List messageByteArray) {
    var seatNumber = messageByteArray[seatGrantedOffset];
    tgm.update('seat', seatNumber);
  }

  void takeSeat(Seat seat) {
    _seat = seat;
  }
}
