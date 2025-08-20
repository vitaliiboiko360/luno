import 'package:flutter/material.dart';

enum Seat { unassigned, top, right, bottom, left }

class TableState {
  Seat _seat = Seat.unassigned;

  void takeSeat(Seat seat) {
    _seat = seat;
  }
}
