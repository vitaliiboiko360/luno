import 'dart:async';
import 'dart:convert';
import 'dart:js_interop';
import 'dart:math';
import 'package:flame/events.dart';
import 'package:flame/extensions.dart';
import 'package:flame/flame.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/rendering.dart';
import 'package:flame_svg/flame_svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:luno/play/active_hand.dart';
import 'dart:ui';

import 'package:luno/play/player_hand.dart';
import 'package:luno/ws/ws.dart';
import 'package:luno/ws/ws_send.dart';
import 'package:provider/provider.dart';

enum PlayerSeat { none, mainSeat, left, top, right }

Vector2 getPlayerPosition(PlayerSeat playerSeat) {
  if (playerSeat == PlayerSeat.left) {
    return Vector2(-250, -25);
  }
  if (playerSeat == PlayerSeat.top) {
    return Vector2(50, -350);
  }
  if (playerSeat == PlayerSeat.right) {
    return Vector2(250, -100);
  }
  return Vector2(75, 300);
}

const avatars = [
  'avatar1.png',
  'avatar10.png',
  'avatar15.png',
  'avatar2.png',
  'avatar3.png',
  'avatar4.png',
  'avatar5.png',
  'avatar6.png',
  'avatar9.png',
];

const colors = [
  Colors.lightGreen,
  Colors.amber,
  Colors.deepPurple,
  Colors.blue,
  Colors.teal,
  Colors.lime,
  Color(0xFFADD8E6),
  Color(0xFF90EE90),
  Color(0xFFE6E6FA),
  Color(0xFFF5F5DC),
  Color(0xFFD3D3D3),
  Color(0xFFFEAF4C),
  Color(0xFF321857),
  Color(0xFF09685F),
  Color(0xFF5A876B),
];

class PlayerPicture extends PositionComponent {
  PlayerPicture(PlayerSeat playerSeat)
    : super(
        position: getPlayerPosition(playerSeat),
        size: Vector2(150, 150),
        anchor: Anchor.center,
        // scale: Vector2(0.5, 0.5),
      );

  var image;

  @override
  Future<void> onLoad() async {
    image = await Flame.images.load('players/${avatars[Random().nextInt(9)]}');
  }

  @override
  void render(Canvas canvas) {
    canvas.drawCircle(Offset(0, 0), 30, Paint()..color = Colors.black);
    canvas.drawImage(image, Offset(0, 0), Paint());
    super.render(canvas);
  }
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

class PlayerBox extends CustomPainterComponent with TapCallbacks {
  PlayerBox(this.playerSeat)
    : super(position: getPlayerPosition(playerSeat), anchor: Anchor.center);

  PlayerSeat playerSeat;

  var image;
  var tmp;
  @override
  FutureOr<void> onLoad() async {
    painter = PlayerCustomPainter();
    size = Vector2(102, 102);
    tmp = await Flame.images.load('players/${avatars[Random().nextInt(9)]}');
    image = Sprite(
      tmp,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(1024, 1024),
    );
    if (playerSeat == PlayerSeat.left) {
      add(PlayerHand());
    }
    if (playerSeat == PlayerSeat.top || playerSeat == PlayerSeat.right) {
      add(PlayerHandRight());
    }
    if (playerSeat == PlayerSeat.mainSeat) {
      priority = -1;
    }
  }

  @override
  void onTapUp(TapUpEvent info) {
    if (playerSeat == PlayerSeat.mainSeat) {
      priority = priority++;
    }
    print('player boundaries ${playerSeat}');
    print('player priority ${priority}');
    (painter as PlayerCustomPainter).changeColor(
      Random().nextInt(colors.length),
    );
    wsSendMessage();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    (image as Sprite).render(
      canvas,
      size: Vector2(100, 101),
      overridePaint: Paint()
        ..isAntiAlias = true
        ..filterQuality = FilterQuality.high,
    );
    // canvas.drawImage(tmp, Offset(0, 0), Paint());
  }
}

class MainPlayerBox extends CustomPainterComponent with TapCallbacks {
  MainPlayerBox()
    : super(
        position: getPlayerPosition(PlayerSeat.mainSeat),
        anchor: Anchor.center,
        priority: -1,
        children: [],
      );

  var image;
  var tmp;
  @override
  FutureOr<void> onLoad() async {
    painter = PlayerCustomPainter();
    size = Vector2(102, 102);
    tmp = await Flame.images.load('players/${avatars[Random().nextInt(9)]}');
    image = Sprite(
      tmp,
      srcPosition: Vector2(0, 0),
      srcSize: Vector2(1024, 1024),
    );
    // add(ActiveHand());
  }

  @override
  void onTapUp(TapUpEvent info) {
    print('player priority ${priority}');
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    (image as Sprite).render(
      canvas,
      size: Vector2(100, 101),
      overridePaint: Paint()
        ..isAntiAlias = true
        ..filterQuality = FilterQuality.high,
    );
    // canvas.drawImage(tmp, Offset(0, 0), Paint());
  }
}
