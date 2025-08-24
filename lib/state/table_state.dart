import 'package:flutter/material.dart';
import 'package:luno/state/event_names.dart';
import 'dart:typed_data';
import 'package:luno/state/table_game_manager.dart';

const seatGrantedOffset = 2;

class TableState {
  TableState(this.tgm);
  TableGameManager tgm;

  Seat _seat = Seat.unassigned;

  void processMessage(Uint8List messageByteArray) {
    var action = messageByteArray[actionByteIndex];
    if (action == SeatGranted) {
      var seatNumber = messageByteArray[seatGrantedOffset];
      tgm.update('seat', seatNumber);
    }
    if (action == AllTableState) {
      for (int index = 2; index < 14;) {
        SeatInfo seatInfo = SeatInfo(
          Seat.fromInt(messageByteArray[index]),
          messageByteArray[index++],
          messageByteArray[index++],
        );
        tgm.update('seatAll', seatInfo);
      }
    }
  }

  void takeSeat(Seat seat) {
    _seat = seat;
  }
}

class SeatInfo {
  Seat seat = Seat.unassigned;
  int colorIndex = 0;
  int avatarIndex = 0;
  SeatInfo(this.seat, this.colorIndex, this.avatarIndex);
}

enum Seat {
  unassigned(),
  bottom(),
  left(),
  top(),
  right();

  static Seat fromInt(int value) {
    if (value == bottom) {
      return bottom;
    }
    if (value == left) {
      return left;
    }
    if (value == top) {
      return top;
    }
    if (value == right) {
      return right;
    }
    return unassigned;
  }
}
