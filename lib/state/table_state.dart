import 'package:flutter/foundation.dart';
import 'package:riverpod/riverpod.dart';
import 'package:luno/state/commands.dart';
import 'package:luno/state/events.dart';
import 'package:luno/state/table_game_manager.dart';
import 'package:luno/ws/ws_send.dart';

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
  bool isCheckedClientIsPlayer = false;
  bool isRequestedInitTable = false;

  Uint8List? allTableStateCachedMessage;

  void processMessage(Uint8List messageByteArray) {
    var action = messageByteArray[actionByteIndex];

    /** SEAT GRANTED */
    if (action == SeatGranted) {
      print('process seat granted');

      var seatGrantedOffset = 2;
      var seatNumber = messageByteArray[seatGrantedOffset++];

      _seat = PlayerSeat.fromInt(seatNumber);
      if (allTableStateCachedMessage != null) {
        _updateAllTableState(allTableStateCachedMessage!);
      }
      isCheckedClientIsPlayer = true;
      if (_seat == PlayerSeat.unassigned) return;

      print('seat is $_seat');
      SeatInfo seatInfo = SeatInfo(
        PlayerSeat.mapSeat(PlayerSeat.fromInt(seatNumber), _seat),
        messageByteArray[seatGrantedOffset++],
        messageByteArray[seatGrantedOffset],
      );
      tgm.update(Event.seat.name, seatInfo);
      tgm.update(Event.addChangeButton.name, null);
    }

    /** ALL TABLE STATE */
    if (action == AllTableState) {
      _updateAllTableState(messageByteArray);
    }

    /** REQUEST INIT TABLE */
    if (action == RequestInitTable) {
      _processRequestInitTable(messageByteArray);
    }
  }

  _updateAllTableState(Uint8List messageByteArray) {
    if (!listEquals(allTableStateCachedMessage, messageByteArray)) {
      allTableStateCachedMessage = messageByteArray;
    }
    if (!isCheckedClientIsPlayer) return;
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

  _processRequestInitTable(Uint8List messageByteArray) {
    isRequestedInitTable = true;
  }

  void checkIfClientIsPlayer() async {
    print('function MUST BE CALLED always at the startup once');
    int i = 0;
    while (!isCheckedClientIsPlayer) {
      sendCheckPlayerSeat();
      print('iteration after sending check if player message ${i++}');
      await Future.delayed(Duration(seconds: 3));
    }
  }

  void requestInitTable() async {
    print('requestInitTable Called ONCE at Startup');
    int i = 0;
    while (!isRequestedInitTable) {
      sendCheckPlayerSeat();
      print('requestInitTable Attempt # ${i++}');
      await Future.delayed(Duration(seconds: 2));
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
