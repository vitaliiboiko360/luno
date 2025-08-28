import 'package:flutter/material.dart';
import 'package:luno/state/event_names.dart';
import 'dart:typed_data';
import 'package:luno/state/table_game_manager.dart';

class TableState {
  TableState(this.tgm);
  TableGameManager tgm;

  PlayerSeat _seat = PlayerSeat.unassigned;

  void processMessage(Uint8List messageByteArray) {
    var action = messageByteArray[actionByteIndex];
    if (action == SeatGranted) {
      var seatGrantedOffset = 2;
      var seatNumber = messageByteArray[seatGrantedOffset++];
      SeatInfo seatInfo = SeatInfo(
        PlayerSeat.fromInt(seatNumber),
        messageByteArray[seatGrantedOffset++],
        messageByteArray[seatGrantedOffset],
      );
      tgm.update('seat', seatInfo);
    }
    if (action == AllTableState) {
      for (int index = 2; index < 14;) {
        SeatInfo seatInfo = SeatInfo(
          PlayerSeat.fromInt(messageByteArray[index++]),
          messageByteArray[index++],
          messageByteArray[index++],
        );
        tgm.update('seatAll', seatInfo);
      }
    }
  }

  void takeSeat(PlayerSeat seat) {
    _seat = seat;
  }
}

class SeatInfo {
  PlayerSeat seat = PlayerSeat.unassigned;
  int colorIndex = 0;
  int avatarIndex = 0;
  SeatInfo(this.seat, this.colorIndex, this.avatarIndex);
}

enum PlayerSeat {
  unassigned(),
  bottom(),
  left(),
  top(),
  right();

  static PlayerSeat fromInt(int value) {
    if (value == bottom.index) {
      return bottom;
    }
    if (value == left.index) {
      return left;
    }
    if (value == top.index) {
      return top;
    }
    if (value == right.index) {
      return right;
    }
    return unassigned;
  }
}
