import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:luno/state/commands.dart';
import 'package:luno/state/events.dart';
import 'dart:typed_data';
import 'package:luno/state/table_game_manager.dart';

final avatarProvider = NotifierProvider<AvatarInfoNotifier, AvatarInfo>(
  AvatarInfoNotifier.new,
);

class TableState {
  TableState(this.tgm) {
    sub = tgm.providerContainer.listen(avatarProvider, (
      previousValue,
      newValue,
    ) {
      tgm.update(Event.avatar.name, newValue);
    });
  }
  TableGameManager tgm;
  late ProviderSubscription sub;

  PlayerSeat _seat = PlayerSeat.unassigned;
  PlayerSeat get seat => _seat;
  bool isSeat(PlayerSeat seat) => _seat == seat;
  bool isPlayer() => _seat != PlayerSeat.unassigned;

  void processMessage(Uint8List messageByteArray) {
    var action = messageByteArray[actionByteIndex];
    if (action == SeatGranted) {
      print('process seat granted');
      var seatGrantedOffset = 2;
      var seatNumber = messageByteArray[seatGrantedOffset++];
      _seat = PlayerSeat.fromInt(seatNumber);
      print('seat is $_seat');
      SeatInfo seatInfo = SeatInfo(
        PlayerSeat.fromInt(seatNumber),
        messageByteArray[seatGrantedOffset++],
        messageByteArray[seatGrantedOffset],
      );
      tgm.update('seat', seatInfo);
    }
    if (action == AllTableState) {
      for (int index = 2; index < 14;) {
        PlayerSeat seat = PlayerSeat.mapSeat(
          PlayerSeat.fromInt(messageByteArray[index++]),
          _seat,
        );
        SeatInfo seatInfo = SeatInfo(
          seat,
          messageByteArray[index++],
          messageByteArray[index++],
        );
        tgm.update(Event.seatAll.name, seatInfo);
      }
    }
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

  static PlayerSeat mapSeat(PlayerSeat seat, PlayerSeat mainSeat) {
    PlayerSeat seatBottom = PlayerSeat.bottom;
    if (mainSeat == PlayerSeat.left) {
      return switch (seat) {
        PlayerSeat.top => PlayerSeat.left,
        PlayerSeat.right => PlayerSeat.top,
        PlayerSeat.bottom => PlayerSeat.right,
        _ => seatBottom,
      };
    }
    if (mainSeat == PlayerSeat.top) {
      return switch (seat) {
        PlayerSeat.left => PlayerSeat.right,
        PlayerSeat.right => PlayerSeat.left,
        PlayerSeat.bottom => PlayerSeat.top,
        _ => seatBottom,
      };
    }
    if (mainSeat == PlayerSeat.right) {
      return switch (seat) {
        PlayerSeat.left => PlayerSeat.top,
        PlayerSeat.top => PlayerSeat.right,
        PlayerSeat.bottom => PlayerSeat.left,
        _ => seatBottom,
      };
    }
    return seat;
  }
}

class AvatarInfo {
  int avatarId = 0;
  int colorId = 0;
}

class AvatarInfoNotifier extends Notifier<AvatarInfo> {
  @override
  AvatarInfo build() {
    return AvatarInfo();
  }

  void setAvatarId(int avatarId) {
    state.avatarId = avatarId;
    ref.notifyListeners();
  }

  void setColorId(int colorId) {
    state.colorId = colorId;
    ref.notifyListeners();
  }

  int getAvatarId() => state.avatarId;
}
