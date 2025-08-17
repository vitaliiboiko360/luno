import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flutter/material.dart';
import 'package:luno/play/player_box.dart';
import 'package:luno/ws/ws_send.dart';

class PlayerBoxNew extends CustomPainterComponent with TapCallbacks {
  PlayerBoxNew(this.playerSeat)
    : super(position: getPlayerPosition(playerSeat), anchor: Anchor.center);

  PlayerSeat playerSeat;

  var image;
  var tmp;
  @override
  FutureOr<void> onLoad() async {
    painter = PlayerCustomPainter();
    size = Vector2(102, 102);
    // tmp = await Flame.images.load('players/${avatars[Random().nextInt(9)]}');
    // image = Sprite(
    //   tmp,
    //   srcPosition: Vector2(0, 0),
    //   srcSize: Vector2(1024, 1024),
    // );
    priority = -1;
  }

  @override
  void onTapUp(TapUpEvent info) {
    // if (playerSeat == PlayerSeat.mainSeat) {
    //   priority = priority++;
    // }
    // print('player boundaries ${playerSeat}');
    // print('player priority ${priority}');
    (painter as PlayerCustomPainter).changeColor(
      Random().nextInt(colors.length),
    );
    children.forEach((c) {
      remove(c);
    });
    add(PlayerImage('players/${avatars[Random().nextInt(9)]}'));
    wsSendMessage();
  }
}

class PlayerImage extends SpriteComponent {
  PlayerImage(image)
    : super.fromImage(
        image,
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
