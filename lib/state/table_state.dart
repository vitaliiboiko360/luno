import 'package:flutter/material.dart';
import 'package:luno/state/table_game_manager.dart';

enum Seat { unassigned, top, right, bottom, left }

class TableState {
  TableState(this.tgm);
  TableGameManager tgm;

  Seat _seat = Seat.unassigned;

  void takeSeat(Seat seat) {
    _seat = seat;
  }
}
