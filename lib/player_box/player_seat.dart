import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:luno/play/player_box.dart';
import 'package:luno/play/uno_world.dart';
import 'package:luno/player_box/button_change_avatar.dart';
import 'package:luno/player_box/button_take_seat.dart';
import 'package:luno/state/events.dart';
import 'package:luno/state/table_state.dart';
import 'package:luno/ws/ws_send.dart';

class PlayerBoxNew extends CustomPainterComponent
    with TapCallbacks, HasWorldReference<UnoWorld> {
  PlayerBoxNew(this.playerSeat)
    : super(position: getPlayerPosition(playerSeat), anchor: Anchor.center);

  PlayerSeat playerSeat;
  var buttonTakeSeat;
  var buttonChangeAvatar;
  var image;
  var seat;
  @override
  Future<void> onLoad() async {
    painter = PlayerCustomPainter();
    size = Vector2(102, 102);
    buttonTakeSeat = TakeSeatButton(
      world.tgm,
      anchor: Anchor.center,
      position: (size / 2),
      onPressed: () {
        requestSeat(playerSeat.index);
      },
    );

    if (playerSeat == PlayerSeat.bottom) {
      buttonChangeAvatar = ButtonChangeAvatar();
      print('add button');
      // add(buttonChangeAvatar);
    }

    world.tgm.registerCallback('seat', (dynamic data) {
      processSeatMessage(data);
    });
    world.tgm.registerCallback('seatAll', (dynamic data) {
      processAllSeatMessage(data);
    });
    world.tgm.registerCallback(Event.avatar.name, onAvatar);
  }

  void onAvatar(AvatarInfo avatarInfo) {
    if (playerSeat != PlayerSeat.bottom) return;

    _changeImage(avatarInfo.avatarId, avatarInfo.colorId);
  }

  void processSeatMessage(SeatInfo seatInfo) {
    if (seatInfo.seat == playerSeat) {
      // print('processSeatMessage');
      _changeImage(seatInfo.avatarIndex, seatInfo.colorIndex);
    }
    if (contains(buttonTakeSeat)) {
      remove(buttonTakeSeat);
    }
  }

  void processAllSeatMessage(SeatInfo seatInfo) {
    // print('seatInfo .seat == ${seatInfo.seat}');
    if (seatInfo.seat == playerSeat) {
      return;
    }
    if (seatInfo.avatarIndex == 0 && seatInfo.colorIndex == 0) {
      add(buttonTakeSeat);
      _changeImage(seatInfo.avatarIndex, seatInfo.colorIndex);
      return;
    }
    // print('processAllSeatMessage');
    _changeImage(seatInfo.avatarIndex, seatInfo.colorIndex);
    if (contains(buttonTakeSeat)) {
      remove(buttonTakeSeat);
    }
  }

  void _changeImageRandom() async {
    children.forEach((c) {
      if (c is PlayerImage) {
        remove(c);
      }
    });
    var imgUrl = 'players/${avatars[Random().nextInt(9)]}';
    var image = await Flame.images.load(imgUrl);
    print(imgUrl);
    add(PlayerImage(image));
  }

  void _changeImage(int avatarIndex, int colorIndex) async {
    children.forEach((c) {
      if (c is PlayerImage) {
        remove(c);
      }
    });
    if (avatarIndex == 0 && colorIndex == 0) {
      return;
    }
    var imgUrl = 'players/${avatars[avatarIndex % avatars.length]}';
    var image = await Flame.images.load(imgUrl);
    (painter as PlayerCustomPainter).changeColor(colorIndex);
    add(PlayerImage(image));
  }
}

class PlayerImage extends SpriteComponent {
  PlayerImage(image)
    : super.fromImage(
        image,
        size: Vector2(102, 102),
        srcPosition: Vector2(0, 0),
        srcSize: Vector2(1024, 1024),
      );
}

class PlayerCustomPainter extends CustomPainter {
  late final border = Paint()
    ..color = Colors.blueGrey
    ..strokeWidth = 2
    //..blendMode = BlendMode.
    ..filterQuality = FilterQuality.high
    ..style = PaintingStyle.stroke;

  late var backGround = Paint()
    ..color = colors[Random().nextInt(colors.length)]
    ..filterQuality = FilterQuality.high
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    var rrect = RRect.fromRectAndRadius(
      Rect.fromLTRB(0, 0, 102, 102),
      Radius.circular(10),
    );
    canvas.drawRRect(rrect, backGround);
    canvas.drawRRect(rrect, border);
  }

  void changeColor(int colorIndex) {
    backGround = Paint()
      ..color = colors[colorIndex]
      ..filterQuality = FilterQuality.high
      ..style = PaintingStyle.fill;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
